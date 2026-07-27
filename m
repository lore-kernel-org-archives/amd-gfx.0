Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB5CC531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 18:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B00C10E0C9;
	Mon, 27 Jul 2026 18:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYPW/sgU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459EA10E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 18:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emmLt3K7dOM2i7Aw3KNOF4aEnputqxEhJ1KuXx6YqzjD9iI5UUG8Ht6s3FPv0aWmLBSx+97Bw3/q5N116WY2spy2kZuW46q/IAljuejyt6kh9TRS0F/VIk5aWntj5yMbwVoUsncPKiDc8RBnSDIvXlEBU6DtPD30AuLIBSaNNVqvEvYgMUtnu/+ZJPWGrKco5kegAXA3eWMtudx2LgTt5g/TBiywd9Im6ZWdyRWgdzoQuYl5KSJgat++GMJM1NvsB1akZQl0Sl6J00no+DfYQcmZtLPLqCQoipBEAs+jWux0A3bqrWZYIpSrlsOO2EfN1LydKwyi7q8XDjo7QYZJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blbe2MBpW16rcm+2F7jPDSv5boiLUoqVPufv4b64ZkI=;
 b=ooOl/XrNRXxELfOGz1uBDGvp/AWXf11FawMZTpJSvzx7oGq/kb1L8rYG0KKAw89qRn7lAcpmskYDZNg5GIhjVxBZ50aRF0sUToGAk6EWUJeYw2Pf+59alEQW1Kp3nxU0Dfzn2L8TKv0YGCEkPVqH3lxzywvnk7kkRct/yAPmIooFxc/Uj3QsNgpdePuAwuVLAI0lTUiSAOBd700qKP1TVeyDYifpqvwrjt9IBgsj6P75hGcxJxBDKi1H6WKG36SNw56NzTacqor0bhOWTJJUhF3gzEnopnH1rSgP8slWNkJ8LOrq/q6HlAv5xEacSKdoMOt17ECKijLWlN5gAB5dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blbe2MBpW16rcm+2F7jPDSv5boiLUoqVPufv4b64ZkI=;
 b=DYPW/sgUUJ+q2cM5f9vCDf1bwIhshrZgSiNeBRpLjE0pr+DeR8zkB0vI8gRkr7usyS/3w+9UX4fqJFkNelnwZp8TFM/eUS5iP6Bu3j7ZOI1CsTmz8hCwlvfhDxoPt+HMViBSxQcYx80iCBrMZjiuQCMq0jAMVd0OU9eyMQs2xjc=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 18:15:39 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:15:33 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Palacek, William" <William.Palacek@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Alysa" <Alysa.Liu@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>, "Palacek, William"
 <William.Palacek@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: allow CWSR grace period of 0 on supported
 firmware
Thread-Topic: [PATCH v2] drm/amdkfd: allow CWSR grace period of 0 on supported
 firmware
