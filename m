Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9E0C5475B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 02:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5505410E3BC;
	Thu, 29 Feb 2024 02:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cjlB2ZJX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F84E10E327
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 02:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyi6hta1g/paz0F6uZnM6nYvoirnDYWZyN9drRLCf/8mZ/oAF847LLBnoNubphQnBcRio79mgsTC47JmfKlD3PnmRcghe5m4UUOUDIpcxdXjcgaBHj6xBm3t2jI8nMCnOBsFBdVj3aZSyJx8K1p+jIw9DaExFG2fqd+/qWnhQgcKz6CGG8KSnPhUaPNFNssn+DIjRmwriKnBqDp1OeXh5un4mqKJnZ8N3BvdLh8Mu++8y0R+CRFFQ1mwmsfbFLBRY/wkXuSSzsnq05pUnQdcECy0Q59jgYHjfesUnIKsUDHNMEedD31Tt0FXgkzky9zpQpR3CkjuJ9elIfpMLrMYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgOX/McoIxZqWcXYLvpYRYJQijmWJsx3wLiur6wUrhY=;
 b=A7ojeu7UtvYtqbjDvCcdcvIQaLEMfar0lo29UA1EoRJp5ToB6+aC85UQA07QUdaJuRWbUr5YEqP5t1RS2CzB8sTPnR6iUweK/5tAdLeHo4XpvyASyQJbRYGhxAm5idF7BMpgif0g8tbIiCnSdwQL1dUrfcznHj8IKaH82SlH7/MVlb3ZHwaBh2NegrUpsn2haP0NOxdD98k+cGgBKrC71QlMaMnEZf1HUNX2ZI8BUvH+GZGgNDgt+7313p5SuAApxoo07cFemn8TWsmOINt23Rrwzp8rz6sLWckphPdi46a1Tor94d2ZjWEoiIzW8hbbNc77y8Jg/WVz8ErnvxjpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgOX/McoIxZqWcXYLvpYRYJQijmWJsx3wLiur6wUrhY=;
 b=cjlB2ZJXiB4MqQRji01FwAZTpNARP4C3bLRa7X4q9GyIDj3rJm2zDyHQU4+saUNVNUzjD+cRhnKUaUcuvxHs8QT2pTmQQOlKhMJnTSafGGhzEjDkK3O91Q9NKNd0ZsSnRRJYS12di788mUKnTuwgv2ZXPfl2BFaepGksoRrNkbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 02:54:04 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::1b3:8ca1:e95b:22e5]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::1b3:8ca1:e95b:22e5%6]) with mapi id 15.20.7292.022; Thu, 29 Feb 2024
 02:54:03 +0000
