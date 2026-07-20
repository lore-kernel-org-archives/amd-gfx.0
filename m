Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255D7C44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 17:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9561110E1DA;
	Mon, 20 Jul 2026 17:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qP/+Qd/E";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C49710E1DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 17:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/aaUy9Z/3JwOOlcmZxeyDr7yzsb4lck/ioeNXprZfygjUxRSWECQf2WtU2nTfnkE+j1iJJrzubjWnlA5wIgooY64xOsP5RZODfH+2ornRCahbxh3oJnT032AOZE3s1NPraRCjX1MfqBUDEtgKe+WKS3saTjlbYwHD/Z0A060Kk7tsiP6Mmuq60WEYAtKnV/W1uW7/J8jUz1gYEEsFweMZsdlphwNedsl4l731YFYZwl8MBPxo4DHBYgV0ZJCg8cGZb4ReNsrNAEvdx5UtJFdtrmsOFlUnWtY+aWbs7WWUyHsxoplWUg/uF3t+WYxxl3Q2+qHSAUMKFs6orYSiRzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anMhgs64Ofn3DvqcOxXR4PQ/xd1p6bKZeMIzMAATIac=;
 b=vkXIxg+IhTQELeJQImpCe+mPZI1N8N9IQjEqolrpzdixy/bNOvBVQq3HIQn6NWEKbHa4GfTKuoof5IqwQ/Q7IDVac0MN3X3zHYT6nGRB3ouLt8CA8FfDSZhjKTqQyx/JA8/ixrQhMlkc6M3Wn72F2xpwsp2FalJ8sFzx6Ixbm9H/OIyxcFHFTKcJvCix4HUZjNWeFAfCfsS6YRfCnwgo5Qa2S2dcYJVMLSIc6Dgi68QiELfRZosQFPeYfbMlbWsFQyyav9jx+VGfDwU1V60CNcf78wx92NyxWA6VHeHFxtmoSpxxpsyWZktSKVlWZi2Bjx0/wNq3SEK2QFINutJNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anMhgs64Ofn3DvqcOxXR4PQ/xd1p6bKZeMIzMAATIac=;
 b=qP/+Qd/EwtyAmdBr0Szu12adSJmj1UgX2SrhMBxHx0ExvTJvUddFU2CceOA/gZvSUGv+ZnS5Hry0YibDPmraXQvwhMGG2zo1TRyzZl97afc43ly/V1vJ2ghNZdoijBtDAORN2KvSl+2QMTVlH2EPNrTPXXDpcXtSf4dPFL7KxII=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 17:42:01 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 17:42:00 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Palacek, William" <William.Palacek@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Alysa" <Alysa.Liu@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: allow CWSR grace period of 0 on supported
 firmware
Thread-Topic: [PATCH] drm/amdkfd: allow CWSR grace period of 0 on supported
 firmware
