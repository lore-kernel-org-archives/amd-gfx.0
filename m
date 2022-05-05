Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8BFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 07:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25B510E932;
	Thu,  5 May 2022 07:40:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F2910E932
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 07:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRqj3IJY7psMKLX/eYgkfU+FJvrbdEYdMibLBwQJF2otpBMbrZHDfFy/x+ZmsP5fDo5MaSKIWvd7vuA61AJwjgpk3CJaIakFEW7+3DEXOzpDNBFq9hj5BAksAiTaedBFedTwvKMgoG/2S+qyZmSaFzwhaRJwOfR4bDbpO9vk7e0urtE6r/cg5PevpSzdegwQL4AAJ1ayVZ8C0+maFfUXqZSyAzn4m1nLbNJ9bRFtCFirKycmBPWd2EgGZaxnLe52R9hAZ+aa7RC5+J35IwJUNHZStDDeMWSkdF96cyPJgEdoYzDaADJFkWqN+5NSbL136YiQ6wJuklf9WwxOsV7u2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAu4a2zqu8BNl+dgTck0PkJjimEAmS1OlJZIPvKU3Dw=;
 b=ofww9L0zP95hY8wpt5PSSbhoGO6AOwJc2b78dOf2CtVULRNQUzNlwgxtWa8UXssFbVNzSSGtS4ed6UgooC5GrH2aea5tE+tgmW/EYw7A8dwgvCt0mYL9PH5xCZAw+JvF8B/AHBwW0Hmf1KZjuDIrUkSgQBLbxC1h3L5bx1BIw+WjARnR2X7ql4dmQ0NvA4xz7VypW3ouRMpuehPKYNcDYt4ghn1/ImbIjutCciFUd7mcRcRgCWFsuJOUsfniIEkRWmsRi9vbWARqEDjL58kKCTJ9yblgYw6YOoXW2Gb044xIjVKmspoJEEC5G4KdwjPJPQ5RKp0Fg6aw/eK7lKlkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAu4a2zqu8BNl+dgTck0PkJjimEAmS1OlJZIPvKU3Dw=;
 b=IwHP7Gi0QAYgb5e6EBJp5C1Zb35vfbQ1POgKF+P0aJaxpnYy4WKx0h6WmZHNdZzDbM2sXpeqDNQGIyQDVsJn4Gy0z3OiCQrxVEGoafq0PoeXhCNu6kuQfj1PdYKR7+uIdjX138q/iLA8rDErlkbapmyD60qOBQnD5JQlNL7KHVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.27; Thu, 5 May 2022 07:40:07 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::a48e:5de9:857a:5888]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::a48e:5de9:857a:5888%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 07:40:07 +0000
Message-ID: <ad22db04-a304-adbc-dc19-d513e56cf9a8@amd.com>
Date: Thu, 5 May 2022 15:39:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] drm/amdgpu: flush delete wq after wait fence
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Yiqing Yao <yiqing.yao@amd.com>
References: <20220505063527.957333-1-yiqing.yao@amd.com>
 <578caa75-5510-22d9-ef9f-0173a025b84a@molgen.mpg.de>
