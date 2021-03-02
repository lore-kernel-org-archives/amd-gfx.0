Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32826C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 06:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F6861601
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 06:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F6861601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD8089FDD;
	Tue,  2 Mar 2021 06:09:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D8389FDD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 06:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlUrQnm9kigPFCqqsXcQARJdTMpnIPCtH3uQCr/+1sDP2Vc9mBtRs3VeBuuGX2bcwZ6L9OIjemBVJuxBcj3c42UVB/eBzfQdyV9E54FEeOqCAGlwQh1CabKCXe1SujY0xWQg8EENStqUG90pgauYZvw5eoFUzzxxepd99rCIyMESVQlxGDezyLm/CAV0QUyo+lV6jwJQN+zFPkeZciuLnzfeK75ll88CNo1yckTYw2XE3ex/9ZP+7GSDnAxDxsMlfhrA65i26qRGYFZEbNudq4XEaNrtvJIARJglNwTplWeT6N2uLxtZmOzUvT0PebL9jdrpRTgGpEcjxwQxr+0hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJNkJkN+bRFBmbiZAy/Z9tZkmV+oIvhg8o8j7mxddyE=;
 b=USkZ6SPz5vgNfzmqtiRokpc1faPfwxKtRq+3Fu9NByCiBSfzoHLrLtHu9XupUOzMddwZf/fOfQYA9R4WiaeoUSTyBTzFkNqUO3wFqE1qTjqt4NhvfJ4sf+Jm01vA5jNoTjGvwju9gMUUudZvLGgxkmfenacIiufAx5Mh/Z4yDHfdNtadCgEwtHJTnETwnTnHan+y7QxZ9lkCbEwzliNrkU8UZaYGWcqImk41MQco0Q9LWnpwVv/rD52Xy2YOJ2epOiAkB8XOD805lF4gkYkOASwS7lHYaxuarxfM5zcYMxr2FBndyvWa0vH9RPUmzQ9tBa9V+DyOowqp5kLeyv89yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJNkJkN+bRFBmbiZAy/Z9tZkmV+oIvhg8o8j7mxddyE=;
 b=oFnrFNliBRgxr/C61Wmc128fDoihLBXaJuF3jWyFf8FBC9TL+0q7bVYtge+2TgoaIcuzqNrTqeBTONkqFclEz5T8MKu8tfhlNtL8eovG/5R8SY7DqUhiZmySWSMq2sxpc1DVSQ0qVEjBHjhAQzY0uK82FayXHGmFr6W7beKAUe4=
