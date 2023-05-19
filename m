Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5B3C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 02:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5466310E59C;
	Fri, 19 May 2023 02:09:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7CC10E59C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 02:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPO8CtFQLRb8nKy3f5m6wdYuU+7olgPkMjdZyjBwd4Yae8n4171ETNW65gI56Qi0znvBZB7zUJToRDbdIDq4ZhFmFrBzNLxgpS+LfFyGPfxpjEi5ri8weRx8ToFiiaPR6c4do/e93taPR8f0/+3BnSGL3YrL3gkt15wTwryIl6QYMJ90R/NGDN6lD58H2OO1/za66wBfq5SW4liBsaov/hFE626i9nVfgr86zG4io6luELrfJrJTWVR3N5MBO6lTGNilaQJ+Gzlp3wH8AyN61ufb8dFxk3aRWe/I/i0XIx4+Ul8PUkb7P8/86UdjUK5bpG+uvewgKPsoVYZliFQuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UTm2SGzbg72VYyQ1OEOj3j9rzf/oACYtxNVMnCaUHk=;
 b=AHa9w+USw+6GgeWdgl3LB13Byc9PKhGBtwXFlvynZm6/lMIWASqVkaA3AaLEL4qHwXo0o3wGqahF5AH5KV6VEuFMIm4zbkBLHRyog0Tn601xJKO4ytReQxAen6T7+eo7/XyN197MG1loFetDiDsfUlBYsXv8HavMAT8VRbZLcdv3oB63jdHqqEwGv6l5072MJe13XJNq/g88BxrxkVSzCgo85xRkaNhP1/xJgv60IqyLEsRfot5tGb96zmdB3hqe28QM5zoJt2c+91KAqlsV2I4kIoMkqJciFt0k2p9RZnAHEpfW3rUkI8QxckK6HEgulPC+jqhOe2HIG1iIAJmmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UTm2SGzbg72VYyQ1OEOj3j9rzf/oACYtxNVMnCaUHk=;
 b=m+jwsSte2FP0tXoqFzNFm9mUcXWOy26PvQdcOfH64kK/zYH8oOEVY+VCE092yIPRPswHb4Xeks13viM6oLFgP1fMTOS/G3WTm/eJkP0kOlt9tvkQQb6wMhM+oqcCI+JFDWWjbMR5yYEKjg29mCnFKjqE7DfT9EzcUtifnHPUoG4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 02:09:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 02:09:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 5/6] drm/amdgpu: fix the memory override in kiq ring
 struct
Thread-Topic: [PATCH v2 5/6] drm/amdgpu: fix the memory override in kiq ring
 struct
Thread-Index: AQHZiYNYo2fhw8pB20mG5V9W6e2LLa9g2qmA
Date: Fri, 19 May 2023 02:09:10 +0000
Message-ID: <BN9PR12MB525791F447A719899CE9ABC3FC7C9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
 <20230518122059.28815-6-shiwu.zhang@amd.com>
