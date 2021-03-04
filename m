Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136BEC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 11:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A1B60C3D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 11:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A1B60C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD616E0D6;
	Thu,  4 Mar 2021 11:59:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDDD6E0D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 11:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndOjoCxmO8NRaSv8Lwxie58I8JzX8CqSSdlX1nBVsLkO4bSBfRF6nJI1QswymOHGEck/I9sUOOtdd3asQNDeHcxS3Bc+4GcJLe1TeDee2z2ckO+9dmmmyWnLjvP6WBsAiAn4hLSqdB+vOJ0jRla93L7EsMSwo48RV/qb9lh9JQi6FlJDre5asr3vdcilMJWxf7VWszMJKul3HbKFwcNE97wtlYeETnS9SmZh5z7wTh1mKJR9DTTu5OXHKOQXhZlAVKdt9FAHF4f6F7fSOuOLhIM5BszKFdl+ixQTHosyzhOpAITTEZEIJpEQ2Vp4k0l8pZw5IyNEBLkA9lWMWW05dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXGX2osQd9bDKFvaiIZIfyLeq0pbtWipf7vR2qmeoDk=;
 b=deQuIuOUmEOAAQJBzpW0tjZXJmGAS9qye17bSzGkt/AB5/QJ8NbC69O4EFRz7X9WP9d5VdkZnBVGokQWJjJHYRSK5vnQZYyXRVSpnevsyVthjcE/aRzC4FpGqt031Z3SHip1tjbe466Mz8tlVyFO4tf9H/ih/nk19BUN61tMGPO4C59vBE/7HLamq3Zt65u74eH+/eEYFnzCfh+10xV6sLDJN9OdsZvjDyrYRlAzhiVrtuUnSo+Z5+KzYi5A7iJ2WfZaGx2b+0W3ZPqrBBCGkcWXFVP7FhpTjt7VXI9XA+vLHCg9NrWcXQT04TrGyDmZ7lzoCIp+tM+nQ7s8qjwd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXGX2osQd9bDKFvaiIZIfyLeq0pbtWipf7vR2qmeoDk=;
 b=OuwNr7ALCeClQDaUfgcq4L6fPJLqIM6STZm2IiksnQWbmmA1NuCV/sGA9VjiVy0+C2X9RymyDCnZizlnLSEH+3/g2UEkSE19OIp8aVxfRF4Fxheuc5zBTj2bN//6KkBHLGLTJ9cdGd5qkKLPE5rr4c/ribkJCtBXi7Rmyh78PIM=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB4756.namprd12.prod.outlook.com (2603:10b6:208:8d::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 11:59:25 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 11:59:25 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove duplicate XGMI feature mask
