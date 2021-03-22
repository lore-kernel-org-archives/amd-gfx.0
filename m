Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9DA6196F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9DA6196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37B96E3DA;
	Mon, 22 Mar 2021 07:39:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE676E3DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 07:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH9mxBs2c4hIPS+t2JTVQeiWyFrAQTZQOJXwy3Lvre/0kGy/EOPZjF+7wSkn0qQA2NwOOWDESf6hm78lRyUks3kOXFL7xyVDjhsZdpWw02o6UAQzgJJrAwOEYL+xpcXQB7If3BEo/+7GaZs7fOHPEDY0Yyw7jPtTZtxR6u/UU3I9BAtxTc+oXGQpDkNuym5vpz6YJX8uVkO9ihxK6VRMua8NQlph7RV88yEAJ+rFf5xNNceJ4gqRc8+tTs/5XRibfaNldEQQLiRBF/juXq8r9dqKhj2EmE09BQzv9SfIK0UQwE1kon/Gns3rgUh3g+sPofx27oN5oz9i8eSIxY6E1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5oNUSz5KAHoH4F2KXuvVdBsK11UHSUwwSli5AXuB9I=;
 b=ZCFPZQc1VOpoEV+oAb8EiR00cv7uXky4NTp6ufzd6QPCcDvWsQQOyPOStFOaFeF7xxGv8WvPkILXH7aoTlRA8wbXVYZssh3ZBI/HqRArdnR/qXYPG+NuJ1eBtxSkJoeNrQ+37hmi4giouUT2fVr2w6fCRLi6wJmbAHltmyQa/JxWP6LIR5MKhXnpaLizTPOaDgM35fDsPdE9m/+d/IXKLmM2C9pN9nH1/As7cT4TZijcAqtA6fAk6jQfRsxZ1l54oSZLML6foQiE7AIpGoCgbLkfCThv9UorSi+P0JT9jZZEFLN67mYqeCOTZuNwtBCC13j96v/GES3g+74Xfav9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5oNUSz5KAHoH4F2KXuvVdBsK11UHSUwwSli5AXuB9I=;
 b=0+0BT2wEwodL6G/VRktXocbaas9V5Azp20QyJFC4plxSur1C+QsAZlE1KF7BDdXMHFHtn/KLjMMUeXy+yMm4jbpSomcM8cFL4CG8mFE8ErG+sUXz8nYyu9l4Ze2RZ7iaHk916JjnBj6FQBaAJnDIrW4luvEE7HbVYo2gc9n7E8k=