Message-ID: <65ced545-9a9b-47f7-915b-377f44c7a114@amd.com>
Date: Thu, 29 Feb 2024 10:53:58 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com
Subject: Re: [PATCH 2/2] drm/amgpu: Check return value of
 amdgpu_device_baco_enter/exit
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20240228114440.1939084-1-Jun.Ma2@amd.com>
 <20240228114440.1939084-2-Jun.Ma2@amd.com>
 <a2e47637-f596-4580-8b86-db95af56e05c@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <a2e47637-f596-4580-8b86-db95af56e05c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: ad22f5a5-e46a-4cd9-0219-08dc38d1b047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjZ+ny9J5ILOcTKKHopEEenMo0hjnfxgiVKVHrbALPXXBy0ieG7xbN2jATW74iiEYF2toj09BVBcxUs7oLMeYufF+Yi1pjCqVHczy6lpkVJWw1B/bkx/OVepazDz9/AXDGHdHnDona1pXDsjqVQMrS/dzeI+ecmILzTMdTUXWrsf++0SXujfx9myx79yjhSJVrRj/E/V8u5u/F5hIai3FgvmCgYgzqHAJftuLsTccMOnGdZODFaMxFmmshq8oo/9zm1wIjnP5YfCafuD8IU+Aa7wJ43ShrkIk/cljNQhCmCOFS73kjw9+mY4GkeQUVzXn1Wv2h6W4Y/Q9GIwzzJBzi2sgdmKpzIKFg3zKKhkRgNsh8uqD7fOcSDWCGvUtaezTOx1vZ1nilztN9GI5qFdaTdn5sZGiaMSzOJ6tAJoqOzyeOgUK+IpOWWJ35alypGwmYy2PujqRr3Dtu+gAzlIxdF7zCsOHtV4tCWfFEeLRtCWiHMBzqOtYzxg7JNqcTIRtGoH4YxGxHBgsIQK+HU0zdy0e6TwMPvC7Zvpg4x+utfdgv53i66Bq6fJ2ZeWNwxgMqYesIapGjCE1blaiYUstHZfGiL+uZ/qQmpWOy6zmDXxwqSpLIeGB4dtKhI42eJfWjby8ZJ+xYmgMhX88uwB3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JWYjZHa0lhLzRMSHlSTlRualFFeHNDVWhhdkkvaUdUZUExa2NnL2dhdlo4?=
 =?utf-8?B?N01QWkVmTmZHWHdxSllKdTJ4OEFyb0hhT24vK3p6OHd0cEU4dVoweCtEODdN?=
 =?utf-8?B?Um41QXBqbE80U1lBVi9jaWt0SHNJSFY5b3pnQXFIdDEzR2U4N0FuU1o2aEF1?=
 =?utf-8?B?dUpGRUlxbHhrVnZtUm5SWWRrN0xmbTlTc1h6cjVLRlVFMHhqZHEyLzZoRFIr?=
 =?utf-8?B?T25vZUxXNEprZHg1bzRDL25UN3pBMS9QR1hFcTA3Ty9uYTA2aGhiK1c5cmJE?=
 =?utf-8?B?cmxWNXN5MkdUMFdLUGw3UDIwcitDV3pkL3ZUZXpRTzR4NEFYbzdvejlNL1pz?=
 =?utf-8?B?Z3hRZlUwN1RiaHpBTmI0Wm1ITjRPNXBDd3l6R3dtdHZqc2JtajBKT1AzTnlX?=
 =?utf-8?B?c3ZjMFVqMjVUaDVHcVU4a0xpbnNPcGdGZkFvQ3VIMDJSYVVtaGZxMVQwNEZX?=
 =?utf-8?B?NGNZRUo1YkRUZEkrYTg5cVZsazhzZ0FaajdEOUp2dXo3OG1GTTVEN0dVVHNC?=
 =?utf-8?B?Ui8yWXNUaTY2Z2I1T0tzRllVNGdYeEZCdjJwdUplY1FnRGtUM2l0aXh4TkQ2?=
 =?utf-8?B?SkxFTjRFc2tIR1dhN2VxNStveDRtTTZDa3dQNjBrNG9mQTVpWDU1Wk96Mnov?=
 =?utf-8?B?U09WSUxuK3F1RFlMYzFaWmxnVGtzMmRMOExEaFViQUdQOXYxQmFVWGxIUk03?=
 =?utf-8?B?eGFGbWtvS0ZLUHhhVUR3Wmk2OEI4M2pzWkd0djA4cHNUZWVwK3lGL0NwUnpD?=
 =?utf-8?B?U1k2VUwzQTZsVEhCTWlMeDdrN0dkWGo5d2gzYlNPU2dGSE5IL29TdTV6Vm1W?=
 =?utf-8?B?YlJ4c2RQaXo0N1VSVzZNanNxblVUT2xqU0w0eWVPK1duSlY1T1dwY3dLYWYv?=
 =?utf-8?B?QlhTTGJGVzAxV0N6c3JEZWRvU1ltOGhTU3Rkc1BCSEdEOFRyandQWmlFOUF6?=
 =?utf-8?B?WmFOc1BRWVp3ZlAyUnpPejlvenloczNaaW1GSDBFakpYUHdPQXJsWUIyMTdk?=
 =?utf-8?B?Vm8xeUxOdkJjZEphQlE2NVVlVG9jUzZIOFdYREo5cDlNME9YbGVNdkJBQkdU?=
 =?utf-8?B?ZU5kZzRZQnZlYmc3dkYrbUhCR21JbGJsdThVRWJ1aTNHY1FkNUYraTR1SHFR?=
 =?utf-8?B?d3F2Vk96MWdaaHU0cmtPRzRQRXhEbUk4U2dCZUs3YWptMUhLZFduYnhjeE9w?=
 =?utf-8?B?V210cEptemJ2L3NKVnprQWQybXFWUi9OTzIzL0x6Q3pWVDlKSGJPMDgrblV0?=
 =?utf-8?B?NmpIWmtpQ0RqUnMySHRpM1NXR0dNOG5LL2YzRVJqVGE4ZXBRZnc2WXA4QVNo?=
 =?utf-8?B?QVMrRkVQejgzU3hWUDNnR21hQktEdGF6eGg4eTdKZjdObHBOSFBxaEg4MWZ3?=
 =?utf-8?B?b0ZyeVFkNVRVNDJ3WXBWRE05MTVBL1puSDgzVWdBNlJaZW5WNEMxN1ZqaUYy?=
 =?utf-8?B?MXh4aUZMMmFUVUUrem9Ud2IwZ0xNYmZSdTFGTE4vREUzVGVWOFUrTFpBRlRC?=
 =?utf-8?B?TmUwUUw2Wmt3MEJuNE9kQ241YmlQNzB4UmtvWlg0M0lVVkdNM2ZnRnpFWHdY?=
 =?utf-8?B?Mlhza2dlK0J0Q1JPM2tieHRGNWRRMGdhR2xUdEFOSjlUMC9vNGFheElSSHNS?=
 =?utf-8?B?TUNOU25Xb1RqcW5uMEVhaDU0b2NaNjhnbmlnRGh0czlWek9wdUVLVkhneDU2?=
 =?utf-8?B?SC9PQ29GQXVGU2poRms4R1MyVnlXdG1nUnhmSjZxQ1dlazl5RTMzcUhtMW5V?=
 =?utf-8?B?WUxOMjhFWkwyRzJxbHgyZDdHNXdUR0VxSGg0Y0ZnL0FtUENJWmRBKzBvUHdh?=
 =?utf-8?B?dDE2WXZiMFZuWGprTEIwMklKTDFvT3VpRC9WSUZVbU5EKzA3OWVoQlE3RXlr?=
 =?utf-8?B?ZmtjbGpUdzJ2cFROU2FEcDVvbDVwbGw2elRORFQwUU8rem42OXAvcE5jaUdo?=
 =?utf-8?B?ZjJYQ05HVlVMZVpSTTJqQ1JXaUZNdW9JMExWSWREZTd1S3pQS3Y2VVUzSmlv?=
 =?utf-8?B?VkhrL2pYeUdWYmpIS1AzdFF0S0U0Q3VET0l1SmVvdHhkQTFXckNaQ2F5c2VC?=
 =?utf-8?B?V1ZNM3VvZ00vdkUxemxZL2NwN1N3cmlvUG4rRWk0eXpEcXlSSzF2MzIvTDJi?=
 =?utf-8?Q?uf/h7TJ60eABDL2tI+DOq2WEw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad22f5a5-e46a-4cd9-0219-08dc38d1b047
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 02:54:03.8967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkDKhU8Tzxi5D1G5R18PvvcyfyMoD+C4W7ry4r7hABp5vgNDpZxmPDfRUm2uPoxV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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



