Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952DC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5396124B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E5396124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE1F6E111;
	Sat, 18 Sep 2021 08:59:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578DA6E111
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 08:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrDjixEATVdXEcENZrJzd6iqU59kyVaTN5Laj+2VEZFWXaLK8tEu8VcY3jnE/RdYkK11HexFOqLR5r49muTSgkrEAyeHkN0ZGIFSMW10Vlbx7zwMpbYNg4L8uVMfQsaH/9sX0OjJ/hT0p6xagR/o/oszpMF5cQa9OGRi1U4wdTTti+leX0cV03S82lJTg9+D0UC3NJA1i39bBF+DcyU30RQw5mtFgbbkpEkQQ8c6uraaEcBOtkoCNLU30t/aS+go88Z75LNq7b8CYdEnjcyRgqNefDNkV6sjKxPztZVSOXKV/NpK/xyquTMM7DWUY8Samm+fseuGyG5bpr5g17zm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fbdLIQLCG9UetVScFr/1Sbd++p5DEAAzjxwZb51GNqo=;
 b=GQ/LHZlKMkGF/2IeMaubjQhUHGXG44EqMT+NLEAMkOePh+VBE1+ctMjpk+99xF8w34VnT3FR1pb7PgZbnit2DuiGlKB3K2u2CyHNaEY2jMxtUa+9HbGIbtnIoRTeHcC3BXMcmgmg/C6qJmxk3k0TnYaLflylZ5GVhX0YXwrLpK6irFiQbdMx6Vx2M2QcDmeIMcsdwbThXhH0dlBd9O5KMjE/g2DHNCS+J8MiEg80ML3bHFV86/QZHAdF532+fpo3BUN0iRQDtQPBe7SFppqm4AFefjFyPnapKjrekyE8D5gaTMigqXLdeDqPwR4MtWa0xTN+LezZaVRqb0PVdxFAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbdLIQLCG9UetVScFr/1Sbd++p5DEAAzjxwZb51GNqo=;
 b=Hnl/NOUi6Ng+NpohR2RuHQH8NH7C8hmnqbDZp3ZxfMVTVfl2yEQ9e7wLr7JR2TZIAmivUZ3iMDg5x0KeUG2RevkdqNp7KPmR6AbiDh6n45RHqIue+++jDbu2mSkyVqD0SNfRJT2TbyD07vXPIs5hxa4NsSAjJ0W8CFHRNST01CU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 08:59:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4523.018; Sat, 18 Sep 2021
 08:59:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: set poison mode for RAS
Thread-Topic: [PATCH 2/3] drm/amdgpu: set poison mode for RAS
Thread-Index: AQHXrGRV6KD6a3rrB0mzXGXMYR3nfKupfWig
Date: Sat, 18 Sep 2021 08:59:06 +0000
Message-ID: <BN9PR12MB5257DBA732DD7BED5FB54C1AFCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210918080751.23615-1-tao.zhou1@amd.com>
 <20210918080751.23615-2-tao.zhou1@amd.com>