From: "Yao, Yiqing(James)" <yiqinyao@amd.com>
In-Reply-To: <578caa75-5510-22d9-ef9f-0173a025b84a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To MN2PR12MB2975.namprd12.prod.outlook.com
 (2603:10b6:208:ce::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4379a37b-9f84-4ea5-556e-08da2e6a79d1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1515E550798F97B3FAB7F57385C29@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmoVCCiAnF6MfcT5RPRvAouQO3gQOrJtK7sHgR3kGIDdNoxqhie5DDRCJzyqykbRy8skpdBzQAArZ3vzjztmQaOAodwcvE6Or4ApHix9WvlO2QyuVC1GuMnDqOdLMtsHVFA0ToDqgsNoihO4tkgrC6X3F/4DUuXoyEyo5BkpSnekrlAc+WIDQRhXVO6om2Vf4LowVGBXzFbmDpZQz90gg3FN1BDxJNjegM1deQk3V8EmvutpcSMV6sevLDEtB05CaP+r3Rs1m7IwMYPfJBKsVpBFKEK6ID9zzuaVoen5KK0GR43NMealKOKtmxdvrkV8di7aV0Ax039jdE0xtnORs1MghHIB/u8HCpY1q8DZeDWGm0OyY0jC+15TKQlV64pfunqQ6BEnOY30+3f9CZrawRQEzGPfFp+orKCyhCKFRkxUr+OmeNIqSFoLBU91hGTOk3hIVIu4HPNgUZSFhSAUo+xuybqc2HyjRtSJ5zNPdAYVIzqvyzW/yGSXM804KUVimsFgkeiXsGqtkv1oq4Un7d7ZJjrIqlekgBH9vA2mHX2D3FFrOQj9U3Ngh+KdvdklLFBCJ9ypCEwFQmdbbhcgZ/UyK/+lacbW9MokZu3+q/SjCkaDwkyv3OHbaFgT27bMxI0z3ZYZ5a3wXh43xEYcfwEUPPu8ZYhQBombD0oohaITSMNLj0jRyMs84FEWCVwg2ygJ2vmdXDxzzxX3TRsxH3ygPmCGfPzq6QuFkGYBNYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2975.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6506007)(6512007)(6666004)(508600001)(6636002)(26005)(316002)(186003)(6486002)(31686004)(83380400001)(36756003)(66946007)(66476007)(31696002)(66556008)(4326008)(8936002)(38100700002)(2906002)(5660300002)(53546011)(110136005)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU0xVjV3OERpZXFsNDlva3BMMnpQd0YyeUowNGZpSU13M0daZjlFZzBOUTdn?=
 =?utf-8?B?MFZyVWk0SnNOWFA2enhUQzhzTFN3R0FnZ0V3UXRlRHZReEtNK0xqTThnOEQ1?=
 =?utf-8?B?ZDMwUXlBd3pncWNFQjJ2eG1yREJmTnZsdS9nUWVEcnBkbGoxeFJ0Q2wweEN2?=
 =?utf-8?B?aGpUa20zMWc5bUxIbU8rbTcvTnBGcUFLd1MwRUoxZDd0Zkg4MXk5UEh4ME9O?=
 =?utf-8?B?UFdwdS9veHVORk54VFVSOWNobjErS20ramp6alI2N2tUcEZXaVowV2IxUmZU?=
 =?utf-8?B?ckdXVHp2VG82MVdXRThqSlcxUFRoQ1hmTHNqMytFZFJHbmFQYUVtT0R2YjU2?=
 =?utf-8?B?Smh2cEE4RlpoWGIxU09oUDhnbTB0dVlISHVhMzJWOXhMbnpQSUoxNTNhL29H?=
 =?utf-8?B?eGtYTVNUTkpCZm83NGkyYWlHQWtEVVhWNWxjamVEdHltU0h3d2YzdDNTMUxw?=
 =?utf-8?B?WGpNRzVPdGQrOGVtdkxPQ2hmUjYranEzc0l1UTJmRHRMYnlvRkFueHBxMGMz?=
 =?utf-8?B?cit5ZlBVTTRRZXBtcXBuSHJBN1Zhb2tqR0w1eURKNGxwaFVrZzVDMEtLNjZ2?=
 =?utf-8?B?cjJOUE5TT0lwL2tHUlhrTHVJNHVaZDAwSlk5Y1cwOFR4OFRTMUF6RUZiSjdD?=
 =?utf-8?B?QTVNa0pGY0tCTWZlTkxtTVF3c21QbU4vOURHeWlnUGVNZWI1TlZRcjAxZFJO?=
 =?utf-8?B?ZUg5NEFKdG1icko0YXhTR2hQdmRleVNqYnJQVGJzM04rVEtKTHNQOGZPRGJa?=
 =?utf-8?B?UFAzUmRnc09hQm5IMStKd2xtNzIwb01OYXZSc1pQQ3V4MlU1SGhYMG5wTVcx?=
 =?utf-8?B?elZycXEyUVlnbGJYV0lsVWpHc0hZY0NteGg3SG0yT3J6YlByOW0xNlh0WUFk?=
 =?utf-8?B?THlzblhudUFFbjJObG1ZTzh2ZW9OT1A3dW1VR0ZHRkV3eGpLdlVvMVVPVVlE?=
 =?utf-8?B?bVpPdHlBc0hJWXkzVGtLdFhudWJDOXdGcW83c1V3cjlKT0Jic001aUdzUERi?=
 =?utf-8?B?VXVzUmJaVW9TVHBKWk04S0xpRDhoQ3VCWmViVnJTU2sxbktCTWlpK3E2OVNG?=
 =?utf-8?B?Tml5VmdIUXZvWDlkaXloR3lQa2U2ZDJzWTRKbTBWYmRrZ2tmN1EvV0Z5ckhK?=
 =?utf-8?B?Z0xKSVlSeG85ZDNncGFub3pkV0pyb0hzckpBNmNPYUJXY1B5bHRMUHYxMTBj?=
 =?utf-8?B?cWlJRi9qNVpCNXVXSW9EcDR1VDZDU1FocVFqTXdvWHo0NjBxTGMyaThuTk10?=
 =?utf-8?B?dFZDL0dsdWRFN3BjSXdVV1Q2NVVwMXlKUlgvREx3MWRDSDd3OGxLeU4remZ1?=
 =?utf-8?B?R0tIWUVUNnJLOWxvS3VTWVBDM0prdEJndHFBVGxLVFdpdlZTK0VBdTg5bE54?=
 =?utf-8?B?cWYvQmt0TGZuVEd2UVhRVXNQRTE2emIwVWNSalRrblNxVnlUSkdHQTVXV1h3?=
 =?utf-8?B?UXRoUEpXZi8vb2lhUDBLeUVqK05kVXhNN0xVYWlyWWc4Nmp1d3VkRXBGL1Z3?=
 =?utf-8?B?a1laVXVIRVBVeFdrYUFxNkxocFI3czBzVi9EcWRlMzhlcmRPS2VET0RXTjR5?=
 =?utf-8?B?ZS9MVWtUOC8wLzRGQ2oxMXJESVphSzhteDNERGwvTTlIQjloUEVaRTFhT0Ns?=
 =?utf-8?B?eWJoMVpSc0l1SVJxVDdxVWlsQXJHWmVVWWZaY1lOVldNNjcvT3Vaa3YwZk1S?=
 =?utf-8?B?cUUydm9CK09CNTJpMHlIN24waW1HUS9yem5oWWg4TW5XTXdIUTlGS0l0U0dC?=
 =?utf-8?B?K3NiU2F1czd3TUdGNFdJZENYWU1ZT1NZelNVQTM3blBNVU1YcHc4Mk1ic052?=
 =?utf-8?B?OHluZ3Z2OUlyS0FSVVF1bUUwTVNjVG9YRUpuUFRWcjJoRzRRUEl4OXRGcG5W?=
 =?utf-8?B?dFRoUnJKbStUSzRGbUZSaUNxZGVVM09GWmFuaGY1UmovWEZWZHBTeTVTbjdU?=
 =?utf-8?B?akgyWkZUNzR1ZHcwdCtKWWZOK2hvQm1ZS0RYQzF4UEJ0eXRYYzBvV3JNRzR4?=
 =?utf-8?B?bmQyTi9ZL29OcklvdFgxWm9vUGl6WlU4c3NrYlJzS3M5S2RUNTU0K2lMTTlK?=
 =?utf-8?B?UnMzQkZVN1d6aVBwbjVWang4VDg4djVVTnBRVzdqVmhKeC9OWjFHZHhHMnpV?=
 =?utf-8?B?OUNnelFLR2NEUk9iSnZPYUFqR1JNaEtTNUljRlpYKzdweE9XSUR5ako2MG85?=
 =?utf-8?B?ck94bFF1NXdZdFJ4d25Ib1BvSHZ0QXpkNXA5RGtJYjI1RVJwR3A4WXB2SWh5?=
 =?utf-8?B?T3BYWU03WDVHcUVNL3FIelQ1KzJRNXNKdDlOR3BEclBlMFhWeUxhN1ArVnpx?=
 =?utf-8?B?MVBvQzc0cUxjWGg0bzk2K0tHK05aOTB1V05iK1dKRDJRYzNpWWJoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4379a37b-9f84-4ea5-556e-08da2e6a79d1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2975.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 07:40:07.4956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXaKkBn0fi/pUwW3D5HC3/6k5Gi4pgIa2gkIpBgTFGjSo4QLEivNJT4AL8E+llrZcaNeJitEQ26aJEq+J2/yYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
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
Cc: jingwen.chen2@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Paul,