On 2/28/2024 7:58 PM, Lazar, Lijo wrote:
> 
> 
> On 2/28/2024 5:14 PM, Ma Jun wrote:
>> Check return value of amdgpu_device_baco_enter/exit and print
>> warning message because these errors may cause runtime resume failure
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 8b83c26dc018..11e089cfb465 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2705,7 +2705,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>>  		/* nothing to do */
>>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>> -		amdgpu_device_baco_enter(drm_dev);
>> +		ret = amdgpu_device_baco_enter(drm_dev);
>> +		if (ret)
>> +			dev_warn(&pdev->dev, "warning: device fails to enter baco. ret=%d\n", ret);
>>  	}
> 
> If the intention is to print for any baco entry/exit failure, it's
> better to put the print inside enter/exit functions itself. Also, since
> these are triggered through PMFW, any PMFW fail will be printed. So this
> may not be that useful.
> 
Thanks, I will move it into enter/exit functions.
This check is mainly used for other error cases not for PMFW failure.

Regards,
Ma Jun

> Thanks,
> Lijo
> 
>>  
>>  	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
>> @@ -2745,7 +2747,9 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>  		 */
>>  		pci_set_master(pdev);
>>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>> -		amdgpu_device_baco_exit(drm_dev);
>> +		ret = amdgpu_device_baco_exit(drm_dev);
>> +		if (ret)
>> +			dev_warn(&pdev->dev, "warning: device fails to exit from baco. ret=%d\n", ret);
>>  	}
>>  	ret = amdgpu_device_resume(drm_dev, false);
>>  	if (ret) {