Thread-Topic: [PATCH] drm/amd/pm: remove duplicate XGMI feature mask
Thread-Index: AQHXEMkBJOcIZg9k6UegI6SOfAWCL6pzuRlg
Date: Thu, 4 Mar 2021 11:59:24 +0000
Message-ID: <MN2PR12MB4549FC92E58FDF23E8B3046E97979@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210304073445.15143-1-kevin1.wang@amd.com>
In-Reply-To: <20210304073445.15143-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T11:59:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b03e001c-d77b-428e-acaf-ea7cc93ae057;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.217.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 685e9a72-ae01-4752-2b14-08d8df04f4aa
x-ms-traffictypediagnostic: BL0PR12MB4756:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB47561727DDC23E2E51062E7297979@BL0PR12MB4756.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HxDY/IwH1inf4gb5/T5D3pAmXxHbWUTLpbKM95K4JI78NXcyPkTcS+eBiiW19DPNodizXAR7XfrZPiNMeEQ8yacBa96UNxwWy0LkMgQ4izcNDndkwBnDHUDswD93LbTTHdiDk7k6+nI4Z7f5AU7/ihGuTLauelNMleoLDTZPx22qPGenpCZBKpr7bayG3m6LBewZjFL2ibOWPPad1T4EAmpoQv6qTcKHYiekvJJA6Etf0wwIPJNYEnAX7D7U+iecuSB/W8MjTnDbs3zDjKAaPsUuYz6vWB4AKNpruGLIEie7wPrtJcua4zB4Hal5HG8HMwEFoBryW1gRWoN7CD16gVRW7bzCSU8/zD7rg2mFsX1UeNWzpUlF+FFHo41VwPZSfjNWWOTz3qe33/g33qpYAEsRMlf+odkkszb9Z3FDnF8nwGvk7C4g+TgeIt3EMxk/6wKV8VAOSvsUnzopTbzN/qp1x434+G8J5QbtStZJMZrGSaPyeAk3cgkVABEKk9CApi3Bl1X066xFjfNvrnA6afVuUJH/XgsxkF8/x/5XR2mVCo0ACYY7pUfeN/f7he/d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(71200400001)(64756008)(110136005)(52536014)(7696005)(478600001)(66446008)(4326008)(53546011)(66946007)(83380400001)(966005)(86362001)(8676002)(316002)(66556008)(26005)(45080400002)(2906002)(66476007)(6506007)(5660300002)(8936002)(55016002)(9686003)(55236004)(76116006)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1CWuynWKfNSbC3ANT7MGmPnHSQC+uvLqwiNS3CBBI7Lo1APUPnVrHF88sol1?=
 =?us-ascii?Q?cnYMwYPIC0ug+1wTCujMGjOM728N/ha/0OFUc2+M6Vnu0BWr20QbZyPbTjG6?=
 =?us-ascii?Q?GpRXrZsLPA/XVPkja50s4qmjG4DrKPlzgEf/3eTDTOkuyPXBOSAZzEz90ZbI?=
 =?us-ascii?Q?MugeftZ2/YQhOZk348XbxowFD7g1YH/zgE8Ku4qJ9bGZFn1qr9yc/8oYGK9P?=
 =?us-ascii?Q?NUGP8XhE2K2zBuSIDyyAtOEV22ZLEjQiBdZeIJMRuvXLbG10xSlXzPgKH3p9?=
 =?us-ascii?Q?W4igDiulxmP2WFYm+dCF8oHN5bgq1Rhu5CMTeyWm3U1GYxVzcuJNBmDYi6Eb?=
 =?us-ascii?Q?sVFaNKUFFpribddT/4gLf9yqioz3bFyHr1JJJwUF8hgbZIdLD/ZBfJgiTYku?=
 =?us-ascii?Q?dGQqU+dxgu72PAbXM5xdmNe3nXZjK+7r26KLTYsGHZAbaBMiRXaDQ9ufWOh6?=
 =?us-ascii?Q?KsqmH4AQcwfG+Ry0Ka9grreSCiqRe+x9qCqXXeGPFgjqxwW8dqWeHzxWXT5n?=
 =?us-ascii?Q?wT662LV7XyRTlUEvv/L5H6Z+ol6d1K2SqGi2m8woza5GNtXpOlV/PO/QXBBa?=
 =?us-ascii?Q?h5OqLj2ccuFrwTdLnHhcKym2kU8OsIomuOxUwJ1Kx0t/UKgxYEgWOadVHQLk?=
 =?us-ascii?Q?lPwAUgbYWq7Z9iy7r8xtMvPehV4Wb4qaloj30ftL9DJAy88+3v7Gtu7ua1mz?=
 =?us-ascii?Q?F0iY9gCoURXb06wTpfJkyji6mf+jYGBukFu2CieRFyg4yFFobB1SydXVT5OK?=
 =?us-ascii?Q?fhzU+OkAe5KUvOknK6eCk+V0BHpvfjRiuO2zAG4RHOsDAT2OamZEZu3Q5M6q?=
 =?us-ascii?Q?w8nu0Y7DvFtha7lJttOxxik5V+jenB1oX3SH7RgsGwvC5IJA6VoVuScZxNYv?=
 =?us-ascii?Q?dM0Jt279E4NHo8iqXWJdhFXfvhvaguyFFAI1ubKgFAsyH9qsggfjINN/OHJT?=
 =?us-ascii?Q?Z0A+OC4hmjFxCIN4seKELI1SxpewZfEFoTPjTYdrDbKa6s5azUEJzmk9wKA3?=
 =?us-ascii?Q?+/aGHqK4lvVQNpcfbKfeRRHGvlOyyMrzautg20P4qhSiDcqsWo4MaX/q0sln?=
 =?us-ascii?Q?S+Bmlp4M0pa8lZRst3FAg3HA3UR2M/4MlKxt2nHIS5VILM/qWgjyibWcpoAT?=
 =?us-ascii?Q?v9hfPKytde2SE+OtjyIDScFQfAiNut7tPY7ImSruoaD5wRGX3b14HyxcqsgM?=
 =?us-ascii?Q?Cc3Cfb0mnb7GCCg7rQaWGeZ/4De9W6tRed8rxYfw78rFKPEmzm62fpZjmDah?=
 =?us-ascii?Q?EOhOOa1h6z7a0FzG6PRyFmeyRGSwvRzU+krwvV2/gNVxKQ/EtCTTcD4ZyoSL?=
 =?us-ascii?Q?lzZF0eSyW9dw/FXb6O5guTRZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685e9a72-ae01-4752-2b14-08d8df04f4aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 11:59:24.9217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUf3dcIbi1av/bBaYKiFOKt1tmfQWXSbUUkQCeandwLL1FRqJecewap4dhxQ0E2v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4756
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Thursday, March 4, 2021 1:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: remove duplicate XGMI feature mask

replace SMU feature XGMI with XGMI_DPM.
it will cause show to be incorrect in pp_features node.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h            | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index aa4822202587..f9f45b6764fa 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -282,7 +282,6 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DS_FCLK),                       	\
        __SMU_DUMMY_MAP(DS_MP1CLK),                     	\
        __SMU_DUMMY_MAP(DS_MP0CLK),                     	\
-       __SMU_DUMMY_MAP(XGMI),                          	\
        __SMU_DUMMY_MAP(DPM_GFX_PACE),                  	\
        __SMU_DUMMY_MAP(MEM_VDDCI_SCALING),             	\
        __SMU_DUMMY_MAP(MEM_MVDD_SCALING),              	\
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f76d1b8aeecc..8189457a3ae6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -162,7 +162,7 @@ static const struct cmn2asic_mapping arcturus_feature_mask_map[SMU_FEATURE_COUNT
 	FEA_MAP(DPM_SOCCLK),
 	FEA_MAP(DPM_FCLK),
 	FEA_MAP(DPM_MP0CLK),
-	ARCTURUS_FEA_MAP(SMU_FEATURE_XGMI_BIT, FEATURE_DPM_XGMI_BIT),
+	FEA_MAP(DPM_XGMI),
 	FEA_MAP(DS_GFXCLK),
 	FEA_MAP(DS_SOCCLK),
 	FEA_MAP(DS_LCLK),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C838a8dcf382b4b16ea4808d8dee022cf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504401534512084%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=k5lb9Ma2MySTzBTPn9qhA6ocdBnd%2Bwa1thaJj2b4lrI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
