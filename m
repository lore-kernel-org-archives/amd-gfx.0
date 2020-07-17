Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F823C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37BC22D08
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nn0ff4CS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37BC22D08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8928C6EDD3;
	Fri, 17 Jul 2020 14:08:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975786EDD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 14:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9f3M6qbevSImj9QU3tgD/Ao/DWpE3FJC9xNVtj4GZq4dmu3qUU2UBUrD8qZU+H/Cl4xg3xBpqsdZ6CuON2ZayTB+Nnclx6CYCnzrUMpiGXF6kaWFE1lmooqO2Yx9/LWmDkCRaHVtL+mXPhxsTD3wnrDi1gRSipJrAbgVtxX98wA80SUWv3FSuWLjzs2sFcqOiR/cBemm0+i2V8XoC29/8B8JUIyZYptsQCYCgxGCAsKfDV+scmRNXnzivFv7W+SDLAyRofMoIM/+xSkPXIyV5YWhY+m8Hvx8Ss8bZomjY1AE++ODg0LpqINspa/VyWJxbK4n54gc6aMAwVKaZq7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twtIJQi0dprICkpvOwPyOKCTGMGbjPrLUyBi4PEWuHM=;
 b=bGAZKE0gSJFjEORN1l5sILTlHC9d4D9O60PqZZ97AD2MdxvY3yE8Ma6Ykb5uLD8qENZSijjcL8SwvRQ799V9HRoE6i5tY1NhgaMyFv4m8gMWkU2KWVFHuL0a2uJQnoubbbfd7JeOvGGEw8cCJCI+asGdo9OQlIiwuLYl+tXHuZTj6OgEcNaAvYU79MofwmNymbgNYYYZlbIOiFdj5lenTZ5bu7HTMFZjNPxA4Z+CZgXBEzS4u64EJxs+ndl/EBE1wtIUEbBNY7It8LsDAaa/r/rvrRDUYxeWzqBM3h0CsR1SExqhb0oEl10cBiMt71pu3uV0ds8x3rGxk6GimaIk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twtIJQi0dprICkpvOwPyOKCTGMGbjPrLUyBi4PEWuHM=;
 b=nn0ff4CS9N2GMFVD0olCpe3tJtD+tUMx++p7/puU+wVYkOT2G75XhRSDbzLBE+G0Y/Pxb+MTkfZwQ1Qo5vaOsBSIlTH94+gYo9zjzebfuV4xwUYAOFJwBa4MBKyQx2oOHkXoAS9oVwOiUvuXr1DtE5umuNWH1ylLcHcSiveUQJs=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1497.namprd12.prod.outlook.com (2603:10b6:4:d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Fri, 17 Jul 2020 14:08:25 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6%4]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:08:24 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] Revert "drm/amdgpu/vcn: add shared memory restore
 after wake up from sleep."
Thread-Topic: [PATCH 1/2] Revert "drm/amdgpu/vcn: add shared memory restore
 after wake up from sleep."
