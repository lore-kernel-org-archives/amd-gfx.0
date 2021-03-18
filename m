Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E12C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5984D64E2E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5984D64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27856E899;
	Thu, 18 Mar 2021 07:34:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636496E899
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBqUPvyaXVqC6DfVmQaKWczKrGsiGooSgVzXLdSaw/LBqqkySKtkeuKscUhUA1IdmCEujE77FJ/Lx37kdJhHCfpbqQCntoqf+KPUT+/U3PIyQT4j4w/3ic3GiLUzT8pMinUBoxUBgCfHlrQIqeshQNQN+99BxNzJdk6yzILSiWW0xqTiA63U6fjV2rqK8AI/6W6s0jez3rQdzHs7Hduv9m65iLwmizmrQGsZSMWJiNPGmQGCkVkxJxfmEWqsoIPYqChvbXEkt/G/xUUcDPO8ZR5vl7Csi5qb8+SDl1EPyozNcTA3SStWfUs3rTdrDEB4dez2PxpcW71NLqxQLtLaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/kWOa4cFnmtjEGQVvqBDQyh7AfMIrSmZxyRYatuuxk=;
 b=VDzP3T+TeVHFKRlai2Lysh5mim9JHMBRbdjgVU+ykfwIkyygcRkWN7/alkSxn7EIKovCx7KAk4OsWGfyZ8/uByMVk+j5tmL3nOWJJLiVJAI6KE1B4Viwlu+g5ArmJoSvCv/42qI3Ai1vuBxgN9YLpIfdlpj7plon9YTA/1UyYDhfQRT6sOU0dqsHB0XkaOnSladohDH0+MfXlg2o51Yzf1im8fOGzYdZJ7bjRUknqFUNzdPmTrpk9jwX4HVrXExvBcDBSh3tMPqueI64ZeoXssfmbe8h94IS5KkRSbzua0wZXHcVQIAIgb/Gt0zDriq/tcKT33g8/VDKQkzgoqUg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/kWOa4cFnmtjEGQVvqBDQyh7AfMIrSmZxyRYatuuxk=;
 b=fdZRBYcS13g4eR/oWN58XxxFvjCY9qS9f1JQlmJUgYmcdF0AMSAQE/OEmuEygFNvlkE67bbO6uk7YIu7lZnebeXU641YiLdiDAEQcONR7wRWUS10ciLtjZpDgUnRdSFKfY6DGlqRvN6BL9RklveTw+iGIjfLPsZyh28khYkLl9w=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Thu, 18 Mar 2021 07:34:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 07:34:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 13/13] drm/amdgpu: skip kfd suspend/resume for S0ix
Thread-Topic: [PATCH 13/13] drm/amdgpu: skip kfd suspend/resume for S0ix
Thread-Index: AQHXG6/sHgHFx4zjXkK+nJ0AaMQ+NqqJWqgw
Date: Thu, 18 Mar 2021 07:34:41 +0000
Message-ID: <DM6PR12MB261969EF42111760D3DA5AF5E4699@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
 <20210318043323.3989-13-alexander.deucher@amd.com>