Thread-Index: AQHdHe1Ahc7QJWoT/UiGZGV2hHYNPraBq86g
Date: Mon, 27 Jul 2026 18:15:33 +0000
Message-ID: <BL1PR12MB58989EB121326E9FE6A008B185CC2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260727172729.2173487-1-William.Palacek@amd.com>
In-Reply-To: <20260727172729.2173487-1-William.Palacek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-27T18:14:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DM6PR12MB4219:EE_
x-ms-office365-filtering-correlation-id: ed0cefbf-9686-4f36-2013-08deec0b0cba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|10067099003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: nFxcfrj/LSbQSnFwEK26Yfnpb5dQl6CFewNqlwzj2GWsodT0RZFr4R27CqtNqVj9C8MnGlXhB3Q2z/STn1CsC+n00KNVQDcImjSO3alAgQ6dNHC5O8axPO2VRbAqFc0JOE1Qip0CTWPCX50FmoHOn7d8x50TuTEIrgjGuKGV4rOqVTlwRrB7rt2aqtmiolRys/cbuNBTAwuqxYw9n8qoKX7G3yr/12xC6LVdomzyJ6wfOOGzTf1OrbUsCPmC7aGYK/o4oNWUIRq2BhXu329Y5RlNtLkbntMx8iA7epIT4Ejb9vu/7ghohprUF51pq60Y327kqTu+uvZwJ0Wn5eEV8LPgv4YrxTs19cwnTFKGOQzQzn/ZauTgvqGXswY15avyP7jxaE5WfieOBBnu3RiHHOIBKv0A8AZ0CTFUUNXizBtyeLbrWUErFEf3Lb4TJ9VcDni+qcpnSpqAuzluScpAJM2kOVUbiRdaFn3zojeb34Bpp/gfYpm8ys/GKcTJXHD2RP0wjywl6rX9wYpa4pRadCmoi0DqaX8cNLvyoe9H0LDBCzCWsHOiArNBLPOYFB1EXTp0MgqVN/qjamv62+hlglf6PIp4PCq2L0jEeTxXHL6dZ3UNKnv5c5XqGkhwPZgyyFkT043JsIqRRDvp9ujUnFSDg1M8iL+ByVL7r4twRQyFbjx+qrBc8ZhkGcv7mWB2WuS3Cc+VMrHXf/ZXH0k1dkvR8dKW7F6iRk1FPgl+BSU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0pIVKqJ76BcVecl+3Ybwt15nWL0eaE9YKn5BbCZ8+lbAvHynbSWD0d0eFUyJ?=
 =?us-ascii?Q?a9jz/p3yAG/cF6Dlu85IFhsZsX/MOmz3dzan9KxMge3YcclIVghNM7uYE+uh?=
 =?us-ascii?Q?EmPnCISpUOJJf3BN+UKNxMOdRtNPsUqsEcj3+8rdaKWUae7f3EEcQSjo3uHA?=
 =?us-ascii?Q?o5sHEom1dWNstSJnKR5P2mqs6uCafRpaj3NW9jqngqkzb4QFa49qTAuD5GVy?=
 =?us-ascii?Q?HMESYPMyNIXX+V9yF1B7NAO2VDcLSjLZPQHZOfP2wPXKFjS2cQuPbapZdxsN?=
 =?us-ascii?Q?/gFhTljFVK2OlEMgFzqr7pz/1AzxEDyRVbNJPXThibn25RVCG0rfGJFlZ8Ks?=
 =?us-ascii?Q?RN4iHcCDwDKfgHhDA7Vcvtb+ssQwANlbxvTGJ5UZPphg+nOZjDtK9I9VjRyi?=
 =?us-ascii?Q?1hrgBxnt8Vt/NePXONCNqmPhr9+k0/iNsbtijWaLLdx4F26hVWbqTctGz6R/?=
 =?us-ascii?Q?bHV/8tbLfFebI2L20Zv+nvrs0FZCAI/9mDVedoInMyhspJvHHzXYUTqKjuoB?=
 =?us-ascii?Q?WTbGo29xGC1ROpvuOaYzF/42ednYcRh6Ks820bRJrFxwSlJr/b0Ck+0HIIcK?=
 =?us-ascii?Q?WG8wy4S++OA5lTJs0S1qmaRupjFeKFf5DURFy64pDIrjtIgN2ewSGKiON6aq?=
 =?us-ascii?Q?XK4bWkY+pH7hO/384U/C5eYKZf327cC78BZAT9XqXMO4Cgnvw8C/ZGhinbzL?=
 =?us-ascii?Q?B+J2GabTbA2nDlg8z+CXbhAm8K5H3aeg+SHsH4pLCNk89V5PwkyrEk2VPsqt?=
 =?us-ascii?Q?wvw8dEGkuUjr/zGlWqDm534ASs7LRoqSWohtCl7KSSIo9JbBstij6b0bDW3d?=
 =?us-ascii?Q?neuls9GW5Td6MasQOdNxYQDyGJ3IayNfI+ioRGvpUpE+xrEXt5B/SrDIfeYz?=
 =?us-ascii?Q?foLEJWvGqxNgmUzWByi6pEcSbraKK5ld6W4lb7WMVpfH6LDe3ushC/OqiVCj?=
 =?us-ascii?Q?oq8XFIJeIsZlqnm3Bd97eEKxZhRc3TG7bE2Dd1p9vpzK7Aw0OtxDfSgrF8ZL?=
 =?us-ascii?Q?RtV41/egroAoiKmVgwc5F6PINcFc8H4uNxARB1f4xzTob3s5pEPhaWJOWVO6?=
 =?us-ascii?Q?wfLHV4kIhFKZs6hHQJd3nzs3J0EJg4HruUbiG0w3LhMNrufRgs3HjesZmvo/?=
 =?us-ascii?Q?1L3w8ihYezXTmb8w0KARi1gJdur3eH9f9QrvRENak1q4jDPYawPSEhTU8Fa7?=
 =?us-ascii?Q?kES4ii4niMD+ppmuOA4HtYmiZhTOn2CPmfRkBJCk25lPV8J97S6+eH+wCza7?=
 =?us-ascii?Q?dxFdUPkUX1GSFj9xE6W+hKSghoauJoKMuAVufivOMfIrksfYhUewKXgmyB3w?=
 =?us-ascii?Q?MaYAxcfcJobVVWA3dj5ioKx8AjPC7WYC+2wXcbuE5p5+ZId2mAQUTrmoSdGC?=
 =?us-ascii?Q?Y7UAbA631W91V+6zRtiia+ZOWhk0xEPB+1QN3NV0Cl+cgbHJCYO8DnspxC98?=
 =?us-ascii?Q?tmWPASY1qNu50boN+bw7Z+jx7GuZ2wpeYj6yJHmkkdcpjSsi/a2zePIZ2ycX?=
 =?us-ascii?Q?AuidQQl/W3uqy/ccFhGiD5yiM1EWL8+P86K8eP9wDcTtCkBdoTsPZxp6uJ1j?=
 =?us-ascii?Q?YwrAvHoaB0+t2njVeR88L+358s8DpIQ/tbfY2NUFRCjlXoWoFtmLUE2tZWFM?=
 =?us-ascii?Q?VVIIxYIHx5xNtJNvcfxa75xRwGGUHn/8RvCIByBJJj6oz9hY0wt0PsXsB7pf?=
 =?us-ascii?Q?Ea07rXpz+631LjTXfrBwvvdyGwnrqjvMbXY41F2KXicMWAre?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0cefbf-9686-4f36-2013-08deec0b0cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 18:15:33.5424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rl5LM6pFLZuy4mHzzOktUx9VDtyNvE+ExeeCp5nxr/kWIHLiFpvl7k+T9EdyQHx+G0pUNpmXMTuRp8nrHN2drg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