Received: from DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18)
 by DM5PR1201MB0042.namprd12.prod.outlook.com (2603:10b6:4:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 06:09:21 +0000
Received: from DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5]) by DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5%9]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 06:09:20 +0000
From: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm/swsmu: clean up user profile function
Thread-Topic: [PATCH] drm/amd/pm/swsmu: clean up user profile function
Thread-Index: AQHXDstn9EODlPi2VkyPz7ZLJjGaDKpv5/2AgABO0yA=
Date: Tue, 2 Mar 2021 06:09:20 +0000
Message-ID: <DM6PR12MB41886E92853D3C2F844295A3E4999@DM6PR12MB4188.namprd12.prod.outlook.com>
References: <20210301185122.977-1-Arunpravin.PaneerSelvam@amd.com>
 <DM6PR12MB2619A701A935C108D6BFB25BE4999@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619A701A935C108D6BFB25BE4999@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-02T06:09:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a2301412-b6b0-423c-bf24-ca47b609e469;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [106.201.115.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00e9264b-737d-4555-17ef-08d8dd41b86b
x-ms-traffictypediagnostic: DM5PR1201MB0042:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB004283917F879C5656D87868E4999@DM5PR1201MB0042.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cd4EPi8iHxtymHD4+eRctOe4NITeyAGZ5Ff/yM9pAhJT1tX5d3xbOI9RiZnarVZVHjPbF+4uR+I/9tXZu9G6I6MUvm1zsfyXFphtnlWUP0qJCY2iIoOBwZ3bCAdHrfiTf1inB875yXLC4zBCe2i+v1Tajh+k1Ngewrdf7D2WRuuBEtA6gkPStzf9YMqDYyqgrLlODEj5kCxuX6yFh7l3PC0PBC0oO924yf3hEBF/9uvnIfLOAp7n9eA/n/P/tVx1ia9OB+AW2eMcZzcGjE3A8nFX5QkLvvuMeA/JDL1lOvRfHtXIGK2+KndPXrvBv6Q/N1gAgnB0FNCDQ0zBbWmA1OiEowqV3uA5jxs0z8npxJEkI4sI0E3PVpXYWQ3AnuJVyYS1+b8lWzrJZJpGg3c/SETgm5MNJUtcJJrgzkZLBoziZtrBrwloKiPkoVFhDMTxhrRbcmp/ibhdVm+ZJsrSLym9M6gJzXtNmFHiWPYYxmEHIVRFVHR+gYqyqoq/brn5ja7SUy+MS0LxkCZ10iGs9FXifFGPUqL9kLr2ZI74JJSrwbKPnVlSfFkgQ2Ncs4jb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4188.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(5660300002)(55236004)(26005)(86362001)(9686003)(52536014)(478600001)(186003)(83380400001)(33656002)(53546011)(7696005)(66476007)(55016002)(6506007)(8676002)(110136005)(966005)(66946007)(54906003)(316002)(2906002)(8936002)(4326008)(45080400002)(76116006)(66556008)(66446008)(64756008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ULnaEZsstUKLHCB/Bk2t/MBwqk3Vr6uBANriMJXeA8WP2NzAdyUOQb3aHabp?=
 =?us-ascii?Q?h2MXqZ8I6pvHnksGNGG0un0H4OyCVXcgVuJFreUZxjZnms7NFmfQwhsQ7yLg?=
 =?us-ascii?Q?QbkAtfRmB+sa4reC6iNwPgaBE5uMR5WSLcpI1vZYtvVjnSUJ+ScYrltZRgzT?=
 =?us-ascii?Q?I8yProDaou1nxkfK6x8WZAg47RRhkGRsCI9xMfJ6edfH0WRW9FQfEMT7uxrt?=
 =?us-ascii?Q?2YRjqm9r8GMPbI18ZG9q2Hiei7PwivKOBym/lE/jCUdWosVMgyxMD7ayP3Ne?=
 =?us-ascii?Q?Tirnz90efim/dMQqkj4ZNc8aEfyV3F1Q2cKir60Pt2krjzjTM7jZu+sBXEYL?=
 =?us-ascii?Q?inx2gKwfQsyE+lXbQw75XgU+kLoTtwn3XUWZnpzRtxezP7p7Ys3qz5BLYYRi?=
 =?us-ascii?Q?SQSjF5XesgmA0zuBY+CR4HrvHjMvjH0l+t1bFPweaiH2InTgHnxuzWjmob1N?=
 =?us-ascii?Q?P/kT9X+YyjbLv6OASh/ApWzoM+3qKUPGqzg8c5vO6f7cBWZ7emPDTbTGFu0U?=
 =?us-ascii?Q?nrJWRMGPEkqhfOlHtDqz3Op6aH8i5OVLjh9fsS7qNtSi79/zsF3UGbK9oOku?=
 =?us-ascii?Q?s95Ked/r/wBlN6Wk4kTof6rgqbzkFRmB6yJJRk8vSYcwPTbWnHLHqPEuot+p?=
 =?us-ascii?Q?HqruwrX/wZLWP2kDrWIH8MnELxdAk0aeWddo3oVMZylva/wCkHLkO3ypi3XO?=
 =?us-ascii?Q?BbN3OEor6xqZiY7NyHazKMoxZEPYg6011UMjS6JIZ/2TnWP6X6iK8x4PjN1e?=
 =?us-ascii?Q?YI1KPRoE8ctQ+Xv1uZr2zhpxDlqXUPxcKUGdJ7irHK36RIU5ak3czvYch1wA?=
 =?us-ascii?Q?paSouHtzqRg1IfH4aQaG3WQY98V18DACvpHaaBWduy2LhKIPjG5JbdV6Ey2G?=
 =?us-ascii?Q?LZBCSQsHj44cktLW0jNsKdjJX4h3l2nddKn3HK8U+ctvbiTBP8Ux6ofUt0KJ?=
 =?us-ascii?Q?S6ScLaHWjS+rg4s5oiHgAwtTU2sTyd2cRH64kowd7MwjNKzbLmEmXk/RoYYs?=
 =?us-ascii?Q?2t44kn3VK93mWxKarABniDbQsdV/bJC1HVglFPr2ETN8IUsacfpwTzokGFDf?=
 =?us-ascii?Q?JCeIW83UEXIT7MJBak7jxVNKettB6TjERFIBFgoLSUC6J0P6YO7EjRWpmS6L?=
 =?us-ascii?Q?rzNZz4sefs3Lwstw3HDwbng8VxmfeQm5gV8BwMPnt6hR1HwEk+60G6D2q8sv?=
 =?us-ascii?Q?6SkAm1/c1N+UHdO8u6byO5gn4fprtXwFV4Sc3ewJwuoIcgIgxevFp1nV88zJ?=
 =?us-ascii?Q?GuRf3pkRLr9JuRsURqn6UAhWPv67ZVfNV/UnKSCMIhleowxWzVN9r0fxvIQY?=
 =?us-ascii?Q?4J1Q7YAcNXZ5bi+ai6VH9wit?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e9264b-737d-4555-17ef-08d8dd41b86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 06:09:20.8797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCN3NUVcTRC7Cm6WB5K/EvAMzJuhSllUmRqInoThSGAqv6JxAnzY0h9qmaWSMWPYMLX4P+efrSg3kzWl7XmmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0042
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, March 2, 2021 6:54 AM
To: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Subject: RE: [PATCH] drm/amd/pm/swsmu: clean up user profile function

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Arunpravin
Sent: Tuesday, March 2, 2021 2:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amd/pm/swsmu: clean up user profile function

Remove unnecessary comments, enable restore mode using '|=' operator, fixes the alignment to improve the code readability.

Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5d9590f2178..7d7ef4fa2887 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -315,35 +315,25 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
 	if (smu->adev->in_suspend)
 		return;
 
-	/*
-	 * mclk, fclk and socclk are interdependent
-	 * on each other
-	 */
 	if (clk == SMU_MCLK) {
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set mclk dependent clocks(fclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_FCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_FCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over FCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set fclk dependent clocks(mclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_SOCCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over SOCCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set socclk dependent clocks(mclk and fclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_FCLK);
 	} else
-		/* add clk dependencies here, if any */
+		/* Add clk dependencies here, if any */
 		return;
 }
 
@@ -367,7 +357,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		return;
 
 	/* Enable restore flag */
-	smu->user_dpm_profile.flags = SMU_DPM_USER_PROFILE_RESTORE;
+	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
[Quan, Evan] You may need to change other checks(e.g. "smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE ") to use "&"( smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) to pair with this.

Evan

[Arun] I missed it, will fix.

Thanks,
Arun
 
 	/* set the user dpm power limit */
 	if (smu->user_dpm_profile.power_limit) { @@ -390,8 +380,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 				ret = smu_force_smuclk_levels(smu, clk_type,
 						smu->user_dpm_profile.clk_mask[clk_type]);
 				if (ret)
-					dev_err(smu->adev->dev, "Failed to set clock type = %d\n",
-							clk_type);
+					dev_err(smu->adev->dev,
+						"Failed to set clock type = %d\n", clk_type);
 			}
 		}
 	}
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cd5866f2c3da84366c72108d8dce28c7e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637502212874693914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2Bwe2XHK3BiX8VpVv9Ut7rJ28NJxUtWaCXo4wVpngxoM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
