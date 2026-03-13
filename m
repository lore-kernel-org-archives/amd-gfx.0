Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E391105F79D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 11:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0053D10E075;
	Fri, 13 Mar 2026 11:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VY2c7QI/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C867610E075
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 11:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArYRT7e81Ab1l5vdnR9/AJ/ta2WidZFu6jPr3OVRna838h76AKvytIxT3NooNPO+Px8u4nb2K0CznYQvZrG4uR6T0MBfnApAlG8+6V904KVaKgnHdcEVpBaMQ52TiZwWjYkR5o37cezv/5L8GNMfvsFK1rocTvGcC7NFfR8bE5FuIVaN+NOFKc3/mws0nfKnDbVuDvRmks7Lq+Rok59PalyhVttTh59o81TIaYtCn8nfSOOj9VzvAH5+2yyYlsovMTmFJd1D3XVwaWPS0pYbFjYonkUdL4Ck8uCApHeZTklR/TJkU3WqH98oXG5bt3q8DphAG58BS8xpzfFroTQr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egHueVqSqb9kH9EC2G3A+CeFTGvzRoHZjZscmxXCTPc=;
 b=HEUo0FBgtZ3/VUDJfrv+PEqCV26jJmQFq4Af4vy3MHnICUGX6/7YC9L9qmmlpXOYiCMfqljCJRamJoAjzNDsIWe1NReTrK32ENWlgHN7kZVdGoZHibIdQQuPhBqOEivjXnti17aJwr5j+zLRqA+wcHIx8wKyGHty358imXsImJuWvKb04EAqknKUc8hoXw3I+q3Cd7fQeUIV0eJkeiVKvtFls36hhItUZnXLyC8Cm9NboL6bpTMZ+rdAmiG5U3yCYZQIm+FhfcxLAjjUdO5qxnOMHj1gFqG24D8xDUqycxtzTeCwFDFUmAqfIin3ICmxxIhj5dzGQGSaH1W6p7vwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egHueVqSqb9kH9EC2G3A+CeFTGvzRoHZjZscmxXCTPc=;
 b=VY2c7QI/euOz7tu+91VSqdIJAAFw6LdknnxVE6rGnnwET2p/CR4KPyNksQwaVV3AirxenUNUobVJeruvHfoLNWGWlBGuEtS4WVKctHMwITw+PTryX1kRG11b1WoaqQiv1ft39lwDBdFKqbXujKJMohGJLuFDgRK1KDQEL4c+hiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 11:49:25 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::2bc0:451f:661a:ac32]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::2bc0:451f:661a:ac32%3]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 11:49:25 +0000