Thread-Index: AQHdGGMyTrQT7/24y0ePNYiB6l6YxbZ2rSPA
Date: Mon, 20 Jul 2026 17:42:00 +0000
Message-ID: <BL1PR12MB58986C95CBC3153030468D8A85C32@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260720161552.744674-1-William.Palacek@amd.com>
In-Reply-To: <20260720161552.744674-1-William.Palacek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-20T17:41:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH7PR12MB7113:EE_
x-ms-office365-filtering-correlation-id: 0aa56ff3-d59d-4968-840d-08dee68633db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info: CfKkVj975lsECqB8diPeQhOGNIvv1b3iXLASWTcklwXcZ7ABHjLHAA8K/K+NcDIIBJ8/lGPej78g+JLKLSLj1yz8GAu/zhsNQ/b7CTZN02LukCDQVKhJ1A/HwTn2blQ8pn69aX/fRBPrAhiO2haMFSYbviUjJ8cTWIiGVzMmCKta9f4nDLZx2xFdU+aFELtXxqNPhP8vOZNhaNwageowW832rQj68TChuiFCC00eGoHGwmoas3ccTf9FSC3RJ8Kzm8sejPXhr54/VzzFe56eRNk11JgDpgoEVHpsmjnTbNlxkQO3BABp785qp+8nY29AlhjDmt6CfRpuy7k8K5zGcB3g7SVy70ENYFEQKNPN2TUavYiGc1c/hlBblODYY3X18Qn9bm4y83C4vZBadS6cbYrCegcDiClpZiErLwHxiTIH+tdtld/u5eAcOyc1PYjRUSzCXe5+MtCNLfDpoHzc2HLFSkgHJqDP2v3KMQS9T9pCV7gSJ/ujdHs/wRfqX1fYQS1HQ5O47c3KS2BzyVnSVp0F9cQZ47qlqN2ARNshEGTjpPwjWR3INQxPjTGos6wVC6fzE7BcIc24mz7hLdTSBetIXsIeWCwv3VQij689yBIdUcgBcJjr1PGwtdiotUnzvKwZF7yLFc5p3uHIXhLC4J+wzueQcFbAv/Yj1fw+9gztIXtNHfuW3KAhk4iFqzGkuo3vZqliW+CutChwjUt0hShvPA0MeZZNNsaVMr/h9k0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2RxwBSF1f5T9g5+Wsp4RLVK2gHapUBUxcaDBevAjGpfbR5lCZEqdzfvxkYhK?=
 =?us-ascii?Q?GWqflcbnswl7bhi6OHh+tQvYiZRxtrAyjympNuf1paB6RnCjWbuus5Ez9Wcf?=
 =?us-ascii?Q?Q8WQnvSklAwZ3fxqSAToqpkCq+QCDCfVqpAO/dTBSD8esyAKcInTSLBLFgmS?=
 =?us-ascii?Q?7+fIurUksWByfEJf9kz0c5nFIX0S3jvPCIESLIy7EO6uWy/DkGdpnYgUb1+v?=
 =?us-ascii?Q?MRLq7Ql8xT0iL7kUccYjqr9HyLM/Umbp2521hegE00aN92N9afcuuhe/axY/?=
 =?us-ascii?Q?amLJoVLzSphIPrefIQ4pVaeh6Nntpy6dqVNdufXcYa3T2Mr28I1e6789tfLi?=
 =?us-ascii?Q?IldoZD2FxB2hb7GTELi5tWB6ul1Jt+4zs4mIuya8CkgOx+B7DXPHVDPDV/Ow?=
 =?us-ascii?Q?M4PvOYPjBA2rRhOHAwFQC2G1hNZz25fA39tWQ/3xdwrQUUmEC0eFkECCcNch?=
 =?us-ascii?Q?G9FVQ3Ykas5wmmzVDbNeo7BaYP70d6iJpYE07PW0Nuf7GhYdBGeNTBDKFqqw?=
 =?us-ascii?Q?J5iG+xqYSwqjLwKXft+vZMgrZncJJ1254Rpkpny0TwPnx1pl0QDfefuL/aXs?=
 =?us-ascii?Q?iUHQ+wU2M8fNMMVXf1dLoUh11cnZi01mxjK6XoeJHrGGMcUkhgi7661bSDRQ?=
 =?us-ascii?Q?2reEJ2cqi5gd9pFZQD3rMKPPnF8YN7QKgovFAmy43qWwjDWVLxRWA/6ZIUAB?=
 =?us-ascii?Q?Ppj/LddWf9xmz2zF/EjlajB1XhEXTtFFjaPlsiKrOnhUbApF9ieD6eeSMgze?=
 =?us-ascii?Q?6mW+xWv4kG7o1gN9war6pjCRRFbvCejYW25LwI+IwUaOnbbKS9l6FPyoqsR/?=
 =?us-ascii?Q?CJ3xPh6Hosq/dFPe/irBwn0hhg8Mhe7l13P4JcG2twBG0fX2d6snWORLqkLp?=
 =?us-ascii?Q?8h+r5dfYLyNaUoSgntwgBqOQTcNpnr8ezV6v6vwYoGIdr1y3Wr4OAnSdyTkA?=
 =?us-ascii?Q?O5IcNtywGhsIPQd7QzG53GK08ZdJyz4jUHq+FlBX0xWDYTgigadnjbOMuRP1?=
 =?us-ascii?Q?IhwCUkiXOCqBuDs9RpD7fzXeEzPacLurAYGYoM4ER/2UyjHoHqw3s19ZzIFx?=
 =?us-ascii?Q?O2tP0HFrUCkkeKkRNjSLGc1hJgNb4Km1SBnj2WgcGWeYRsWaWXsjZCTF72dS?=
 =?us-ascii?Q?VLQnDMWTxXaIW9HlYKWLN6aqnNZ33wG2UAvlrki+FfGbOdnzqrqj4wUf5fLr?=
 =?us-ascii?Q?wAmWy6vaJgdQ62BOClB4KsYlLQBqERtZ2Tir/xjba4v/92UOAJ3hb0h/30qy?=
 =?us-ascii?Q?vxsKeQ0LywHrAMkhjVfUYirI/CUj/rE7kje01zZ5iajOqQgKZpyJY1QBCrpl?=
 =?us-ascii?Q?AzO8DEylka78G69Vsx9Wra31diLiwA3TQcoVs1ZXOkobiqvSjCv6r/j9SYoT?=
 =?us-ascii?Q?2Pktlbp163Bf6kc4rxSkZWJHVrNVj99+ZdEz3U0tk3rcxDVA74wg3gFUSmqx?=
 =?us-ascii?Q?AejGwJogAlrodXq49jIO8a/hh0LNanRfF+MOGsa8JDuTZ8ZhxMkO9p6HUM5C?=
 =?us-ascii?Q?yHQGEhPRyXjJ2VqbS+p7GkBKgqkLy98uPHP3pykvi7T8DaQ2OO4Yp5GHN6pX?=
 =?us-ascii?Q?c+gRKHUu5FzIhUdhoYHcKM+UG3zZNvUKSlZAIBVI4Kce+P80sTLdbvoiGsem?=
 =?us-ascii?Q?Ga2UwYiwJG34QYXj0WtC3piMUuzwhOiCReCxnjjqPIPKzvl/2APVbt1b4EIP?=
 =?us-ascii?Q?f3o4sSDuwqQux7RmAKa//nWONnUh+wO3uKj8x74/WIqZ7IvQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa56ff3-d59d-4968-840d-08dee68633db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 17:42:00.2917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rNeegCGyRNEpwT0GE6GTMl4RUGdv388Vh4lLE8umB5RHQpxu9V2W7pYJaz4nM3AFcv5DQIe9eKz04QuZt1V3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