In-Reply-To: <20210318043323.3989-13-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-18T07:34:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4d762434-0de1-4867-a913-b5ee7544b6b7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f119d2f0-51af-4d6a-6785-08d8e9e04bc6
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB250410E3DEA9EC431897BED8E4699@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o92EzrJRlQjjCRBxkMxcAGay0lNiULRf66qEWOuJqkB/NfxaUDjBKVsKlDXXm4d1rZ1nszmYcGCc9GSluUdZna8X5/KN62AZRU9umvsxGkyUAkV/zRVAVALfScP6vO9QPzWe4C4IpPeAIf1AYWll+DHq6zCik6xTudxBw/fBQ98HZNdCT+VRq37IiJpRJeRS4SfmMa8l7ByTJI6fdWAxk/bCcugBO4PqFH5pdcK9sHEtc45LEXS/7Mume/Q0m3m7WPfXA9p0edvShYDqVhrc56nMizGVnKAhSSinozJLtiwvwcXRjbzZxaloW09QurP2NXofO6ibITsEiYl5VMJkgLSuaMkiUmnY2ajFIFFPEUton6C8iTr4picIB1dF7svpW1lwu9DdeGODt008Lkgnf+c1BQf9xE4WXO5CmpwzZaj+vc1WfBETzsIfhHxlp6Z9Fdp7bUMbtkqQtIF7qT55xONip9PE2ty0bL9NaqLRoVQOCQzUe/wU6aRuPR17E0lCkrRTGUJrY6snQNhF7f8EC4JZpIoPGYAtvbfiblTZ0Mt1HZoPyNPjIfDaVYbF2wOnj2SHYnt+3OlLPiXrorNhkblg0vrTiw8IZqZ/rPGD4fU+XlMjpfshACM3mmnjcXRVS8wePslnpsjyTD7MkFXyenCmzc8tng/Md70H9Yyt6WBzm7o/ICNw4NmBdUySjvau
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(7696005)(8936002)(64756008)(26005)(33656002)(478600001)(52536014)(83380400001)(9686003)(2906002)(55016002)(8676002)(966005)(45080400002)(66946007)(5660300002)(76116006)(66476007)(86362001)(66446008)(6506007)(53546011)(71200400001)(316002)(38100700001)(4326008)(110136005)(15650500001)(186003)(66556008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GhY8o7HZ5bDDo1HT1HI3mhlJ11sy/nqSFtH0XmorJDhgTh4sTQQB73C1XWZ/?=
 =?us-ascii?Q?EwXb25iuNR2pUNeDe9S1yZFiShvsXFOjKgBWb/oG/HXvQnkeky2dqxWpoteB?=
 =?us-ascii?Q?UvNVNL7Os0mz693H72cU2F4jBRJN90InVCTkesZdYmZqUE+hmLKciQgJrQb8?=
 =?us-ascii?Q?/U7xRwhWP1wq7R1gnw2AvDD3qy2s6Cgbso3okvrcQ3GIFpuOHvud6GSuDyLE?=
 =?us-ascii?Q?OlnwClBr738nlITX/vKlxvE1kjg4HyZznK+/yPjY+6vp9cdnS2JyXsJ25Hpd?=
 =?us-ascii?Q?udwoBxqQw/WkeJIxy9HsWXdBhJNxqw+JO0mOTJNuxggr0+FSB4q5hkWEYSPU?=
 =?us-ascii?Q?inQm3AEkExHa4H4FCx/N4DsUGgNMLtwbFkz/GljmL8M+nGzVkKGxD3ndH2YT?=
 =?us-ascii?Q?au7zB9NixbfPBSGqsHgLj/6Xz15sYjzipz2wzSSo6Ihv8TUZV+InyTP+lUGI?=
 =?us-ascii?Q?fnuPHLwsVqW0bqtbbfEjp8t6VssvZSJ/CyzoRABDVDMfI/FWk1OcUpLXFj6t?=
 =?us-ascii?Q?FCPSX1xxrci6tOef0h3+1Ms02DIji6bblYb/id/i+fzUFVGyHN4DAlg+OYou?=
 =?us-ascii?Q?gmUpV4dnDo6yNAFDSky4IfIfyZKWgsvJkBKlfY596umIwwwAREhgPZ2FtSOX?=
 =?us-ascii?Q?bPqkCT3bMQalq6fpa3Bo/xYK/VAGE9iR/fVnZIMj59shlY5HuZcWotx3NFxX?=
 =?us-ascii?Q?wkCXNcAbnsW4a7wg4keoWCOfmqfadi4nzpcyzDgrp4GcteRf/luXgJWfPRZt?=
 =?us-ascii?Q?sbKebGMEktjWGCYWsvvtWEf9fZC4KlZ5buXVIaarmOppaKVwSbEAkIkFuatu?=
 =?us-ascii?Q?mUTIBM076+hvYWv9feFugrfzStkwgE+ZYn7AtlDOKfYb2maDnoadPC/HlQX8?=
 =?us-ascii?Q?wktYBh06ycvmQpWvvggDqOrOMNqtX+YWLVx3By3/g7/P7JP158+0XboJVLWr?=
 =?us-ascii?Q?1s42kFb7ivHOrl65I4Hy8x1LCY8+xvd+SAiEIcotXvmn/PxiMh6o2JYzQxiJ?=
 =?us-ascii?Q?4Kf9ksDs0Wns+4gDCcbqb0doawRHc8kcMOwAr0CZ0z2RBJ1cQRGWd1iA9dAi?=
 =?us-ascii?Q?IXa76NYGnlLCijsyh0oJOFPYMMQWWo/J86xl1u5aYCIEd0Q5bd7WYTtvZ1Qf?=
 =?us-ascii?Q?zXKTfUCYE7mWqziqmqrsto2Q38/2QGby1pEU3cYn7JSYhDQiRoyklgfNZwZB?=
 =?us-ascii?Q?7i9ow9zQEQeE9eHy7G8tezikLaNmtBl4aUBsFVLtJTupy92Njy9gW4R1CtPG?=
 =?us-ascii?Q?ZNLwDyFg6lTkK/AL6oNq3QMhMBIV1LlJrToNvi4unRIW2hh23iwnjjCGbz2r?=
 =?us-ascii?Q?fCXMPfxhCU1mP1OMPRN98u03?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f119d2f0-51af-4d6a-6785-08d8e9e04bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 07:34:42.4985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWybsN4/etewu6zw1KyzI2w2jmCkPRwkKwA3BMNqdpCbfofCI1FSCx0RI7ft02r0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Patch 1 -7 are reviewed-by: Evan Quan <evan.quan@amd.com>
Patch 8 - 13 are acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, March 18, 2021 12:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 13/13] drm/amdgpu: skip kfd suspend/resume for S0ix

GFX is in gfxoff mode during s0ix so we shouldn't need to
actually tear anything down and restore it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 965b4f18ddc7..319ad9326a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3705,7 +3705,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 
-	amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+	if (!adev->in_s0ix)
+		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
@@ -3765,9 +3766,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
-	if (r)
-		return r;
+	if (!adev->in_s0ix) {
+		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
+		if (r)
+			return r;
+	}
 
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ca595a93ae68c497592db08d8e9c70c62%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516388426325351%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=JS6OofesEBdvRjCfgoBK8H1QZeP7xpdVUwUl0h1ls9k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