In-Reply-To: <20210918080751.23615-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-18T08:59:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=56330e0b-95db-442a-b887-0d1913f494c5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9546036a-a6ea-4dbe-301f-08d97a8291f6
x-ms-traffictypediagnostic: BN9PR12MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5161708770FB6F165FD9C7F0FCDE9@BN9PR12MB5161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2D1PXqof0dw9Z1E04suvuzuv8vBl25RcdkBu+mKp2r6n7p28szLjytm68+3whU+Zkl6DGpfgj4Tc8AFm29cM37IT28bvipuu/ikR/AgecUWmb4voMzPI3aAKlA2lVCj9vPX3la2hfta4wuS+sGkysZ2FnXpr1ijYdN9hOpoY2lG28mhkLw2CxXRrLk7Xx2WQMJaNDHC1lCrj1fD5WYkVpPk2laTZlfESY6wo3VsVra2bze9qP14SQuTYbgKSrzLCmIZs8s+wXm8jVYteSyqD2IS+RUXQkul9vrP4UArwbVF0vx5hv2Nm0Fud2dViYc4a2O2kgx5CzememJoGg5sVdD4xzpONHgEleFCwlfcbChN/fL9aqf4qul9li9SO0fAZX/aW4PdHKV4DCcWGvMTC29i9OBN/caMSDaOyEioQih4xWOH5Ha4vn9FRK9/zBlE22oV/ZCVqbUKnq2td4DKktZ9zjEHWgtfE3HMykH1awEtoYJVGM/lCChWT4QVhwNpd1SF6u8MfeipH+rXiFIkr8RexXJJOHu4VUh47Pm0FsHeBxXKlpQtPlz+oxHie01gHWV8gYxwcS3XScfK3EvQ613dKJRajzzIO5igtbJApwqB/ATLdyddel4xo02SIgRDb6R07S9AjSAg82kHK4utDbG3264ZVztH5t0mHYe/yxEuv05up4DnGYEX/XnD83f6iDMFXfbglmLaIJLgHI9HBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(316002)(33656002)(64756008)(110136005)(52536014)(122000001)(66476007)(76116006)(66556008)(186003)(38100700002)(83380400001)(66446008)(6636002)(2906002)(66946007)(5660300002)(26005)(53546011)(6506007)(86362001)(478600001)(8936002)(9686003)(55016002)(8676002)(38070700005)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HKq94UStFvOddnvpCOFSSmFBVXIUApbfQb/1elgujg2xbGKw1jjLRpYyZh2M?=
 =?us-ascii?Q?C6eCZYFgqvzGpCVsr/OQJo9xs8H/ng6ScfaKga6agnivIJC9aslb5MLo+eK0?=
 =?us-ascii?Q?22Aj/rby5k++3cKBOKJZM9gYGQVXHY4S/U3T4SzCe8cApC5XjlBUtyniidPq?=
 =?us-ascii?Q?m59839sRvXM0SePYoKudbAmqjIRIwDSkGJ1Hn4Ee9T0SnunFYINO9RaTq7le?=
 =?us-ascii?Q?29zOYJtcKOgWsPtHr5tUJWthUeG/yRWxMOD8KgVEhn5ZdEuz8v6tx2kFUwg5?=
 =?us-ascii?Q?jnhMgvjFzK555Q+CWg+mDg+EOJvNS08//vVETrVMKd9iH+ZDGI73XPNvguBU?=
 =?us-ascii?Q?WUevKzju4Wr1FUCyfJu4iZXf+yHafY84qGLaNrFBN7wiADOvYZwmV3jAuSoU?=
 =?us-ascii?Q?TCzZm+5pj3UZGxZuT0qWdP4tJnogOzl0KmTDrWQP4o3Mhp8idQfNVHpQOBhK?=
 =?us-ascii?Q?CZ4QgTrm/1hNimzewADzZzYxjlBzJJQCINRBTyPGKd5DT2IagufOkLjtcbIc?=
 =?us-ascii?Q?Smhj+kJ9NbVPmpIZmI+Lh5h6ckhydnHyZM42aKv6d/EoRPR97/7j7qvgfQ7g?=
 =?us-ascii?Q?2FBnutC9K0yeQOPJp2IXEscIlNOCA4cRfT/yIU68fHWfM0U9NcPL2LydIc48?=
 =?us-ascii?Q?zz2cQOfmyJP8zqDRk4E+O0sKeAyrb9A0DuihPAPLHOLuRAp6fie+3pc9bomG?=
 =?us-ascii?Q?ch7UiiS6SPrhayeb7Z4gITAD85MQ1A1TwrpfwAYrsZi2Rck3pjM3gbHKMumA?=
 =?us-ascii?Q?zwYHDI35WdFQG+4FDoZDCbeWNahsfQ7xwPX48rV636Z4i8fC0RkEnMhRoRMh?=
 =?us-ascii?Q?kTzuUfNOKfwQ2GApgxYmqZdtD6MBmMeH1nuD6yqDTVhgTd6ko4jSK6WWfBMW?=
 =?us-ascii?Q?fl2j5kJp2XhdwQTfAYQbDZhBpS2abFsnTQV6b5G9lxF/G2MQw/I3Ix3nbeWl?=
 =?us-ascii?Q?Ub7v0BFY6x5ivATSoSpb77AC9FEP/iRYkCLUb4uQpKuUAmAwv4m6WYQh8wlw?=
 =?us-ascii?Q?BvPRBnwwOwb2FSlyMDwfR24XfVd+0DGEUBGaDRvdwt8TRbVWIWHVjT78idaG?=
 =?us-ascii?Q?WSvWGLBu3a1fFo7sH6Py6wKTaiYPaZlUzqLPt5lF+/tLdd2R9kZIrCey3EXC?=
 =?us-ascii?Q?rw5O9DL236MmDcJG02P4Kygqp17+p8w7GjABRJ4pkdp2ZSNj76mw8Ef1ysNh?=
 =?us-ascii?Q?D/XWZ2seaIGmfnVdJU8CuvqUnTufpo5UkQP6yBNq/j40VmxGPQgdRbXP9Em4?=
 =?us-ascii?Q?AuKtEW/+AevOb3SrQKwGk0Iz12yznIi17VzO2Xbz9t1STpfrdMrYjWT0bJhO?=
 =?us-ascii?Q?QvIBLcGJ7vFXKvTXLp4qGV4l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9546036a-a6ea-4dbe-301f-08d97a8291f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2021 08:59:06.1230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CISSTwoxWHLIjTI8qAsZFiXAKyfKTmoLLLionuPr7XUkk1ZVKkKaCOhRSNBnzXxwAf8jpMwFYksem4ZTxFRr5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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

