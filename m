Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E570C46467
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 01:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D328F10E618;
	Thu,  5 Jan 2023 01:38:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EB010E48C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 01:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flao9HaQ6ieZuzAfOnIdO7PCBUt2kDflBM89ZcX8SgPAzaYcyyGkvJPoQJT/ziVgkKNhbOad7vLp2RU+77xqbuVOs0q9Lv6JYyorSslrsk4BO+wPwaYp8O3DobRYzc1o35SlDKBV01VWCBeTyJcC9YAIWSHrgE6HelsAQeEpWzzuy3br6HEFy706JwTaING9CBuPH5gvWyDFlov4/Lc85CU5yHJhipYAV2kQATvkpQlP4iMs35Eak0ZSLmTwkgY66jSKIf8A3JJ35QWz56gKXpga9bufCo9hx0/a2aVWEhbLhpqCMV/+sCIqP54yHB+3Ltg73U/Lfi6HzdePmaI64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgkui2MDcHkDJ2+GewE23HKlrpAJBPAwzqIkHOwR/gA=;
 b=oH/3o0DGwLxbleZ8hgsdDt6oj+8LEwxkVZ33tfD8d675BFkshFz7nWUz2OTtJYkG4OsnryUgXLWHMMuX0e/UIN4nY3GDvuq/+V0CUZjHYDoXAvimMauE4EbTSEetWBZwSV3/SGvRb5Zz1ZMsK54NGXZTgrWcmJy20EaMMeMCbj/eIudfjR8uyDizUrFFAPI680lGhEX5arl2A5klphpAU1Yr5SdvXucHuetqp72uXyhiepxelnow52B1OZI9ay7kFCuQru7oHwdLRRePxZJYgU7HT57LMIHdH/nUll5oXo3UsqM6DURp60wSEQ3awDuPK8QEzS9/a8qmXM4+D3YMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgkui2MDcHkDJ2+GewE23HKlrpAJBPAwzqIkHOwR/gA=;
 b=hay/zKijv2wxaV5KsJyVra2+0qA6TI57/vNOJMcy1LP1TvELPLlmMtNo3jX2Wx6Fq0RONCptVYM8qVwWMEJRIgfMWPieFEh3lwXdYaPKVU0oDSnVk5DZM18WprKFmLDsG9VtU7I/RzyvU2fwgGqbJiAyo4S3ANpkI+onjRW3GQs=
Received: from SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:38:42 +0000
Received: from SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::9f5d:df0:ee52:8ef1]) by SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::9f5d:df0:ee52:8ef1%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 01:38:42 +0000
From: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: update securedisplay_cmd to
 ta_securedisplay_cmd
Thread-Topic: [PATCH 2/2] drm/amd: update securedisplay_cmd to
 ta_securedisplay_cmd
Thread-Index: AQHZIKGtE42SISbj8UGKeuZZk8fF8q6PC5bQ
Date: Thu, 5 Jan 2023 01:38:42 +0000
Message-ID: <SN1PR12MB2445BBE07DA80E1BC4ACF799F5FA9@SN1PR12MB2445.namprd12.prod.outlook.com>
References: <20230105010401.2216819-1-aaron.liu@amd.com>
 <20230105010401.2216819-2-aaron.liu@amd.com>