Looks good.



 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Willia=
m
> Palacek
> Sent: July 27, 2026 1:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>; Liu, Alysa <Alysa.Liu@amd.com>;
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Palacek, Willia=
m
> <William.Palacek@amd.com>
> Subject: [PATCH v2] drm/amdkfd: allow CWSR grace period of 0 on supported
> firmware
>
> The debugger sets the CWSR grace period via AMDKFD_IOC_DBG_TRAP and may
> request a value of 0. An earlier change clamped 0 to 1 unconditionally
> because most firmware revisions locked up when given an infinite (0)
> grace period.
>
> Firmware has since been fixed on most ASICs, so gate the clamp on ASIC
> type and MEC firmware version and allow 0 where the running firmware is
> known to handle it. Navi3x and MI350 support 0 in every firmware
> revision and need no version check. MI100 never received the firmware
> fix and is kept clamped. Any unlisted or future ASIC defaults to the
> safe (clamped) behaviour.
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>

Reviewed-by: Kent Russell <kent.russell@amd.com>



> ---
> v2:
>  - MI350 (gfx9.5.0) supports a grace period of 0 in every firmware
>    revision, so return true for it unconditionally instead of falling
>    through to the clamped default.
>  - Confirmed the MI300 threshold of 96 is decimal. No code change; all
>    thresholds are decimal and unchanged from v1.
>
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 70 +++++++++++++++++--
>  1 file changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 3d2375817c3e..54868b81086e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -309,6 +309,67 @@ static inline void
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
> + * Navi3x (gfx11) and MI350 (IP_VERSION(9, 5, 0)) support a grace period=
 of
> + * 0 in every firmware revision and need no version check. MI100
> + * (IP_VERSION(9, 4, 1)) never received the fix and is intentionally kep=
t
> + * clamped. Any unlisted or future ASIC defaults to the safe behaviour
> + * (clamp).
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
> +     /* MI350 supports a grace period of 0 in every firmware revision. *=
/
> +     case IP_VERSION(9, 5, 0):
> +             return true;
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
> @@ -357,11 +418,12 @@ static int pm_config_dequeue_wait_counts_v9(struct
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

