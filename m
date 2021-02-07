Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7364BC433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 02:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC8764E8C
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 02:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC8764E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF1D6E52D;
	Sun,  7 Feb 2021 02:52:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F876E52D
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 02:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkuY56tnA5aePwHwg/u+DOF7OEqPnakwZ4mXvlK1n2XEZertYMLXQ0FwBNBIlJhnZEO6XPcaOlXsZYVX7XNbGKjwyjbBNAEATlSAOLHkjtcdzW12S6CCk2YpuQpOquuJFEolxx21jWtYaeLJ2qRrspHhjGHzb/b2jbyneWOZEmc9Pc89Wz7PXd12WbpXcCwKqrWN5C0kYXDl4h/dZW0Apdeauin3vxKaLRRdQ/SHX+Ke0x39bjSooLXBKQP7tKtsnDbKsMd7LwnfCgcvGLr3Y42dDAOY6poXQQPDA4P9agyqGwCRTkhn/LG0jXIZIDcAR6qJWysofQo3qE0OwggMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2ngVHKz9zBydO7C0OzBa9HGMstXYdFGjZvfMGOkZEE=;
 b=dSqu/szeHmJMgFF5PjB680+N1FE7K/NkPDoqlDoAmgn09hN4GLD9RUUxCobtPcmKfRmFgsbPvgz4vttSUILhpIfajv0TBZp+029POtpYsBPGvUpf6izrNC1lqrsz8WizJ42BNM6G3c/IVBOVxtduViMrRK94yoBpBzST/nK6DGC5jRF3x5uXIEYVXGsl1HzMnfzJr6bnD+VLv2Di4oVnRa+Yz3UstUGMFO2/7h43xfZAW/d8SR2pdX4n00rHU9rQAbpEoP1WQcnYvh0JncszqzBs25sf5kLfJwK6OQxNvQ+ca4gvqjx5UxLFl0bfwiVtnmLuszFQZa9SOgemp4uawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2ngVHKz9zBydO7C0OzBa9HGMstXYdFGjZvfMGOkZEE=;
 b=ED3Cmr6LL19bula5XLkPDYk0vu1vE5mVwjQyMS6tB0IDRutpmLIHzXu6jlRvUFxVp1F8LyLdImtQcYseRiYKJ+duy0Wgffb3d27MsaiYOiLaeuKGz46vt7sg/yKYXr0PZ4vGchxRycz6VfG68HMf5D76oyb65G/SQU6JilW+jPM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17; Sun, 7 Feb 2021 02:52:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 02:52:31 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable LCLK DS