In-Reply-To: <20230105010401.2216819-2-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T01:38:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8c055064-b52d-4090-b816-6d2e0b88b1b9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T01:38:40Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f36b1db6-b2ee-4ca8-8738-94c95a20ba9e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2445:EE_|SA3PR12MB7976:EE_
x-ms-office365-filtering-correlation-id: fbb640eb-416d-459b-4867-08daeebd9407
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dv5m+7Qr5Uc+FcrgBsnyV5fw9pB/VKqhB8t8GQJfVM10XAhXpSWWjve5xQ3uFyDz9R8k5/br3y2YqAarAFWzGurrwIm4bk7w5DzHumrZdJxIUuVpRZjtgiWYo59YRbrZ0ODyrnpYKd8FctukvKvUuPN4CXOanATdMoLKMXQhjM7xafQwkr6xYOPs2Uo7lQUw+vHc1Y046xpMb4rdHsYaTlch9dOPLXL7qL1vkd3+iIgGXme2d3J2dnTHh3fPwAMer1QQHJues+7XQRLTvC6Im+8PkVtnR7pvhNYBzZMQEgf1CviHfv8rksW8L7LIaqvYoglNtvA7Swtqeg7n2Gd3pgT1wLiGmaAiFmEbEeDmHvrNzUfX3pC8y+hIDmHLEe8n3Nsfy+KSxiALxFFy8O68QeMXCGU5PnQP4s7/TNlems/khxD7xolEGXfiptyyVuPoANmGB/w867zYX8xYvLe5Z8/tFOvMx+SLXe5KbeQbPW5ARMdX7MS+KwQBBkJFXt6ovTJeP0PwwngWvwzR0srbc3wmw/3wHfpLupBcn9NlFr5qAN8nFAeeHL7QAZMbTUlA/t6LDTN4Q3TQQphW0hVDGTOHbHTl4oD2QFuH1anJSNeo9PjCwLCo6yE4hFiCByAsO2bvJ5Iv6EOU3RLTX+qND32lJkChojN8COMivRNU11YloGbVPo7miaBm8BkFIxXvybc6wSOEAFO4TC+7jnWJGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(5660300002)(2906002)(8936002)(41300700001)(4326008)(8676002)(15650500001)(316002)(64756008)(66476007)(76116006)(66556008)(66946007)(110136005)(66446008)(54906003)(71200400001)(478600001)(52536014)(7696005)(26005)(9686003)(55016003)(186003)(33656002)(6506007)(83380400001)(53546011)(122000001)(38100700002)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SXqDPNsv5e4978qNhA8DyamCFv85KbTQ77GvwT2zIeE9qVFyzON71mk/L9lM?=
 =?us-ascii?Q?4diKBwXRgvydWWShue8HVeFkptUfFJY4GssfoKfUmTRaJzNFVqTciOc66Loh?=
 =?us-ascii?Q?QsYsj0zQrmpwM+Q5ty5lcoCF7+dPUy4P7yA+n56x+anQybR4Z1Y3Ak+PhuW8?=
 =?us-ascii?Q?CyvnPpLg6qdLghhAhkoVDNareBhAfGiIEa3aKyXh4fujtaRCiDaqS8VCJCjc?=
 =?us-ascii?Q?rTBJlLoHAPmnMUlCJyLP4Gr9bRRPZw4vMSSbM+FtcPD8+suwDP1CS5QBxO+m?=
 =?us-ascii?Q?NWb5wRJvY6ZUGcmcrJmhGbXJo3ENXErbhszn2O4cGPVKYs/UMUwy2AAfMVAT?=
 =?us-ascii?Q?mwr2FHun2NzUEAXcKJbDiMG4HtfuDHx0uu7itNHK3OpedsWxKRRTv4apwv4E?=
 =?us-ascii?Q?mCIiFLgaThq7Wu5gSRerFc5DmAD8EA4hK2Gzct+R9hyh8IzrJnPE4eekU6uK?=
 =?us-ascii?Q?MPRlAyBB7WeuryVWu+GXwrJc35dVlYbhafH0lclAvXn/6ShzWQ0aB89NikAg?=
 =?us-ascii?Q?ZcgzjjIDujdCt8GJ9+wOTk4rZQWTjj/LRbNRn3uV70RpOagqDexEsejr4Eh9?=
 =?us-ascii?Q?z+yJwBdImgVqEtXLO8dpNKnVMSI9AGsCv8F4FyVNpy3Zg0VQL5IA9y4vwr9m?=
 =?us-ascii?Q?r5Fcv8G59YHcOmw40GxnsT7nNMxnxGJkcfbOcRteHZGrCEOxcz+tIe+2D0Kp?=
 =?us-ascii?Q?Axud+C46x4NEO8E4TQ5hptor24eNo9HKQdYIzIDtOt0+ZqKbsUX0bcAtgRss?=
 =?us-ascii?Q?axGBMat/jtiZd//h8v72wzhLSFMIqnMKGscS8rKhxH7r1P8HMlEYkzLFs/gq?=
 =?us-ascii?Q?w4+BzRSH8ROTXy+Kk+c+iXpMLlhurh56TOSG5vgRPFYYKynUmBkI9WhOwwHO?=
 =?us-ascii?Q?pFWz4bZ68kNbOYMEZ8O8kSa3VE5UpZXUzdF3pxs28sTbxossKSm3evBdILxI?=
 =?us-ascii?Q?63g2n7R74rTlJx4MZ/V+krHkQ8TDbED2ZTxMNc1hVjtVcRs0htCyjCh6KDeO?=
 =?us-ascii?Q?y7+vwFCYXxLGLCeri9S8XoZVCOHKXZOtJnhE8rnzKOUkhq57TQXm0dV8JT0V?=
 =?us-ascii?Q?FyGYMA/EkeBavZlSDWmTVYvBPFbyuKviN8sC9d1HgbrFHctHBc7TPH9SzdVz?=
 =?us-ascii?Q?2mqhdoxOFqscGPWHY+WocXQ53ECvLQNCGAD2V8clb0cfTFyK8dG+/bQ9jfa1?=
 =?us-ascii?Q?IzzjmpR3akN4AFJN9k0qxjMkAhYroxBo7Z8rE+hHpfq6Skl58IhJWFm28sxy?=
 =?us-ascii?Q?neqPiulb0SORz+dhoO/QyxNBeTALsQONo4aJC1vqc5P1U6WtqZaZP2McwyWE?=
 =?us-ascii?Q?6xGLivwVVfiFhIHTbBsZO9dCLGnGELg6s5gms5ms11CMQX77TMEYEceznZgn?=
 =?us-ascii?Q?40Oc+QW32Qa3F+K+fQAUS19bSjjECiI+ii4MBNHelq4WvyFRkQhXnDiE13he?=
 =?us-ascii?Q?zRZGdNRLPpuW90p7IK9XPOMvaRGerbf46lDNeZl8A8PocNBsPiVbVms+qlIX?=
 =?us-ascii?Q?/Wi0hQbOVhXnpZ4wTip+oPo3GW5W2tPdhFAnRiYGlA+Wxl+v6Nr9YY75TwrF?=
 =?us-ascii?Q?agWT+kFEhXvy4TdR1hklY8Lu2TfzTK1/7EBYXDvt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb640eb-416d-459b-4867-08daeebd9407
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 01:38:42.5925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoQ0E3J873GlkFPM1y30De4NPYFwMqIJh8oznHWRpFF7PwzVFdDELrDN+lp+DG14sw3cTuBXiZny6SJx91/MnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xiao,
 Shane" <shane.xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Alan Liu <HaoPing.Liu@amd.com>

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>=20
Sent: Thursday, January 5, 2023 9:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Deucher, Alexander <Alexande=
r.Deucher@amd.com>; Xiao, Shane <shane.xiao@amd.com>; Liu, Aaron <Aaron.Liu=
@amd.com>
Subject: [PATCH 2/2] drm/amd: update securedisplay_cmd to ta_securedisplay_=
cmd

