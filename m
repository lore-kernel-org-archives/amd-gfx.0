Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAE6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F9010E1F4;
	Thu, 20 Jan 2022 09:47:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E8410E1F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM5UBSdotyhKdQYDILbJnmI5gbNxzUwnc/ykj88cM9zkdskknAqqq07o+DYEtCP3/JA8M1ycKnkfjZheRiXEEeqlZpHcobZjXTv8IqDYDCpr7f2Z7iWhCdF3G5LX7PYTj5Kzfx2+voVT8MrYY1cqcRXFJnNlN4uvU8tYao5sHU0FFEBkAGYMsh4BsoiHJvg8ktMkmHC1XcBTJOlWv+T7iLMSMvhhAqUPgGXbnt4lHDi8F/zhshaJpImZESFyHC2zAqcH+ZnPku4Z/ZTyg0YftsexO101aqrENjDFBTTTayXs7cN4D4F5e/pOqt3Lg8tPLXBuDwkciJfVjAjK6OmolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzzAEGhXY929JEza1uBY/swWU4AAQQUbCasX66nSBn8=;
 b=cixH/nfj6BjfL+al0k2Q8m6zyQsy9m8zYBcG6tKSyTIG2qttnCAY7r9weIR/alfU8TvQAO4ztnte75aBYBA3vq6XJwckHJDoe5pPUITZWLZx1OGIGXYDCNDB3gL950Iz/YLLi8B1XQqypapFzgkVqeJ6S8nBjn1j8bUgkawz5hWfSRPSidnXEXbbl/u1avYQogO9FLSIm/TAs92K6RAdnjK2IU2stFsxbfXO1+9fBh9H2I3O86EVTKxglG8VuHibdNxr/AfgNBhlfaxf9Tngf0nnFFTXXAKiBNMEBWJSkofONY3cmSEQKNP7nxCpp2DvGZCehUjjvbxhj3FDhxuLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzzAEGhXY929JEza1uBY/swWU4AAQQUbCasX66nSBn8=;
 b=VCokLfjMdHX9paQNvQqju2mzV5GEUbBLbzKB7WHCacC0qniYnJFMjfjseic3doKciGSclTg+Ha3H2yEparCJJB+s16elQb+aAzmbDAExzu6JOgZTcV6Rib4FseJI9/v6K8hw9/KRVXosMpCEeiHvYCyHQr0Va2UEVzjYs69YQHY=