Thread-Topic: [PATCH] drm/amd/pm: enable LCLK DS
Thread-Index: AQHW/PQak4OTNooofkmGPWW7DgjwOKpL/bKg
Date: Sun, 7 Feb 2021 02:52:31 +0000
Message-ID: <DM6PR12MB2619B62E1F33F5853CFAB74BE4B09@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210207015344.21442-1-kenneth.feng@amd.com>
In-Reply-To: <20210207015344.21442-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f66fea63-255a-4ce5-b614-b2b8ea2ed132;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-07T02:49:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70bb4cfd-65c2-429b-04bc-08d8cb136a00
x-ms-traffictypediagnostic: DM5PR12MB1708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1708B73EF14A83C03123BB3CE4B09@DM5PR12MB1708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZmXtSyPIguOIfpVFhAtFqOrFQIkW6+gp1CKh+O3MCVmjHkTKpzjntwn9LB6jKrno1OPmF34sDgIOXSSz3asbOgotZ513dyh7Rqn9W7HdfzdD7f9BuVVcd7HBMlmD/wR6XMKSpWOfzdMl6PYxjOez1RgtWIeoE9IrzdNANB6ALBZtqveHVAKg1u9XRr8odfbg93V5Vt1MeQOM0sesDlc1QEVVk5BqC7ghL63WZrHPVXUN5+OhEIPh+O/wLAk2DRkrJA83akkRC6x65SVd8Huf1dmrQ9V24vjoTH7lWsUjd2llKeV64RraSY6vnqbYh6zvtOGU3+ajvBPoWMcz4Gcnw7AiP4Wj/2SeWfh8Xk4edaeoYw27L4HRKVCMBZFR7xBO7vu8bfEepewcPETQ51uuw4A+yFaS59tC1MfffowcpgCFpTh/lLRxzUcAeB9k/lHaJo6SHJBMMO5AMdCBjBg31JYCwAYVpbK/rYRdpANuLq+uVjBONhh2DRRybx/TIA3lwbMU6+Rq3dUq1O6ZBtpPM+kJiGtAe8+3qA4oTBEd8Hfu9WB3y3Cu94rzvhyxhsY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(186003)(478600001)(45080400002)(4326008)(966005)(2906002)(26005)(8676002)(83380400001)(6506007)(8936002)(53546011)(71200400001)(5660300002)(110136005)(33656002)(52536014)(316002)(7696005)(55016002)(9686003)(64756008)(86362001)(76116006)(66556008)(66446008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YkZKD3YwEM68SVodBjnvqEmiUYUnuqe3w52sKsj1mdhxk0sJZ1veA4SO0nql?=
 =?us-ascii?Q?ePa+Qq2fsWR7NcazUeIulbxy0YoM3/mV5yreqxVk2xKaBSba+fgKdAZLuodY?=
 =?us-ascii?Q?HspUf4Dhpq9bMb15rI8y2L0cSYWzBMlrABWZgiGhS2pMojMmso3If6cDI/q1?=
 =?us-ascii?Q?W/LyPhG5yAu6LMfDQZpzH819B4dId88c+/1/3WwDJxjeFRvlroMfOWmfcKK1?=
 =?us-ascii?Q?zTqBwQp3nk101KHx0KDfOOvrUj2orD4eIO1W2ZSIvSs+Z6J+GI522ytObrKW?=
 =?us-ascii?Q?AYoy8MwF/nxvrXHBHQ2Ib86/PCwrsh/ZtcqrxuDK+4RFsoAg/7GvN7DMiywJ?=
 =?us-ascii?Q?36xW/JVr0Ee+N5lUY48tFH2e5PZ3VuAtvx6UdGsX1B9pt/uyofS3E7aq3mQ0?=
 =?us-ascii?Q?ljot0UhWBWzzDtNxCgDB9sT1+bKrIfU5cJl1cU2dAhPWmCbbDmf+IBKQpEv7?=
 =?us-ascii?Q?EUiuYF6nKPuPl7gHZm5MyPU0u1fbN8q9VQPg9y+kWgR74bvplRbafxHH0TC4?=
 =?us-ascii?Q?4WlltIMkDtef9eXEEv6JospK5rO1i4Rr9wS0vLVXkJ2d0IbqAonzN+FViZIx?=
 =?us-ascii?Q?BirtouNdrlI+1bZz/iD7OdEC0hmsFarVGxvs3VjJhSUASWi8iWLrCotjIAeD?=
 =?us-ascii?Q?CwgC41CFhuWPQ5dLI4t9tWYHhs1Q/w6u0DcvDWmsQ/ElXbeBD0xk/h/Wvh7L?=
 =?us-ascii?Q?gZV1KDZeU8tpFHCPflNuHWQBFlENCQO8X5MuXwl9GKMiM+2ogkpdOZbfUQsK?=
 =?us-ascii?Q?sA0YxA2NzB2kdrV2kDYu8LRaBznJsYI4KCNggsUYulsBaOe5OTO/e1Oj58jc?=
 =?us-ascii?Q?u7Zem2ufySzu/b4AZZqv6EhIrXvxTylG4sS7BifyfLV/ONuMsiBq/+Y588Ma?=
 =?us-ascii?Q?3KkL6QOXs5PEE36Et96JDjL9P/+puN+t2Kghwv/Fj4xgDbmYT4HbRvqkTuZS?=
 =?us-ascii?Q?I8ezEr5pL890ArEUh5CntbACRDLbGrkULiZZjuk8funxVcSJtHiW+VRh05SY?=
 =?us-ascii?Q?sVJG2PvUSsWuSLBa8/+BVp6fuOobHteOnyeSY265flK8lxKu56kxepLlkN2f?=
 =?us-ascii?Q?UtyO+S2BE5Hd70kGKlH142t/IZmbG0AmlIbE09Gy+HGwY51rvVJEI9v8RV1C?=
 =?us-ascii?Q?Aq8Yt7TijLKsO15zXd8jhcQzVs6+q5EMCbflNGQukRD/a9MR/hr5ABI/6dmz?=
 =?us-ascii?Q?+zrR7F573Wd7GjsfiNi0K6Xxa20fUleNlZ6urWA/JtcF7BRG9Fo1iX1DmYcF?=
 =?us-ascii?Q?XN99QKwXVkmRqmk3IGbb1WkWX+mM/Siiu/8XdeaP2UtY8GWf/ujn97JBOQxy?=
 =?us-ascii?Q?XpOxHu2nnjQZ6gDfOuuKU9HU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bb4cfd-65c2-429b-04bc-08d8cb136a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 02:52:31.4529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNFHrifASmpKvawXLBas51yJRb7Dh/eJIsbjJW41/q2QxdKFA3zca1I0NgJfH5+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Do you mean ASPM is the prerequisite for LCLK DS feature?
Then do we need something as below?
If (aspm = 1)
ppfeaturesmask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Sunday, February 7, 2021 9:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: enable LCLK DS

Enable LCLK deep sleep and it works if we enable ASPM:
modprobe amdgpu aspm=1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b9e47f3b0231..d208a434c7cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -242,6 +242,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 | FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 | FEATURE_MASK(FEATURE_DS_FCLK_BIT)
 | FEATURE_MASK(FEATURE_DS_UCLK_BIT)
+| FEATURE_MASK(FEATURE_DS_LCLK_BIT)
 | FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 | FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 | FEATURE_MASK(FEATURE_RSMU_SMN_CG_BIT)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cb1e8027ec41e451c768608d8cb0b3b29%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637482596398826719%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=hgcKYx59KUGzn7YCQsOXsU0uJXVDIeoduFba%2FQDw1Z8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
