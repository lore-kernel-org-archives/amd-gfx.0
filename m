Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C0C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346D3619AA
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346D3619AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65616E223;
	Wed, 31 Mar 2021 09:01:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E72A6E223
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 09:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep+8p7wCnJJfiTDpfVmQ97INO8jHQR77bWBBK9Hxnm0S9ksZkYJ0L7lvSpQpQLSl0QUqdoJPw/X7QkgoYnM4N5l9RHryQwFCwJrfkAdHwOrqaO9bKq0qp05rTCWiiDVH5Q33bpC5F68uaMZ37bQYMdkEk5ZLJ48O03MoJ/ekxhi3ViAcpLFukhSCx5kF2VKwgM3B1icLjRDcQ+uWp2EQ+82D+nq3GxOrGfUNlKm1x7eFBHlLQTe6XKB95wSYRvl9D8tlIO3bvMoFntPUeEHrWNSJyWKrG8O8MWS6oB8UaQkeSlcafZyHqVzMaxIFYBm+EwhmUtPtrIwIXfwiTfMMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhPiqySyAQBQR+k7AzklDuP5gU6xtqs8W6lGSyzD1Ew=;
 b=ISue9CyIqY4NPKxIOOwnalbZSd1Sh4VzhrVOM22+vvwjRr18+/fM8qOfooP88AoB8m/u3NxJNGsNcqpaMObVfOTRuIuA3Kn6bZUjso/O7N9/etVUbWTxu10IFZl1TiL3Sch+PHUHlnuw20Wpv7LBzxiUxbqbbdfrdKv+4Ox7DqyZ6Zu1GlFXHE44oLVA0rNimV2AKe11KuLGCQmEVoUZXvFj0g7lruzF981a6Q1KHCvF3fNpwMDB2uw4yUqYD8MZ+RN+MVMg0I1cNHvp3ZMS1vsCfYxzTybxbZC0Z0SaG60aSKW6xbbrtmcebPKMadQBdhrcHHUg+HRzvvxUJzS6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhPiqySyAQBQR+k7AzklDuP5gU6xtqs8W6lGSyzD1Ew=;
 b=T8lyeP0JomgRLkMDkrMx/urOHREYPMNjWihdNd7mCpbZGKMgnxniR/B58n0/3mMnqIciBLCfVv9FTIhdM8ipMSBhh4I0kTwoz3fI0u6ne8CeO7RQpWr2cqWCwS3nBaAndLiq1eNTolmLOvj0/IKQjBPNim+BrE4WvPebwiz6Rl0=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2599.namprd12.prod.outlook.com (2603:10b6:a03:6b::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Wed, 31 Mar
 2021 09:01:47 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 09:01:47 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Topic: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Index: AQHXJUkHjQ3O8F/sT065IKansoIo16qdzltg
Date: Wed, 31 Mar 2021 09:01:46 +0000
Message-ID: <BY5PR12MB4115E71D30C636258455A81B8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330094235.69090-1-Emily.Deng@amd.com>
In-Reply-To: <20210330094235.69090-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=266b6fb1-4d85-4d1e-ba21-b0d02abb0e1d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:01:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4dcf7c41-6401-4b84-8dea-08d8f4239d3f
x-ms-traffictypediagnostic: BYAPR12MB2599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2599C4DBD36A3AE4EB9C04AA8F7C9@BYAPR12MB2599.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZU55LtJSuOIH5TcCU9uLOb0eCHD2yap6sg38bsBld7qZ2vLCR+UvuIkojKAcg9kyEN++FDtwG8btCvqX20+pvwm3IoRLu8jQIDxcrKRBnS0P6BArH2B3A4RXw7ODklqBDu0uRn6wWKJGh62HqSrmkOvNua3ZKb/y+pABr05iHmWX5kiaMxxO1OXHuLVdrRbrDwjQao8MLNNe4Dppi4sSx33k4co5xVdYt3yUSHxTOAvNjRnN2vfPKTtkRnAQPhOWSGyvjUTWIM6rOFiJjx/RoEbViNve7VqDY5C/3YVQMhaW9b5tY8p13oA3NdskBFnnclPgwrsxVnJCadpmCZNmJgn7CzjNSoLK6pl6Vk2knwRcwNIqdw9GlUuCI+dq/DbBC9VCQxjU0I6FRqOPXSQjDb0J2Sc2gDyJkIeGjW1B4vR0xhWRI1mVMFJ8EqPMuzoZCGSbUVQdBZYKPDrl0Z8Es6PGHDlax8rt9NP+RQ0TRI8Lc5ylxZXS6RVW8Slk9RjPTzy5yvBSkrfO6kNoMnVp/Q8+rR5Pu33b7ljD4N5HWiOCIWp0frVpYybrF/U6NVd/VL4E+718sUbAn0Bh4DSGFATJ0oYGWmtATXfkvT4XnguggLX8AniWxBePs9oJ3u84cn2ZYzcj1R1Qk0kXG4bANRpBuECw46fhM7Irv6FmLz8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(6506007)(5660300002)(316002)(33656002)(110136005)(38100700001)(86362001)(71200400001)(8936002)(478600001)(52536014)(66946007)(7696005)(55016002)(8676002)(76116006)(26005)(186003)(66556008)(66476007)(9686003)(64756008)(66446008)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NIjNTE5MrtTVQEAnlq22bQZQInZ8caM16WkqAoibwz2y6dbAySkVXqrxVOk4?=
 =?us-ascii?Q?u0cAMh3RYrsVnLdmB1079tspGG9RZFP6ED80HtRwxfe3A92JqW6N8r9j2eQ4?=
 =?us-ascii?Q?mBYY7GTtzFegyWJ6Wnz7LWEvaZ+SVB5qjaxiTi/wgP0CvB8/oiZS5FPAuSLi?=
 =?us-ascii?Q?uU6a4JbZJ2U1IZ/fsE3CV6GVauqSmrGTCBO9U/0UWWG3/ro5h08v4OOwTbCA?=
 =?us-ascii?Q?LKAgSP5hMJ5lbqAlzduUPL1B574+nboc5nt/hwdMGrkBIXJXcy9p+wVuGL48?=
 =?us-ascii?Q?UbAy9ruKCqxzK/6Px7s6y5j3ylyC+9eV6AJuZLRLEQ4WcCEcGNOOkdxkl+EU?=
 =?us-ascii?Q?vDHsXkU0sZyt+E+3IWhnYxLjwzHJPfp+0skAY30c9SqNCAO068FXHn9WZwyt?=
 =?us-ascii?Q?IqszzRPirdMdQHuFkajBSHFXVLMS7YFuZIW0C9HjVUgUaBUc3WycJY8xZyXY?=
 =?us-ascii?Q?652zb7Cal79NNOK+9F1aywMzxzSyCdkdT+5kCHiYE6L2QF8jcxAi+BaVza9g?=
 =?us-ascii?Q?taNYBQh40HFlhUZO64VhHMOP9i5Hg9VBbfQSVlkCMFodhxnFoEgEnU/bo1YU?=
 =?us-ascii?Q?iagnr56ybduzSQdT9EhbEPG2YtxqA87M4TTmCg+ZqfCS+cVWAH1JRogpYeCx?=
 =?us-ascii?Q?XF7ABwWxv8bhXIX4zMvYbDf9h4x6uEOIUn5Ckj5NYMxMu/RzxjjbwCV3vgln?=
 =?us-ascii?Q?LstftZCcD8h09dVEVRzRQAslJqYE3Czt88yFkI6Vbbz46Zl754mpYSAkoK5z?=
 =?us-ascii?Q?XRtKojE5C9BkapIaQWefPQUcRsQtP5XeSAwBhiuFKCLuFxrtNai9y5SkPhL3?=
 =?us-ascii?Q?GRCNDGZcrTaZcBUYbOZ99AXRMe1Sbfp898GPy/H5ucP2biwxPpEajWr5Tlbl?=
 =?us-ascii?Q?nKABoyobNMfrvBUM0gJx9v/bKKdH7F3ZV03gNiGCYGK0InB227yvfpODD4z2?=
 =?us-ascii?Q?rd7/3baV/F3JZs007FMMDBnic4ote1CgYl5+XJAhcpuc8P6zDjPsXDV4Hsyy?=
 =?us-ascii?Q?HyZeCJhrEdD6OviJzzIU1UQsNe1nnYz4pbZuErgzmZCySxB2fl7uzX5yuILb?=
 =?us-ascii?Q?wLw1jiPaP/WquVkbcZuzG1M9wH+CPrP92XoNfu9f4k7Z0/hF71F+xkSxZIcE?=
 =?us-ascii?Q?hdg8BSJ2yQY78WT8mXPu8B7nRc5/W84Q4zGBuhDIBIxk2hfMsBeCRfq1zXv4?=
 =?us-ascii?Q?cv/a8Vhb5a7567eWgOj3BFh1lhu1IhB54Cds4oIy/laNbmWJeEJ1da5Z3Y3i?=
 =?us-ascii?Q?0sCpw8B4GUeF06SoL/bJAB19s5wYcjO7NqTyPwAQ/M7Tq8/95YU6hbCki2Sl?=
 =?us-ascii?Q?1v/hjGjuFFLx8kQHtXVHQPMe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcf7c41-6401-4b84-8dea-08d8f4239d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 09:01:47.0055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wntkwsz9znWCO1gWVVH6xjBXgKFLRMKTs6h4M1/BWDbosyI7fo7bHZsqSiXT1uh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
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

[AMD Official Use Only - Internal Distribution Only]

Ping ......

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, March 30, 2021 5:43 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>
>From: "Emily.Deng" <Emily.Deng@amd.com>
>
>For vf assigned to guest VM, after FLR, the msix table will be reset.
>As the flr is done on host driver. The qemu and vfio driver don't know this,
>and the msix is still enable from qemu and vfio driver side.
>So if want to  re-setup the msix table, first need to disable and re-enable the
>msix from guest VM side or the qemu will do nothing as it thought the msix is
>already enabled.
>
>v2:
>Change name with amdgpu_irq prefix, remove #ifdef.
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>index 03412543427a..3045f52e613d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>*adev)
> return true;
> }
>
>+static void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>+u16 ctrl;
>+
>+pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, &ctrl);
>+ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, ctrl);
>+ctrl |= PCI_MSIX_FLAGS_ENABLE;
>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>+PCI_MSIX_FLAGS, ctrl); }
>+
> /**
>  * amdgpu_irq_init - initialize interrupt handling
>  *
>@@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>amdgpu_device *adev)  {
> int i, j, k;
>
>+if (amdgpu_sriov_vf(adev))
>+amdgpu_irq_restore_msix(adev);
>+
> for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> if (!adev->irq.client[i].sources)
> continue;
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