Patch edited:

[why]
lru_list not empty warning in sw fini during repeated device bind unbind.
There should be a amdgpu_fence_wait_empty() before the flush_delayed_work()
call as Christian suggested.

[how]
Move to do flush_delayed_work for ttm bo delayed delete wq after 
fence_driver_hw_fini.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
  1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 14c5ccf81e80..92e5ed3ed345 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4003,10 +4003,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device 
*adev)
  {
      dev_info(adev->dev, "amdgpu: finishing device.\n");
      flush_delayed_work(&adev->delayed_init_work);
-    if (adev->mman.initialized) {
-        flush_delayed_work(&adev->mman.bdev.wq);
-        ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
-    }
      adev->shutdown = true;

      /* make sure IB test finished before entering exclusive mode
@@ -4029,6 +4025,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device 
*adev)
      }
      amdgpu_fence_driver_hw_fini(adev);

+    if (adev->mman.initialized) {
+        flush_delayed_work(&adev->mman.bdev.wq);
+        ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+    }
+
      if (adev->pm_sysfs_en)
          amdgpu_pm_sysfs_fini(adev);
      if (adev->ucode_sysfs_en)
-- 
2.25.1


On 5/5/2022 3:15 PM, Paul Menzel wrote:
>> [how]
>> Do flush_delayed_work for ttm bo delayed delete wq after 
>> fence_driver_hw_fini.
>>
>> Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 14c5ccf81e80..92e5ed3ed345 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4003,10 +4003,6 @@ void amdgpu_device_fini_hw(struct 
>> amdgpu_device *adev)
>>   {
>>       dev_info(adev->dev, "amdgpu: finishing device.\n");
>>       flush_delayed_work(&adev->delayed_init_work);
>> -    if (adev->mman.initialized) {
>> -        flush_delayed_work(&adev->mman.bdev.wq);
>> -        ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
>> -    }
>
> From the commit message, it’s not clear, that you remove this here.
>
This part is moved to be done later.


Thank you for advice,

Yiqing