Message-ID: <8a9ffdb8-d76a-43e7-ad3a-3b0f45d04b1b@amd.com>
Date: Fri, 13 Mar 2026 19:49:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
To: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>,
 "Li, King" <King.Li@amd.com>
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
 <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
 <0fb83ff2-33ef-443d-a4a1-1608d52d34cc@amd.com>
 <46fa7959-ff84-4ea8-a17b-3825876b64eb@amd.com>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <46fa7959-ff84-4ea8-a17b-3825876b64eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To LV9PR12MB9829.namprd12.prod.outlook.com
 (2603:10b6:408:2eb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9786d647-886f-49c4-88bc-08de80f6935a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AXSeB9cJjlL8rlHvXxLLJe/mFQcwp+AGwlx+mTLQtIJr03hSaq2GfpzJbpXti3aDftVFLthDodCJh2MhgjXqVXfGzwILKMGJyNOBt1/5KegZrJBWiZ6+wiFlLFpLKHr7U5VgdZWywek8bKJAf4CXmhXyV+mGzQSQebROMqFyd5HbRjaPfZyMU8wftOJJDUeHXvfaySJWOUjJOw8TaiX7fjG7V76gBrxvJtNb/NR21hbt3WfQbXHzA/pAuQuV1SjxGQauM7PcTdlSeq5RDQ/Y8/Yj9ZHP3UQxTZdAfnNiBUX8xheL0nZypfTMlL6Tlxivj7TH+PJIdwl7eO7v1s/UMQedZ6042hsU2ok+BGMIkVCA/FablDnM5T8YB6Ou0F0z5NDdncV7CaUwKJCniLCaPK6xA3YPhVSICIB56wX7RKMEt3L0Db78VotZK6VflyZt4WYMOuDqvRyamuwvARrfPOwQuNxJD6A2vnubpBHo3uQpvanVze3Zk1KEux2UEVUv9OGcpZjOmBxlWq7LxeuAO2A5/X/bmmdXNmNiUOm/y7R5encDRX0Wwhiq7SfosfAn4cX0htMl6SAAS7qcevF7TL3eVW3xLiom38Fxb7FxATyUHB398Ix9HfhngMjCVHPIMj1VPSyDPvbzwagZ7YjuP/LLjMmMTIQG+BFAELDb9/VGNYRhBqc4bRYA3Cri+Lm5JRNrRp1N8klFXF5TLtA7J+L7kh1IoowHWEni83LxsTVvI260IvPOze1NDFUCJfZ82m+HUs8Ssttu34dUsB1t+hAKthIKSHzRF/GzT+AhgiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV9PR12MB9829.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJ6RkpYM1FpVytaTGcveDZkbU5UQXU5Q243VldXNVJKdllIekdvbHlkYU8x?=
 =?utf-8?B?MWZCQWpxMjNJbHk0aW45VG9FWlF1NiswK0VTZExCTmE0ZlBJWFhDMUhLUVR2?=
 =?utf-8?B?NW5tQ2YvYU9FZll4Q3BDUGVoZ3N5MzFyWDFKSDdkUXZXclh0bCtjVm05Q3By?=
 =?utf-8?B?MkFIeUxXd0VaSEZoN3lESWpTckhNZmpUUDFEejVVekQ5RkYxMFRxVTJMa0Ry?=
 =?utf-8?B?dXZJWHlQQjRmY2tGSG1ZOTZQbUtIV2VXTDhDRVhlTy96QXJiZk9yLzVEZjlI?=
 =?utf-8?B?dWdJdDI4TmthZCtpaVJvNkpxWHdCQkdNcGRBaDNDNmh1NmZJNDBsODU3QTcx?=
 =?utf-8?B?eVdhSHZnMnNpaExqTkpVNUxXZjkxbHdnT1FOdENhNXJyb2p4VUJoVjZoV052?=
 =?utf-8?B?alBIaERMUndKTDI5V2pxSXBvZHp2OUZIK25zRDAwaFlkU1lsSkZjUnZud1pB?=
 =?utf-8?B?QVJNa1ZaY04vR1Roc2daRU5aNm9wTnN3aDBVM0ZFRytvaE9WMTZRWUR1a1Jj?=
 =?utf-8?B?NXNmeFFuczFEYzFKQ0VCbGZubERSdnNkc0paRmtUWVJqZm9YR0hZS3pseVBO?=
 =?utf-8?B?Ti96eUFOR0FWSzU0RWVGYTRFM0hLV0FLb0dIcVpnZnBxcjNtWk5BdWtmQnA2?=
 =?utf-8?B?M1U0dkZzd2NVRlp0V2VGZDVZU2NZZ3AyUEVSYzVLUkNkUnpyQ3FKaTF4cnFk?=
 =?utf-8?B?UkR1UmhvYkI1c0toZW5LOS9DVGJNZmMyZVhpb2MremJEZ0g4eVBiMVNidUJr?=
 =?utf-8?B?OXpISHhYbzFGLy92SGMvUWsvQmlqNTlWcTlhUFdPNXFyYmd1cERIL25nbm1k?=
 =?utf-8?B?TldNWTZ4U1NnZ1Z4dEpGVE4yR00wS2U2Rm9nRzBMbk1xd25oamVYTHhLdzRk?=
 =?utf-8?B?Y0R4enQwbEJZQTA2QVcrSE1zV1gvNmNya0o5eHF0WkxvazlsbDBUeWRpWStP?=
 =?utf-8?B?VTUwczdEeTIrcXV6ZUJOcTZ5dllxbitxNXB2K0VCM21uUytxM2l5YlNadGVS?=
 =?utf-8?B?ZkhxaFFWcFNqWUFHRWtwQWcyOE1OaTMwT0lybzR5QTBQNWhPVnFLVFJzaG1y?=
 =?utf-8?B?TVF4bm93QjA2NXJDTkhKeTdKSE1mWGFRQWIxZUp0QUNTcmxVR2FXY1ZyMEE3?=
 =?utf-8?B?VUh5c1hIL3FidjkrTFJqMGI5YXhFdU9zVmtGdk04cEtGbU5uQ1dFT01Wajk5?=
 =?utf-8?B?aXZHL09TMnZqMEQrQkJEcDRmd3ZLMHVWTkhOVFdIU2FVRFFzKyszSU5VdXQ4?=
 =?utf-8?B?WFdxRFVkZThtaU5KMm9heWpUKzU5MVFVMEhhZk1uVmRIV0ZHSjE2dVMrcWs0?=
 =?utf-8?B?aWt4bmVCeC9Dc1dvcFZGVkRDWEhuRWxLVnRUemZ5T1JHTURPVVVsVEV1aHVO?=
 =?utf-8?B?cHZPMnR4SU1DK0orbzJLNkJ6aFFxaFZUb2Z3a0x0YXhOSEsrdmpqZnZPUVl5?=
 =?utf-8?B?UkFhWmc1UTJ6WTVRMkVhanJwWW95N3RSRjZTbzM5eDA5ZmIvNEhtQWp2YU1i?=
 =?utf-8?B?WFBPdGoyYXRIbkRNbUtyYVJaNEwyUms1N2VVMVBiMW9pS3RqbC93RGIrdHFW?=
 =?utf-8?B?U21mMTlxUk94NjNwajFMNHpjNDMxNUZiK0FPMG5UcHMyRXJiY09KaDgweGdj?=
 =?utf-8?B?TWIyREV0N3QvdmRIalUyTmw2V3VSL21lc2hLSDVQVFAxR25jdU9aZE5zZk9l?=
 =?utf-8?B?Yldxa0NnQStWKzgwR2V2bzhndFZXZ3BiWlVxbkNXWXFpbVRzVEdtNHczclVG?=
 =?utf-8?B?MkdobnFoN3ZyVXdqeU9OTmhiNjFxcmxhMm9GY2VWdEhOT09TUUo3bEowQ3BU?=
 =?utf-8?B?b29odi9qelRHZDlkVWpPR092WWVBaTVpM0U3ejloUjZZcElhY0I1aXpCSDVy?=
 =?utf-8?B?eUhRN3FXc1VVUVlyMnpxcmwvR2R6bUpGK0F3SExDNGNQQzBFK3VPc2tQU2lJ?=
 =?utf-8?B?MHA3dWZ5QmJud2VnVjN6bUVhZUJPVEtmNXNVa1RPMWg1emdiMHA5UDlCSGdt?=
 =?utf-8?B?SjNYeGorTGR2RDAxdkYrUGM2RVdnNXNKa3FUU1M5eFJvZGl1c2RJdE5YbXJK?=
 =?utf-8?B?UkFhSzZxT0JMQnBMQUlSYzJmcmFsL1RmWXdpR1M0d3YwRHEzcTBYM2VFNXJ3?=
 =?utf-8?B?NlpXeUhwZ1NXaUJUNlJ2dWptSmdtYTNJcFgzQ1pUYW1OSEt5dkMxbTFhbW0r?=
 =?utf-8?B?WGNkeUYvT0M0eUVHN3FZKzl5aXFQRVdqQTFIeWJaZ3NiMm5vcExLMzRNaGRF?=
 =?utf-8?B?dDhOa3NiQ1FsRDA3MThBNFZGaE1EdkY1NXZheUNna1RhN1BsOWJEV3pJSVA5?=
 =?utf-8?Q?gkqGsu6T4xhiTI1CtH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9786d647-886f-49c4-88bc-08de80f6935a
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:49:25.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfm9vhmSqKM8+SPoMel1BYLtVqSb0Pf5xVMcu/eEfI/uRBzE/V8zgBFeRTPnSBSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

Hi Pratap,

FYI, the following patch may resolve the AMD ISP driver not auto-loading 
issue (without using MODULE_SOFTDEP). Please double check.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 920595f0d22c..95d26f086d54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3212,4 +3212,3 @@ module_exit(amdgpu_exit);
  MODULE_AUTHOR(DRIVER_AUTHOR);
  MODULE_DESCRIPTION(DRIVER_DESC);
  MODULE_LICENSE("GPL and additional rights");
-MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp 
pinctrl-amdisp");
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c 
b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 485ecdec9618..409c1ca5a5e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -118,6 +118,29 @@ static int isp_set_performance_state(struct 
generic_pm_domain *genpd,
         return 0;
  }

+/*
+ * MFD core sets the parent GPU's ACPI companion (LNXVIDEO) on each
+ * child, giving them modalias "acpi:LNXVIDEO:" instead of
+ * "platform:<name>".  Clear it and retrigger the uevent so udev
+ * sees the correct platform modalias for module autoloading.
+ */
+static int isp_clear_acpi_fwnode(struct device *dev, void *data)
+{
+       struct platform_device *pdev;
+
+       if (!dev->type || !dev->type->name ||
+           strcmp(dev->type->name, "mfd_device"))
+               return 0;
+
+       pdev = to_platform_device(dev);
+       if (pdev->mfd_cell) {
+               device_set_node(dev, NULL);
+               kobject_uevent(&dev->kobj, KOBJ_ADD);
+       }
+
+       return 0;
+}
+
  static int isp_genpd_add_device(struct device *dev, void *data)
  {
         struct generic_pm_domain *gpd = data;
@@ -375,6 +398,13 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
                 goto failure;
         }

+       /*
+        * MFD core sets the parent GPU's ACPI companion (LNXVIDEO) on
+        * each child, giving them modalias "acpi:LNXVIDEO:" instead of
+        * "platform:<name>". Clear it so udev matches by platform alias.
+        */
+       device_for_each_child(isp->parent, NULL, isp_clear_acpi_fwnode);
+
         return 0;

  failure:

>-----Original Message-----
>From: Nirujogi, Pratap <Pratap.Nirujogi@amd.com>
>Sent: Wednesday, March 11, 2026 11:29 PM
>To: Limonciello, Mario <Mario.Limonciello@amd.com>; Nirujogi, Pratap
><Pratap.Nirujogi@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,
>Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
><Mario.Limonciello@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>
>Cc: rafael.j.wysocki@intel.com; Chan, Benjamin (Koon Pan)
><Benjamin.Chan@amd.com>; Du, Bin <Bin.Du@amd.com>; Li, King
><King.Li@amd.com>
>Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
>
>
>
>On 3/11/2026 1:26 AM, Mario Limonciello wrote:
>>
>>
>> On 3/10/2026 5:52 PM, Nirujogi, Pratap wrote:
>>>
>>>
>>> On 3/9/2026 5:58 PM, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>>>>> Add NULL pointer checks for dev->type before accessing
>>>>> dev->type->name in ISP genpd add/remove functions to
>>>>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure ISP
>>>>> driver dependencies are loaded in correct order.
>>>>>
>>>>> The regression was introduced in kernel v7.0 where MFD ISP device
>>>>> enumeration doesn't complete by the time it is added to gendp. The
>>>>> timing of ISP device enumeration has changed because of the changes
>>>>> in registering the device sources in the device hierarchy.
>>>>
>>>> It's a little bit pedantic; but I /think/ there are two different
>>>> problems here with two different root causes that both happened in
>>>> 7.0-rc.
>>>>
>>>> As a consequence I think you should have this split out as two
>>>> separate patches in a series linked to a Fixes tag with the reason
>>>> for each of them.
>>>>
>>> Hi Mario,
>>>
>>> Few things to clarify before I split into 2 patches and submit v2.
>>>
>>> - Yes, you are correct, the changes in this patch are not directly
>>> related to the Fixes tag 02c057ddefef mentioned. But since it has the
>>> dependency on the below patch for automatic modprobe of isp to work,
>>> I have used the same tag to cover the dependency. My apologies if
>>> this approach is incorrect and misleading.
>>>
>>> https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/
>>>
>>> - NULL dereferencing issue with dev->type observed on v7.0 is
>>> specific to this commit 057edc58aa5926d63840c7f30afe0953d3994fa3. As
>>> the wakeup sources are registered using physical device instead of
>>> ACPI device, wakeup source device (wakeup14) is added as the first
>>> child of AMDGPU device; and since its dev->type is not initialized
>>> properly it has resulted in segfault.
>>
>> Sure this makes sense and is a no brainer to get in.  I would just
>> send this one right now and we can keep noodling on MODULE_SOFTDEP
>> (more comments below).
>>
>thanks, I’ll go ahead and send this one out now and will submit the
>MODULE_SOFTDEP change separately after the root cause is identified ( more
>details below ).
>
>>>
>>> In 6.19-rc4 or earlier versions, this issue was not observed as the
>>> wakeup source device was never part of AMDGPU children list.
>>>
>>> For the changes in isp_v4_1_1.c, I will use Fixes tag 057edc58aa59 in v2.
>>>
>>> - MODULE_SOFTDEP change in amdgpu_drv.c is needed for automatic
>>> modprobe of isp (and other amdgpu mfd child devices) to work in v7.0.
>>> But couldn't identify the specific commit in v7.0 that is causing the
>>> issue. I can confirm it is not because of commit 057edc58aa59 as the
>>> automatic modprobe doesn't work even on reverting this commit. Can I
>>> submit this as the fix needed for isp probe to work in v7.0 without
>>> the fixes tag?
>>>
>>
>> MODULE_SOFTDEP is generally for ordering, but I don't think you have
>> an issue with those modules loading before amdgpu do you?  I'm not
>> really following why the modaliases stopped working and I'm a bit
>> worried that it's papering over a more nuanced issue still.
>>
>yes, this explicit load‑order dependency was not required earlier. I agree that
>the regression point is not clearly identified. I will identify the bisected commit
>and submit the patch later.
>
>> To identify the root cause, it might be helpful to do a bisect,
>> although it's a bit complicated.
>> 1) At any point that has that platform driver conversion you need to
>> either revert or add the change to auxillary
>> 2) At any point that has 057edc58aa5926d63840c7f30afe0953d3994fa3 you
>> need to apply the NULL pointer derf fix
>> 3) At any point that has the changes in linux-media for API
>> adjustments in 7.0 you'll need to pick what version of ISP series to apply.
>>
>I tried #1, #2 and few other combinations, but none of them helped. I will
>investigate further to identify the commit causing the issue.
>>
>>> Thanks,
>>> Pratap
>>>
>>>>>
>>>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform
>>>>> one")
>>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_drv.c index 95d26f086d545..920595f0d22ca
>>>>> 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>>>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>   MODULE_LICENSE("GPL and additional rights");
>>>>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp
>>>>> pinctrl- amdisp");
>>>>> \ No newline at end of file
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/isp_v4_1_1.c index b3590b33cab9e..485ecdec96184
>>>>> 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device
>>>>> *dev, void *data)
>>>>>       if (!pdev)
>>>>>           return -EINVAL;
>>>>> -    if (!dev->type->name) {
>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>>>>           goto exit;
>>>>>       }
>>>>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct
>>>>> device *dev, void *data)
>>>>>       if (!pdev)
>>>>>           return -EINVAL;
>>>>> -    if (!dev->type->name) {
>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>>>>           goto exit;
>>>>>       }
>>>>
>>>>
>>>
>>

Regards,
Bin