One quick check in-line

> -----Original Message-----
> From: Palacek, William <William.Palacek@amd.com>
> Sent: July 20, 2026 12:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>; Liu, Alysa <Alysa.Liu@amd.com>;
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Palacek, Willia=
m
> <William.Palacek@amd.com>
> Subject: [PATCH] drm/amdkfd: allow CWSR grace period of 0 on supported
> firmware
>
> The debugger sets the CWSR grace period via AMDKFD_IOC_DBG_TRAP and may
> request a value of 0. An earlier change clamped 0 to 1 unconditionally
> because most firmware revisions locked up when given an infinite (0)
> grace period.
>
> Firmware has since been fixed on most ASICs, so gate the clamp on ASIC
> type and MEC firmware version and allow 0 where the running firmware is
> known to handle it. Navi3x always supports 0. MI100 never received the
> firmware fix and is kept clamped. gfx9.5.0 and any unlisted or future
> ASIC default to the safe (clamped) behaviour.
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 66 +++++++++++++++++--
>  1 file changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 3d2375817c3e..e4092ba81fe5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -309,6 +309,63 @@ static inline void
> pm_build_dequeue_wait_counts_packet_info(struct packet_manage
>               reg_data);
>  }
>
> +/* pm_grace_period_0_supported - whether firmware tolerates a CWSR grace
> + * period of 0 on this ASIC.
> + *
> + * The debugger may request a grace period of 0 via AMDKFD_IOC_DBG_TRAP.
> + * Most firmware revisions locked up on an infinite (0) grace period, so
> + * an earlier change clamped 0 to 1 for all ASICs. Firmware has since be=
en
> + * fixed on most ASICs; return true only where the running MEC firmware =
is
> + * known to handle 0. The +32768 offset on IP_VERSION(9, 0, 1) accounts =
for
> + * the SR-IOV firmware version encoding.
> + *
> + * Navi3x (gfx11) always supports a grace period of 0. MI100
> + * (IP_VERSION(9, 4, 1)) never received the fix and is intentionally kep=
t
> + * clamped. gfx9.5.0 and any unlisted or future ASIC default to the safe
> + * behaviour (clamp).
> + */
> +static bool pm_grace_period_0_supported(struct packet_manager *pm)
> +{
> +     struct kfd_node *dev =3D pm->dqm->dev;
> +     uint32_t mec_fw_version =3D dev->kfd->mec_fw_version;
> +
> +     /* Navi3x (gfx11) always supports a grace period of 0. */
> +     if (KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0) &&
> +         KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0))
> +             return true;
> +
> +     switch (KFD_GC_VERSION(dev)) {
> +     case IP_VERSION(9, 0, 1):
> +             return mec_fw_version >=3D 461 + 32768;
> +     case IP_VERSION(9, 1, 0):
> +     case IP_VERSION(9, 2, 1):
> +     case IP_VERSION(9, 2, 2):
> +     case IP_VERSION(9, 3, 0):
> +     case IP_VERSION(9, 4, 0):
> +             return mec_fw_version >=3D 461;
> +     /* MI100/Arcturus never received the firmware fix; keep clamped. */
> +     case IP_VERSION(9, 4, 1):
> +             return false;
> +     case IP_VERSION(9, 4, 2):
> +             return mec_fw_version >=3D 63;
> +     case IP_VERSION(9, 4, 3):
> +     case IP_VERSION(9, 4, 4):
> +             return mec_fw_version >=3D 96;


Is it 96, or should it be 150 (0x96) ?

 Kent

> +     case IP_VERSION(10, 1, 10):
> +     case IP_VERSION(10, 1, 2):
> +     case IP_VERSION(10, 1, 1):
> +             return mec_fw_version >=3D 146;
> +     case IP_VERSION(10, 3, 0):
> +     case IP_VERSION(10, 3, 2):
> +     case IP_VERSION(10, 3, 1):
> +     case IP_VERSION(10, 3, 4):
> +     case IP_VERSION(10, 3, 5):
> +             return mec_fw_version >=3D 93;
> +     default:
> +             return false;
> +     }
> +}
> +
>  /* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
>   *    register/value for configuring dequeue wait counts
>   *
> @@ -357,11 +414,12 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>               break;
>
>       case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
> -             /* The CP cannot handle value 0 and it will result in
> -              * an infinite grace period being set so set to 1 to preven=
t this.
> Also
> -              * avoid debugger API breakage as it sets 0 and expects a l=
ow
> value.
> +             /* A grace period of 0 requests an infinite CWSR grace peri=
od.
> +              * Older firmware locks up on this, so clamp to 1 unless th=
e ASIC
> +              * firmware is known to handle 0. Also avoid debugger API
> breakage
> +              * as it sets 0 and expects a low value.
>                */
> -             if (!value)
> +             if (!value && !pm_grace_period_0_supported(pm))
>                       value =3D 1;
>               pm_build_dequeue_wait_counts_packet_info(pm, value, 0,
> &reg_offset, &reg_data);
>               break;
> --
> 2.34.1