In-Reply-To: <20230518122059.28815-6-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T02:09:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ba657541-1dc5-4a34-a366-f3432b4522fa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB9049:EE_
x-ms-office365-filtering-correlation-id: 6a9ccabf-45eb-44ad-c97e-08db580e08bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdgtnuHGkv9YSKNNNTzAiCokq5sxt7narIMRipM9ONDP7BFIpM5e7gFAnGH1rqOafQmyjh51b4c8dXSuYI7AGxt6xkSS0kEym/ntFlr/nn9y0Mn3xjY1GmbJXPz51lezVxX15NdLR45YNiyS6mPNqc5DfArYdgG/Y6ObYXavA23G+tEcgJoU9jR3g/Pfemv18hu51xmP/61q3y4oiQY36CA09MAKp3+WrXR5FYeuSQNMD7torwo2ly7HBxA34hl9/0wUaGIZMe2LJtleOEM4iCUnBGmepcXVA0tplQkwqxBEFCtuf/yEnnBouPvyWEe6DzSZIKghcUI9g5bTby0rsadG174kgQPjUkd/Q+QIw624Jfl/q1HlmpzfOVqLRVASrBoDrCgSyGNDNojBSHjTca4VyNVAibCk8WBbFqMSNqiSm1Av9d0KRSQQCJJ8Eb7qQ9hmTCAK5gL0GHTitC9NRF3gBoYWHTr89TNnAPcuen9ZGgWxety8l1FETDuK29uIkY1Qyma5gAIIvYbw/sHtiklfHxlj5PiKZbwxeYvP3HvATgOxnFg8sKqsZgoh4cxR1bMYnpg+ZHZX0EohN8unYlXX8Ndo/zv1X3EzJhAMhZqBftY9IoTI8mODXsOEoUra
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(86362001)(316002)(110136005)(8676002)(8936002)(5660300002)(52536014)(66946007)(41300700001)(38070700005)(122000001)(33656002)(38100700002)(64756008)(478600001)(2906002)(66446008)(66476007)(76116006)(66556008)(7696005)(71200400001)(83380400001)(6506007)(26005)(9686003)(53546011)(186003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GS+ezB+BwIKFthncfgm1uIqIbmIL2EUME90afmxcbIZSUVzPlB4IaDro9vNy?=
 =?us-ascii?Q?2guMPovhWOgdv74Ud6NiDwAAvZzMvBrY3LU4IWwqUBs1lcejDg77ZsjBzAET?=
 =?us-ascii?Q?4YIgS/o3Ft+VtJkuflgCr2ZB7I685IZ5HT6rSysPUPu+MTDBFjZHgOdZ4U1/?=
 =?us-ascii?Q?U5cKZSFgiSzOYBrAm5APdSZP3/J6BMfR1ZI014EZSSDL/lW7wYXsHjgDV+VH?=
 =?us-ascii?Q?My4ZbV8wEOAkdqHJC4SYIDoKesuXX2Q2cJ6NWBM1sKuCuSlorycU0jqjUrgw?=
 =?us-ascii?Q?FByq+7tyE5+3wrrrAsXrEF2VL5yBwKS+eBq8fYszC4BfFjc6zk343bc0wpl6?=
 =?us-ascii?Q?mkSe1CUNeDTpIOEpZAN0WO0OnRoerDKKP66pbPXt+ZSk36zks4/PSn8dtMwy?=
 =?us-ascii?Q?scEzzN4u5Bdck2i6dr9nbVfS6nHDsaJRwWPjTsV0EUmEAmjFVZ7pmc6cnadw?=
 =?us-ascii?Q?ZMGk6HgYHLZOW0LMarSIYrHqgQMz1Tr3J6Yh0TCx038w3G4BxSIStxdWacqm?=
 =?us-ascii?Q?ItCgSK3kkxKLrQ3pBhjW+7cvfjaqpHFSQyMxcPNaxkCFojXpjp55A27Jf6fx?=
 =?us-ascii?Q?k0rblQfm/KaZuWx5U/egXvEJrtyM0jbFHdnudOdYlfj85RRjJpp24DeEbtxI?=
 =?us-ascii?Q?ARnNSFOGNZF0UuYWb52lcOEiDbW3ycgG82jDOIcvCSIlPTCFsz5Hew/905Lz?=
 =?us-ascii?Q?b/VG2QS7+T9MTV36rXFLTG5ItPIW0RionrC3I/mahxy0bMT79rGykn3BUaFw?=
 =?us-ascii?Q?VQv2/ENcFIRIHEANitd713v3Qm/E1IfMa/i3IoBG0tXvv1OhnC3F05tj2jGK?=
 =?us-ascii?Q?Cc7efP0byxPtHYDoP+zij8jGUfbP6LckZZUQ4l+Uh8/Qqb7Exx5dU+7Vg/Im?=
 =?us-ascii?Q?uouqcP/o7uiNH+QgZPHbK9MKy6jHycModGtInFpn6mDbsou/sRC+hi6zjvZZ?=
 =?us-ascii?Q?NfZ4gMBTzolFytIo/IKYrk9vyQq2Xp9hVHgcRJNRrtwaQ4zGLo/h8GjGasa8?=
 =?us-ascii?Q?RvciEkn+y3U4j5M3SoNU+mitLIkxiIwMnBYCov0fpSN9qNqXBw8chhBVwdt9?=
 =?us-ascii?Q?MraC4m4aurv+xuqOr2wOIK+pstFhWkZiNmZr3j7c0XOo5dCaVskIfPi++q/I?=
 =?us-ascii?Q?bE647J/4u/NQIqUvOvSaCRxznbc86AkEZMyAgp17QqS8foIF7MYVZGQWmRQI?=
 =?us-ascii?Q?K3v1q7jsfuf14aTwfCk6sJm30ZcIao4/uezHiRHBsRrsS4T6CjjldFVaveC6?=
 =?us-ascii?Q?Wb2RRT8RQKH72sgzxWRwRY9qTMjCRVW1WUvCqQ0yAm3sJoTazNK8t8Vmly7i?=
 =?us-ascii?Q?4sTy2KVywTwB/NRGddW93A2L7x+n9RgRz5cpPCCzoI59tg0q7nVy2pnAYykO?=
 =?us-ascii?Q?r9hTsMTsyAIyfa80bAWjN+Ma2+LnFy/fp0Cagb3PjnVEM6EVznAN1lHFElDd?=
 =?us-ascii?Q?fwWtvygnFoWwxThRPHptuefNjsbSirosJyZZdTV+IBpwKHeoxTI4CFGV2xv2?=
 =?us-ascii?Q?unPN1PHZwQ45mq1ezIF4riOVpasVr+M1h77wdMwLNm/ABjTyBL1L2t2WDqt7?=
 =?us-ascii?Q?rccSoXVVa1w2bPlHCb/bhlnm2powC/zHjQbsmt5Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9ccabf-45eb-44ad-c97e-08db580e08bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 02:09:10.2372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mQG71oOct8ZR+PrUeo4n+MyPw3KehuVB72YqT2XThSuTvbZMNZVZLwiWwEgmwPiQEknrU2XwAQDs9+ZQXgYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

[AMD Official Use Only - General]

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Thursday, May 18, 2023 20:21
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 5/6] drm/amdgpu: fix the memory override in kiq ring str=
uct

This is introduced by the code merge and will let the
adev->gfx.kiq[0].ring struct being overrided

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 8883d5ee13cb..460a771e34a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -448,8 +448,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
=20
 			ring->mqd_size =3D mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j + xcc_id * adev->gfx.num_compute_rings] =3D =
kmalloc(mqd_size, GFP_KERNEL);
-			if (!adev->gfx.mec.mqd_backup[j + xcc_id * adev->gfx.num_compute_rings]=
)
+			adev->gfx.mec.mqd_backup[j] =3D kmalloc(mqd_size, GFP_KERNEL);
+			if (!adev->gfx.mec.mqd_backup[j])
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ri=
ng->name);
 		}
 	}
--=20
2.17.1