This patch updates securedisplay_cmd to ta_securedisplay_cmd starting from =
amd-ta_securedisplay-v27.00.00.08.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c               | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h     | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 0706afb11577..2bebda7de604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1907,7 +1907,7 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t =
ta_cmd_id, enum ta_rap_stat  static int psp_securedisplay_initialize(struct=
 psp_context *psp)  {
 	int ret;
-	struct securedisplay_cmd *securedisplay_cmd;
+	struct ta_securedisplay_cmd *securedisplay_cmd;
=20
 	/*
 	 * TODO: bypass the initialize in sriov for now diff --git a/drivers/gpu/=
drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_s=
ecuredisplay.c
index 2c1d82fc4c34..8ed0e073656f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -77,11 +77,11 @@ void psp_securedisplay_parse_resp_status(struct psp_con=
text *psp,
 	}
 }
=20
-void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct secure=
display_cmd **cmd,
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct=20
+ta_securedisplay_cmd **cmd,
 	enum ta_securedisplay_command command_id)  {
-	*cmd =3D (struct securedisplay_cmd *)psp->securedisplay_context.context.m=
em_context.shared_buf;
-	memset(*cmd, 0, sizeof(struct securedisplay_cmd));
+	*cmd =3D (struct ta_securedisplay_cmd *)psp->securedisplay_context.contex=
t.mem_context.shared_buf;
+	memset(*cmd, 0, sizeof(struct ta_securedisplay_cmd));
 	(*cmd)->status =3D TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE;
 	(*cmd)->cmd_id =3D command_id;
 }
@@ -93,7 +93,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct =
file *f, const char __u  {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode(f)->i_p=
rivate;
 	struct psp_context *psp =3D &adev->psp;
-	struct securedisplay_cmd *securedisplay_cmd;
+	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_device *dev =3D adev_to_drm(adev);
 	uint32_t phy_id;
 	uint32_t op;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.h
index fe98574748f4..456ad68ed4b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
@@ -30,7 +30,7 @@
 void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev);  void =
psp_securedisplay_parse_resp_status(struct psp_context *psp,
 		enum ta_securedisplay_status status); -void psp_prep_securedisplay_cmd_b=
uf(struct psp_context *psp, struct securedisplay_cmd **cmd,
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct=20
+ta_securedisplay_cmd **cmd,
 		enum ta_securedisplay_command command_id);
=20
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index ad73e5855580..8841c447d0e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -103,7 +103,7 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct wor=
k_struct *work)  {
 	struct secure_display_context *secure_display_ctx;
 	struct psp_context *psp;
-	struct securedisplay_cmd *securedisplay_cmd;
+	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_crtc *crtc;
 	struct dc_stream_state *stream;
 	uint8_t phy_inst;
--
2.39.0