Received: from BN6PR12MB1555.namprd12.prod.outlook.com (2603:10b6:405:5::19)
 by MN2PR12MB4829.namprd12.prod.outlook.com (2603:10b6:208:1b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 09:47:26 +0000
Received: from BN6PR12MB1555.namprd12.prod.outlook.com
 ([fe80::1c48:a77c:d1d6:1f79]) by BN6PR12MB1555.namprd12.prod.outlook.com
 ([fe80::1c48:a77c:d1d6:1f79%12]) with mapi id 15.20.4909.010; Thu, 20 Jan
 2022 09:47:25 +0000
From: "Ji, Ruili" <Ruili.Ji@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: svm deferred_list work continue cleanup
 after mm gone
Thread-Topic: [PATCH 1/2] drm/amdkfd: svm deferred_list work continue cleanup
 after mm gone
Thread-Index: AQHYDVDdb8r0CGos0EyNaww3NcQ/56xrqitw
Date: Thu, 20 Jan 2022 09:47:25 +0000
Message-ID: <BN6PR12MB15554602066165A6C9CFB3139B5A9@BN6PR12MB1555.namprd12.prod.outlook.com>
References: <20220119162246.21457-1-Philip.Yang@amd.com>
In-Reply-To: <20220119162246.21457-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5d451f00-88c8-4e0d-a740-2217a730d021;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T09:45:04Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ddb056-f440-4b24-cf7c-08d9dbf9dd85
x-ms-traffictypediagnostic: MN2PR12MB4829:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4829B58093B605D0A16936699B5A9@MN2PR12MB4829.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6CpxhgEwi9VZRTxKNYGlRvr7RV9FlpHutndggxt0zd1I3WQiTpDdwiMcZPUCyGW6bMcsPgodzGVgpWKl0nkUqH8MN6mv6KtFneLsvMgJYVRinKCH8hjIVyuqJGWNkRTo8bY2fWu/N3NlIkp/2K4qTuTh57uQlboVTtomqyoI/KCFRiNObrih+oVsRwVnlBzW4xQRkB09sEmkq0hHT2/p1nNNb2LMPRAFVXzCGe9CZdimO1s5zyocKyzWfZdRaxhmA8gV/ELjslPyttxUk97thAfCQG0TuN77yBJrdrv+ROQ42jPhGfB/mHrVvkVpnSCuR3SK3no/9nANV4Z3EVP+zfYbxoScRsCc/eoDXQLORTfwDLM18GLSrGEteeUerJW2/kZAeP94irGCXDIcI/U3VhcQjwhFRpuSi1zxTW/xEB6tFJq4BmNjwjMBzLfBg+6w+1M5rmYySI5v9uyTAeutKzlkl4Aoxga+k+f7cCB2W9fiv7XnNBIw+J5qopDgrf8sqkVghmrIDEapUNf/a/0iVlulwIHvoVoNhec7GPgS2CTTA+dxj9rVK3pn0D4vkdbxeAKuNIlhnou+TxZ+1jtssV5VOgkqGvdf2fC92QL+H5pApqmIJDbn67Ite7fHje6fIYl8gakyj5GkLEzvpPUs0dnD7WOdXi+jdyB9Dg3I+5pL3tVxHnrtJVKAMJaX9JYufPpXNTBO4KcZq6ii0MRWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(38070700005)(316002)(71200400001)(66476007)(110136005)(38100700002)(122000001)(2906002)(5660300002)(53546011)(33656002)(508600001)(26005)(7696005)(186003)(76116006)(9686003)(86362001)(66556008)(64756008)(6506007)(8676002)(4326008)(66946007)(83380400001)(66446008)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YTY2WHhJb2NLRHl5dXFveERXRzBieS80M1lYN09HMTFXRzUyYjJ5eHhz?=
 =?iso-2022-jp?B?QU96SW9DYmRPMXpKVDI2a0NmSjJIVE81WS9kclB1dE13OEwrVUlRS3dK?=
 =?iso-2022-jp?B?K0ZheUdWekF5TnlxeFBGSHdHWStNcnFUbUZVRk5uWGpRSktGaERha3hl?=
 =?iso-2022-jp?B?MVNYbTQ3WEVodGE1OGhNQ0xzWEE1bEFiS29qSlpkZW45WHBMcWhuR2Y2?=
 =?iso-2022-jp?B?Q0Z2UnYzNW1uMTdJTUcvZXBnWmFzZDg0c3dZUnFUM0JSR29obnR2MUli?=
 =?iso-2022-jp?B?ajNHc0daNjFaY1VRcDZjR1podFh1WnRYNHJ4WU5paTFSYVpndXRXdnpM?=
 =?iso-2022-jp?B?TEYvYVZMK1c1bVVCcDFVVUwxRTZtUHZsNTJWYW1Fc1VuOVJGMTVsV3BL?=
 =?iso-2022-jp?B?bkRpa2JnY2Rzd3A5VmlTd1RJMXA2Z3ZSVE5ieVdMYlAvcWVVQXN3MXdM?=
 =?iso-2022-jp?B?eDlIdXRtcG5iaHowcStJdnVSYW8wcGJzTGRnb1FhNWtHUGgyZ2IzYlVC?=
 =?iso-2022-jp?B?QUpqTDM4bDh0YytZVE1ScGJSczBYKzBPR1pjZFZkM3hBS0o3OTl5TlA3?=
 =?iso-2022-jp?B?VFIzL1FKcXJrZ1lEQ204YXd1NjNUM0lreURhVDdQanVISGpCdHFkK1ls?=
 =?iso-2022-jp?B?WTdwRzZkUDVSaGxVazNTUnA4MTZOcENOK2VKcW51eXJsSXowb1ZpUlp4?=
 =?iso-2022-jp?B?Y1ZIYS8yejRiME9NZEIwWWJCQ3dtaldGNzlrV0dCMkkvUjlXQXRpSkxx?=
 =?iso-2022-jp?B?M1hGeWtNVVFHMkc2YVFEVStaYm82R0pRWC8zcnA4UTNZZ0JZUVk2dm1O?=
 =?iso-2022-jp?B?QzhnWTlwWnpTeGFpTWFaSXFjV0M1ejhuYzRtbW5wV3BXamJjaUpKMGFO?=
 =?iso-2022-jp?B?UnFvZjFFclhYMlRBSERiWmlPZHN2cGw3UUYwMWxiSUtKZUpmWGNQbFdr?=
 =?iso-2022-jp?B?QnRIQ2lORk9YTTAwd1J2UGpEY01NVDhYSXF5SmlHREg0dXFuck93cFlK?=
 =?iso-2022-jp?B?MzkySnd2dkZVeml3aUpqYm1rS1hvR2R4SldaYVJheWxyTlhnQVdmUUhx?=
 =?iso-2022-jp?B?WmNJLzhmbldWZTArQXlBVmlxZ3I0RUE1bjZJcXFnNG1PTEhMUWhrTXV2?=
 =?iso-2022-jp?B?MFc1cEo2dFpCYmpWcVdLSllRQUFDaDdzRjZvYzVoUXhWUzIrNWFrV1Jr?=
 =?iso-2022-jp?B?VEJEWjRyTlhyRDJLenYxdXVsL3p1OGI5cW9abmtYZHFGL0RYSFR6eHdo?=
 =?iso-2022-jp?B?R05uVFNlQ3dZRHZwUCtBSFpSVEJtSWZKcFNjWHFCeisrdC9PKzU2bnVO?=
 =?iso-2022-jp?B?bjdNT29NVlUxR1VEM21vZktDcU1Rb3VtSVhnY0dvQkpRbVpnNW5TQlFj?=
 =?iso-2022-jp?B?SCt0YUNSWEZZNDZhVk54bFhjVFJ6TnVhbEgxeDRzMVNwUzdlSjd1dm1h?=
 =?iso-2022-jp?B?MjFQWEg4QytCL3dyL3JtVm9iRUJhemVWc3B1N0xTMnh4alpvVVIrM1pV?=
 =?iso-2022-jp?B?WnBGdTkycytqTGQ5MHBYODh0TTladVp2ZTdrVDF0YlVZVkFFaFZjSHNz?=
 =?iso-2022-jp?B?OGZaNG9NT0tLbGNMam04SzkySXREek1IbFpQb0EyTE5CS3QyT1pTRys2?=
 =?iso-2022-jp?B?M0xic1liN3JMNGtYUGRqNHZONDdOb3Z2dFcvSU5ha3ZkRC9RMUFZSkV6?=
 =?iso-2022-jp?B?dEhYK1daRmQ5cHZRYUFtaEFyZDNuSzNuSGxoOWtSOW4vZzZrU2NlTVhM?=
 =?iso-2022-jp?B?ZHZWU0RvQkg3dWozdE9pS2c0OUYzNVdjb3A1ekZ2ZXVyU2swellxZ2Vp?=
 =?iso-2022-jp?B?ZnF2VFc1ejE3YWMvbXZ2VDU0SHNwZkhUbmRXSW13QVprUUVWdUMrUVpi?=
 =?iso-2022-jp?B?VnRkYlpoTTAreTFXdE1qR0w5SGRqWkwrZ3JzNEEyYkVibkE0S2J3SHJO?=
 =?iso-2022-jp?B?WmM2dkRSdlNPUmN6dFpGdmRqbFdBRW1GS3d1d3FYNEt0aXZSQnVDS0VY?=
 =?iso-2022-jp?B?a2hjRVlObHcxRGduS3Y3d2ZDVTFxUlRYVTlqRjRBUUk1MkhWdkw4VTFW?=
 =?iso-2022-jp?B?WS9ORFRXT2ZYN2I5SHl6VGRvbDk3bnlDbjZnTlBBZ00yNGxvTjFWVWZq?=
 =?iso-2022-jp?B?dm0zdm9VTzV4S1FLcjlidGtLMFRmZ2t6d2k0WlJUaHRCUHBXUTkwNDlk?=
 =?iso-2022-jp?B?V2FPemt3UnNsVWMwc21qZEJXYk42WjVxUnprMUN0bkNmaFd0MDN3OTFV?=
 =?iso-2022-jp?B?N1dPTHlOdnJQR1FuajhWYURnTFpDV2UrcmxqY3N2cDNXUTlWcWJyWnBF?=
 =?iso-2022-jp?B?bCtGZWlsUCtBeUdGbkx5T1l5bk5LQW1taFo4alhJekdiaXpRKytFenVU?=
 =?iso-2022-jp?B?TU5lSzA9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ddb056-f440-4b24-cf7c-08d9dbf9dd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 09:47:25.8572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhTrwmedSkpIYASRLFNdc35/LQLgzOmUrCv6xK+RViijzPAmExdWnmtOvlB/kC9NiQDOgi7HiyUybAH/habzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4829
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

sudo ./kfdtest --gtest_filter=3DKFDSVM*
sudo ./kfdtest
Test results are pass.
Tested-by: Ruili Ji <ruili.ji@amd.com>

-----Original Message-----
From: Yang, Philip <Philip.Yang@amd.com>
Sent: 2022=1B$BG/=1B(B1=1B$B7n=1B(B20=1B$BF|=1B(B 0:23
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>;=
 Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: svm deferred_list work continue cleanup af=
ter mm gone

After mm is removed from task->mm, deferred_list work should continue to ha=
ndle deferred_range_list which maybe split to child range to avoid child ra=
nge leak, and remove ranges mmu interval notifier to avoid mm mm_count leak=
, but skip updating notifier and inserting new notifier.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reported-by: Ruili Ji <ruili.ji@amd.com>
Tested-by: Ruili Ji <ruili.ji@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 41 ++++++++++++++++------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index f2805ba74c80..9ec195e1ef23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1985,10 +1985,9 @@ svm_range_update_notifier_and_interval_tree(struct m=
m_struct *mm,  }

 static void
-svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *pr=
ange)
+svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *pr=
ange,
+                        struct mm_struct *mm)
 {
-       struct mm_struct *mm =3D prange->work_item.mm;
-
        switch (prange->work_item.op) {
        case SVM_OP_NULL:
                pr_debug("NULL OP 0x%p prange 0x%p [0x%lx 0x%lx]\n", @@ -20=
04,25 +2003,29 @@ svm_range_handle_list_op(struct svm_range_list *svms, str=
uct svm_range *prange)
        case SVM_OP_UPDATE_RANGE_NOTIFIER:
                pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n"=
,
                         svms, prange, prange->start, prange->last);
-               svm_range_update_notifier_and_interval_tree(mm, prange);
+               if (mm)
+                       svm_range_update_notifier_and_interval_tree(mm, pra=
nge);
                break;
        case SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP:
                pr_debug("update and map 0x%p prange 0x%p [0x%lx 0x%lx]\n",
                         svms, prange, prange->start, prange->last);
-               svm_range_update_notifier_and_interval_tree(mm, prange);
+               if (mm)
+                       svm_range_update_notifier_and_interval_tree(mm, pra=
nge);
                /* TODO: implement deferred validation and mapping */
                break;
        case SVM_OP_ADD_RANGE:
                pr_debug("add 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms, pran=
ge,
                         prange->start, prange->last);
                svm_range_add_to_svms(prange);
-               svm_range_add_notifier_locked(mm, prange);
+               if (mm)
+                       svm_range_add_notifier_locked(mm, prange);
                break;
        case SVM_OP_ADD_RANGE_AND_MAP:
                pr_debug("add and map 0x%p prange 0x%p [0x%lx 0x%lx]\n", sv=
ms,
                         prange, prange->start, prange->last);
                svm_range_add_to_svms(prange);
-               svm_range_add_notifier_locked(mm, prange);
+               if (mm)
+                       svm_range_add_notifier_locked(mm, prange);
                /* TODO: implement deferred validation and mapping */
                break;
        default:
@@ -2071,20 +2074,22 @@ static void svm_range_deferred_list_work(struct wor=
k_struct *work)
        pr_debug("enter svms 0x%p\n", svms);

        p =3D container_of(svms, struct kfd_process, svms);
-       /* Avoid mm is gone when inserting mmu notifier */
+
+       /* If mm is gone, continue cleanup the deferred_range_list */
        mm =3D get_task_mm(p->lead_thread);
-       if (!mm) {
+       if (!mm)
                pr_debug("svms 0x%p process mm gone\n", svms);
-               return;
-       }
+
 retry:
-       mmap_write_lock(mm);
+       if (mm)
+               mmap_write_lock(mm);

        /* Checking for the need to drain retry faults must be inside
         * mmap write lock to serialize with munmap notifiers.
         */
        if (unlikely(atomic_read(&svms->drain_pagefaults))) {
-               mmap_write_unlock(mm);
+               if (mm)
+                       mmap_write_unlock(mm);
                svm_range_drain_retry_fault(svms);
                goto retry;
        }
@@ -2109,19 +2114,21 @@ static void svm_range_deferred_list_work(struct wor=
k_struct *work)
                        pr_debug("child prange 0x%p op %d\n", pchild,
                                 pchild->work_item.op);
                        list_del_init(&pchild->child_list);
-                       svm_range_handle_list_op(svms, pchild);
+                       svm_range_handle_list_op(svms, pchild, mm);
                }
                mutex_unlock(&prange->migrate_mutex);

-               svm_range_handle_list_op(svms, prange);
+               svm_range_handle_list_op(svms, prange, mm);
                mutex_unlock(&svms->lock);

                spin_lock(&svms->deferred_list_lock);
        }
        spin_unlock(&svms->deferred_list_lock);

-       mmap_write_unlock(mm);
-       mmput(mm);
+       if (mm) {
+               mmap_write_unlock(mm);
+               mmput(mm);
+       }
        pr_debug("exit svms 0x%p\n", svms);
 }

--
2.17.1