[AMD Official Use Only]

+	if (amdgpu_ras_is_poison_enabled(adev))
 		ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
-	else
+	if (!adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;

I'd expect these flags are set in enable_feature command per IP block if ne=
eded. Instead of global setting at firmware/TA initialization phase, though=
ts?

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Saturday, September 18, 2021 16:08
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set poison mode for RAS

Add RAS poison mode flag and tell PSP RAS TA about the info.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 ++--  drivers/gpu/drm/amd/amd=
gpu/amdgpu_ras.c | 28 +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras.h |  5 +++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 7d09b28889af..140b94da2f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1442,9 +1442,9 @@ static int psp_ras_initialize(struct psp_context *psp=
)
 	ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context.mem_c=
ontext.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
=20
-	if (psp->adev->gmc.xgmi.connected_to_cpu)
+	if (amdgpu_ras_is_poison_enabled(adev))
 		ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
-	else
+	if (!adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;
=20
 	ret =3D psp_ras_load(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b5332db4d287..7b7e54fdd785 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2180,6 +2180,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
 	int r;
+	bool df_poison, umc_poison;
=20
 	if (con)
 		return 0;
@@ -2249,6 +2250,23 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
=20
+	/* Init poison mode, the default value is false */
+	if (adev->df.funcs &&
+	    adev->df.funcs->query_ras_poison_mode &&
+	    adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->query_ras_poison_mode) {
+		df_poison =3D
+			adev->df.funcs->query_ras_poison_mode(adev);
+		umc_poison =3D
+			adev->umc.ras_funcs->query_ras_poison_mode(adev);
+		/* Only poison is set in both DF and UMC, we can enable it */
+		if (df_poison && umc_poison)
+			con->poison_mode_en =3D true;
+		else if (df_poison !=3D umc_poison)
+			dev_warn(adev->dev, "Poison setting is inconsistent in DF/UMC(%d:%d)!\n=
",
+					df_poison, umc_poison);
+	}
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r =3D -EINVAL;
 		goto release_con;
@@ -2292,6 +2310,16 @@ static int amdgpu_persistent_edc_harvesting(struct a=
mdgpu_device *adev,
 	return 0;
 }
=20
+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev) {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+       if (!con)
+               return false;
+
+       return con->poison_mode_en;
+}
+
 /* helper function to handle common stuff in ip late init phase */  int am=
dgpu_ras_late_init(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 1670467c2054..044bd19b7cce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -345,6 +345,9 @@ struct amdgpu_ras {
 	/* disable ras error count harvest in recovery */
 	bool disable_ras_err_cnt_harvest;
=20
+	/* is poison mode */
+	bool poison_mode_en;
+
 	/* RAS count errors delayed work */
 	struct delayed_work ras_counte_delay_work;
 	atomic_t ras_ue_count;
@@ -640,4 +643,6 @@ void amdgpu_release_ras_context(struct amdgpu_device *a=
dev);
=20
 int amdgpu_persistent_edc_harvesting_supported(struct amdgpu_device *adev)=
;
=20
+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev);
+
 #endif
--
2.17.1