Thread-Index: AQHWW3MhPfbG4LGZxkG7d79pjvL18KkL0GCw
Date: Fri, 17 Jul 2020 14:08:24 +0000
Message-ID: <DM5PR12MB17878145CF582B11D52C614EE57C0@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <1594905287-2895-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1594905287-2895-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:a3c0:203:21fd:b97:ba1d:c941]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ce4bac8-ba7d-4982-f281-08d82a5adefc
x-ms-traffictypediagnostic: DM5PR12MB1497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB14978BD893A740E7A340E3F0E57C0@DM5PR12MB1497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:33;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNJ9yjlSfoLzbhvP+qyntxZdIxNyO+m4SQTLGmm+8mbJXgJ/Pv68Uzo4ZSMAgwpsr+EE75e6uIJx6Xd/fBiJG7rdGRInXJCcTNP7pL4A00s37dWOdOddVLZ9gYSgSuWDG4xBWQbBApZWUBex+bvEfV6qDne45wWlBXmIFiS/7qSWOeGa6kcotoPmsHPH1L7D54w+ZpvH7bssTR9fogcdbyO66G+UQKqyQ4rtMSy048mJZT6IJBVrKpZH1nmBFDOFRoGd/ED6UOsp+P5I54Irdy1kSXsoFvgRtM8z7d9k5Diz8e+CWqbZncil4h5NQnjH8qSxGXANe7/tZT2llcQAq2SkQekdpoLYiHb2+Bx8hfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(53546011)(6506007)(4326008)(7696005)(66946007)(478600001)(52536014)(316002)(66556008)(66476007)(45080400002)(966005)(9686003)(66446008)(64756008)(76116006)(2906002)(186003)(55016002)(33656002)(71200400001)(5660300002)(110136005)(8936002)(86362001)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fiQOageGnizMAclJ2ZCJ8yNqjLYUPoH5L6sdP6Yd3z2kLgTs5Xv203I3OM1boyMYrhJGVJXwOw1YfwbaMNZ18iH9jh1DIOtbZKcMqWsP0mK9sfT3jWcLx0gDbUqPQEWMxHHvzpIztfBbuI5EddPHWuKhCZmb15cNBNx+aADsxE9/fa733uJ5TMcu8dptv77+D4Az39nQvxXly6Zma9dQVu2+/NwDQuROmrbMZAkmaWelXkgI8bCVKmiEHk94/SDAEM38DKwIE/lD/zKJpSR+Fqp7+pJQmEr+pErHSYuWhESZ8Lc0vetVv+qom2zHxWQBc6Pa61I6R7yo73vtQ4WBjmwR30rNMETCgEoZ6pMO0BNVKEsTQ/ATuDX3BXN8uHhNpdjOOax0L1O7JSx8kHe0twFDgyBhCt+DxmYWpfGCjYUD13x8qU7DgKmBFAl1Ycj8Xx0xalqX9IAIWgvyk2bmt72twzamsn0JtuRw8ehUU6MNv92Mj3L/+pt/botYenvT/jRXUuyYLO8zjsg0FM12dWuznKneMr7dolDDdhCUccg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce4bac8-ba7d-4982-f281-08d82a5adefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 14:08:24.7968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQeEn26OD6C57VnSigXw+j+4BzhauOcGiILoRvzjV0gXxDTY4ckSLGZBkXmdz7nY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1497
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series are:
Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: July 16, 2020 9:15 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu/vcn: add shared memory restore after wake up from sleep."

This reverts commit 41fd4db3eca29d10222f164cc1d56f60e3da97b8.
To merge vcn firmware shared memory bo into vcn vcpu bo.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 +---------------------------  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 -
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 15ff30c..cbc2b30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -58,7 +58,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev)  {
-	unsigned long bo_size, fw_shared_bo_size;
+	unsigned long bo_size;
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
@@ -198,9 +198,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			dev_err(adev->dev, "VCN %d (%d) failed to allocate firmware shared bo\n", i, r);
 			return r;
 		}
-
-		fw_shared_bo_size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
-		adev->vcn.inst[i].saved_shm_bo = kvmalloc(fw_shared_bo_size, GFP_KERNEL);
 	}
 
 	return 0;
@@ -216,7 +213,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 
-		kvfree(adev->vcn.inst[j].saved_shm_bo);
 		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
 					  &adev->vcn.inst[j].fw_shared_gpu_addr,
 					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
@@ -266,17 +262,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 			return -ENOMEM;
 
 		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
-
-		if (adev->vcn.inst[i].fw_shared_bo == NULL)
-			return 0;
-
-		if (!adev->vcn.inst[i].saved_shm_bo)
-			return -ENOMEM;
-
-		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
-		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
-
-		memcpy_fromio(adev->vcn.inst[i].saved_shm_bo, ptr, size);
 	}
 	return 0;
 }
@@ -314,17 +299,6 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 		}
-
-		if (adev->vcn.inst[i].fw_shared_bo == NULL)
-			return -EINVAL;
-
-		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
-		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
-
-		if (adev->vcn.inst[i].saved_shm_bo != NULL)
-			memcpy_toio(ptr, adev->vcn.inst[i].saved_shm_bo, size);
-		else
-			memset_io(ptr, 0, size);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index e125e8b..b5e9088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -207,7 +207,6 @@ struct amdgpu_vcn_inst {
 	atomic_t		dpg_enc_submission_cnt;
 	void			*fw_shared_cpu_addr;
 	uint64_t		fw_shared_gpu_addr;
-	void			*saved_shm_bo;
 };
 
 struct amdgpu_vcn {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Cab677877f20e4c85705e08d8298a3e6a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637305021084985149&amp;sdata=zAkfUcoQW27ao2wZf3sQOxgOjU7p9%2BAoaCGTdM0nsCk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