Received: from DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 07:39:15 +0000
Received: from DM6PR12MB4546.namprd12.prod.outlook.com
 ([fe80::3841:151c:51b:f37b]) by DM6PR12MB4546.namprd12.prod.outlook.com
 ([fe80::3841:151c:51b:f37b%8]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 07:39:15 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix MP1 state setting failure in s3 test
Thread-Topic: [PATCH] drm/amd/pm: fix MP1 state setting failure in s3 test
Thread-Index: AQHXHuwwrXXlX1AWZkWBtmuF74il2aqPnt8A
Date: Mon, 22 Mar 2021 07:39:15 +0000
Message-ID: <DM6PR12MB4546CEEE61CF02D37216C26697659@DM6PR12MB4546.namprd12.prod.outlook.com>
References: <20210322072231.23096-1-guchun.chen@amd.com>
In-Reply-To: <20210322072231.23096-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T07:39:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fb9a7fc8-840c-4e57-a5b6-be822b763025;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 240b2f23-dd6b-453c-deb2-08d8ed0597e4
x-ms-traffictypediagnostic: DM5PR12MB1658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16589846B8489CD3DBC3F66497659@DM5PR12MB1658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fwb7RxzWeV+l5zGoBPxdzG4iSORxvBRpiHsdQIUrJrDKKNj4Ve0gN0W99e5D+/5UIzD8liLCIUWChFQdFWp5uv8anZj68RXRQtaJhtquHT20dzN8rnsqwh0cAW4NVFL1aMWC4CQV9Cz59ObLy7nvR60EEyBAoqOynH0JIeg6GjIvRJlbFpdUp0vFc2o2J22ATXBP8tc9VeCE7zOJjeBGgutF9odB8MJ5GZCDFR1DSaWvVyMJjPfoJGy7Vnt9E0pvauMKF4tFskdNqRIqzkhv6d32ymFcKZrSHvWZgWGCfU8kW5C0LiIj8SVpROX3Yp0uvz2+7rGvZTGYMERPzPwLE9QpbnXh6vQSM2ymATC8M5FxhTmzm2UAYL5cKREupYaFXVA0x7zrXU/NttDdqEXjzkltLfaG/SJNkUfUlCZzRbhSheoiIem26IuBIJrsqIF6Tar8xRzve+JT+7YF6rI52XE+6urJZOlxJnBf1NZktI+0GGb2a4AFtRyEQVsji3VNwlYeb1SxMnb/obZ8IE0HQ4QuFEv41OG6wNurjznU+dLz8qB5MyuNg9gAh8zg2BunaVDkkmDl5ZF73oHZYTDFvcn4uCQKoKYWnkbru1x1Cbni18HB1+rxfkjCh8LOSfj6Q5x9ssbXYije1iM/+duN1T9Hwao8EKA3oqLunTlJDRA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(6636002)(478600001)(83380400001)(5660300002)(8936002)(53546011)(33656002)(66446008)(71200400001)(7696005)(6506007)(66946007)(76116006)(86362001)(9686003)(55016002)(66556008)(66476007)(8676002)(52536014)(38100700001)(64756008)(110136005)(316002)(26005)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?W4pEMAYOjG7j3Gpfl0VQt0OnQlR0HIOotdQCjgbYocNDHe5DpkTvjcudik4p?=
 =?us-ascii?Q?nJkhTHpO/aACrhusY6nEAp6LIBuRT6zUNzpzzg1p7i5I4APNiky85agcskYp?=
 =?us-ascii?Q?o2YgARgGkszxQ95XYsq2zPO5sdhe0sCZJq6t8yRPr+fgjL1uN6mTW5rOWsK3?=
 =?us-ascii?Q?XDmYjGsytOwTTaoAwSZnfJs0GKwy6V2lPRywTwX2z61Glh6A20i/cVjnCUau?=
 =?us-ascii?Q?2evVScNQHt5JMwcKy0OxEPPCHOZMo0xIKiA2O1Wk+OJiYGZ6ErCmRUPgBUqV?=
 =?us-ascii?Q?YxsrEOyMmqmX2CBplFpwW8Somn+f1DQk/oF6mgK6L18O3rcjlRGAOKKsnmSU?=
 =?us-ascii?Q?q4cnOBip1xdghiSc+CLwTFOOYa/KO0NuFtzoHhhtBMxPtovxfp1YCuL1adkL?=
 =?us-ascii?Q?NryPZr/uoBrwvNYY9I99i/F0NS+2WRnCvy/GhK58J8Y/+1Jt3+2f9DSk43zR?=
 =?us-ascii?Q?RXx8HDg+cvuWXmV3Rl6PAO5jb+FvNCgznQgbT5/NWWCR7W/kgWEcTIJ6NM6h?=
 =?us-ascii?Q?d8GntSAojJCSvDYtHqjJBnEgoTp57lE3oh4xOpn3rbsAuSDyA/22fQeWn4Xo?=
 =?us-ascii?Q?xCDChGE0RmcwsPfY99kbnaNqrL5MWRiqnNEKI2snC5q/rlcK36qa43S95beA?=
 =?us-ascii?Q?qhuWwmp2YY6cc05u+pPp5jrby5YsSQCN1ULRNsrZqjdp08cxXxvT5tmXk2L6?=
 =?us-ascii?Q?RqUySCe+7QW94ge4ja8ouE+Vw9fUyU8af4Mlp4NMthD5omYT8jSeTZW7pi4h?=
 =?us-ascii?Q?AK53mZjoVuTEzY6+Pl+YKJlXJ949hSjOVvsnkQjkcXcmlpXP43U9qx+yUgOs?=
 =?us-ascii?Q?4aLlcJXGMVJ+FRLMrwICAbKtN9Hg08SXVIOMzGYPfvixZ2VzQBdX0/Isptmj?=
 =?us-ascii?Q?gLQr/4RseFvIhdxwaEDTVP5IeHf40Q9HzX6XYQvbxhSZuwhCVYtl49sr7ovj?=
 =?us-ascii?Q?9UqFL1Y6X2g53etcqUZjB8/rLKeR9mcoewbiN1COditOXSQoDLiM8NuBQjVi?=
 =?us-ascii?Q?s7bQt4WwDmLGCL0qvfrDOaYo7/YNuKF1Shl7aaIta4IBEkhByZCIlVKQU/Uz?=
 =?us-ascii?Q?9leO+87C8uVWUths09RNLz5GUsJXrkLBuHM3/ngKmnlUVA4F0sbsXzcd66ga?=
 =?us-ascii?Q?xk2ztLGp9IJjiDAp1YFd+uJqzpHxgsFz1fdlvhgO/r/XoPXLWZn+MuGEB/nW?=
 =?us-ascii?Q?oaK23DyJLO6UTQpfwU8adiRfGdJqzYPhTlzpay07J7NkiSbyqMHRe2yzNQgL?=
 =?us-ascii?Q?6Or9wjZ87L2skBxBDCVHmwY4NRzrAzQTuWBO6zjy+d4pCLADqi4b3OHyJCa8?=
 =?us-ascii?Q?6seYEFx7H9BcZKY10PohumH0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240b2f23-dd6b-453c-deb2-08d8ed0597e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 07:39:15.0808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87QpsLsCyUmmpXWJNlcl8Lf5hA85OC1fhKoy5Tek4qcyJt1hQhd4upi6+xSgrxso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, March 22, 2021 12:53 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: fix MP1 state setting failure in s3 test

Skip PP_MP1_STATE_NONE in MP1 state setting, otherwise, it will break S3 sequence.

Fixes: c5f427745ecd ("drm/amd/pm: fix Navi1x runtime resume failure V2")

[   50.188269] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* SMC failed to set mp1 state 0, -22
[   50.969901] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[   50.970024] sd 0:0:0:0: [sda] Starting disk
[   50.979723] serial 00:02: activated
[   51.353644] ata4: SATA link down (SStatus 4 SControl 300)
[   51.353669] ata3: SATA link down (SStatus 4 SControl 300)
[   51.353747] ata6: SATA link down (SStatus 4 SControl 300)
[   51.357694] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   51.357711] ata5: SATA link down (SStatus 4 SControl 300)
[   51.357729] ata2: SATA link down (SStatus 4 SControl 300)
[   51.358005] ata1.00: supports DRM functions and may not be fully accessible
[   51.360491] ata1.00: supports DRM functions and may not be fully accessible
[   51.362573] ata1.00: configured for UDMA/133
[   51.362610] ahci 0000:00:17.0: port does not support device sleep
[   51.362946] ata1.00: Enabling discard_zeroes_data
[   52.566438] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
[   54.126316] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
[   54.126317] amdgpu 0000:03:00.0: amdgpu: Failed to SetDriverDramAddr!
[   54.126318] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc hw!
[   54.126319] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <smu> failed -62
[   54.126398] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
[   54.126399] PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -62
[   54.126403] PM: Device 0000:03:00.0 failed to resume async: error -62

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0a6bb3311f0f..15e239582a97 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1027,6 +1027,9 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
+	if (mp1_state == PP_MP1_STATE_NONE)
+		return 0;
+
 	if (pp_funcs && pp_funcs->set_mp1_state) {
 		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
