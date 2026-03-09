Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7F2FCA191
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 22:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19EAB10E5D3;
	Mon,  9 Mar 2026 22:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+ROMzdA";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2EF810E5D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 22:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw5eJNTWBo935BJAFtFKqkSJAzE9gvBB7QpBH5Peau+2Sn1PRkXRtB1raWUYWOIdUZGPNs0OsrsYTb4/u6f0vO63ING77lLg5kWP4fLYMCz9m4ZTUsLhEtm6HyzfT59cqUo3fnV7UfMnz6FT6nke1fWSuTgqmx5z1eIO1HUChx1SIuHQzLBzOLmseK36Oq1eCpBulk2zjZ4h4mE7fohuEIcSLtyyOnLyZ46SXwu+RGqdFV60MEaDgkDAD6yZK9bvddG2EPJ5VIBerh2IilPbaRdIiM1GRIuEmSw3rwR4xpTUe3w9LN0MwfP6KrWw7Lg7+OmuUsnf6+zI0yKG4gkIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUuRr+CFF3C8XVnfvm1mygYTLtjjh2IWRpr0LcrTSQA=;
 b=MtzWPWJ92aq8QxdURrZt/waNQQU8KAyINGP5l8Ve6VIkVyM1+hbycWKKUcy+in50fKc8+gHJlMf2feJQBtmzostiVmF8OqtSprUv1WmVw2rirXcp5EvCoumiHFgxU9Z4jatoQvDvZggcAbxYWc8fXKbISgsqMjVMJ4vqsfjqvSUFwKS6IOEJ/fjdZxoJ0u1yRHvo+uQvTldbKNdNtlhMmdFhLvzllDU6UAJJ50jwW+PzOhHDuW96VTSxJQd9uSccZGdh5b6Z9jeO1e1zDXAAwZ2gojvmgG8TgfyQ05oqKw5XHJflHXWNTCXQYMhzhhq/7U5QfPKIOhDaaXv5NotQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUuRr+CFF3C8XVnfvm1mygYTLtjjh2IWRpr0LcrTSQA=;
 b=F+ROMzdA03dP45rI0POs8FXqK2PcKeG5nx7BcORrpDa6KLy4+EEvxxElMtu8hBiOrOd2xqYTggMgnrxX1RfcDnPInHZPeirIPkBF+YnIEx7ot6sR7ecjS/Hy9pHdg+ocz2Y3lcgMwuRQ6t+IUC9lg+U7TnO388r1XS6WoGHG8Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 22:18:27 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 22:18:26 +0000
Message-ID: <218c7cca-9eed-49aa-9d84-490f51575d31@amd.com>
Date: Mon, 9 Mar 2026 18:18:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
Content-Language: en-GB
To: Alex Deucher <alexdeucher@gmail.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 mlimonci@amd.com, christian.koenig@amd.com, rafael.j.wysocki@intel.com,
 benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <CADnq5_Ns2bh1nbPrbtBj1iajyp-5mtB7a_0yBv56vzsQRyRwmw@mail.gmail.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <CADnq5_Ns2bh1nbPrbtBj1iajyp-5mtB7a_0yBv56vzsQRyRwmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::37)
 To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 73316b64-376b-45ba-08a6-08de7e29c8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: /4asgpMs5WLG4h+Z5R7KN9XtxxGeb3e+KT/yn3Gzr+Sh5nMWQ4Z/icZ6d3/cfwnuCIeOy+zjAZQWsmCeLldNW8HNUmTYm8xGR4ZNqSvr4YhoqfjHGdgzDop2yrcZqs6bJNr5rBDk6enNQjlu/bziQiblDGDAbZSFhh0AKVZn+YriLTvebaSEMRpj+TLeEUSBuOkQcWDZO7yDrPgz67UHXvSDyk7IT8lPUd1HQlkRwl68ZyvJI+5DJkSkpaoKpWCc4kkefMgvmFtIh7C5S+FVjPG2dU1ACKKcbFspkz5jT/0o+bzKnP9MRU9R7JnjPW5LOFcU67VWSehaVZr81vtoC/SnMR2NEo0WiBjc2bq/skbpudQjQjiGc1NxjCnmekRDdQ7vzNkxAS0dEdwvqFEefgEQrpOko/vO8hlQpP81K9fM9eYUYuXD6BCnK9aQ8DtoxvUDsuK6emZPS+KfpfagVwvXRlGBaRK+7T7gAWuRvyBIJTjFEOU7fSMhgVp2YP3GjP87siyGPB83MWQUOeBLJpiZRxe6gAVnYenIb8y6RCDpBS2fK62P0NopZw80MOox5g6aXo7lzkoTME4a7K/OK6GZw24dNc9mTrLjlpev99o5gWEMYK0Mh51QazXzju6LibCUfe+4HJ72KxhYHPgXKXdvKFc0QcBhd8AQwNJwsf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01QdFV0UWxCVG5Qc29vR0xJc1BRa25WMEYxamE2T2VmSHFPbGtUSW43NVlW?=
 =?utf-8?B?Z28xdEd2NXhYMEUxS0QxQjBOMmlIb1oyUWd5Und0eXJVaHVvZVJjYkxtd203?=
 =?utf-8?B?QWZONTk0SkFhSmxmajZNWmtvUEFjWTRCamtaQ2Jhcyt2Zk1pYWJ6WVhuaG10?=
 =?utf-8?B?RGI3MEJKU1FJV2xJYW1xOTJMbXptUmdTTGgvSVdBS21acmg2Ykd6WE1iZ20y?=
 =?utf-8?B?OXpKNm02YmRnOHVzMFE4cmxoaFJ0M2hoME4yUnRucStVYVdpMklXYzZTRlRP?=
 =?utf-8?B?U1k0VkJWNWE2dFczR2pzSmZkMFB1eFNzdFE1SmUxR3ZxdlEyUnQxcUZraTJm?=
 =?utf-8?B?UGh5aTljQ3FDSHFUSWhUTFBTWFZ2QnJIdm15YlNKV1NwNWJKZ0RtSVVBRDdt?=
 =?utf-8?B?UW5LZWZYemphWmNwbTJCOE5OOUxHaXBZQytoWCtlWUp4LzlFYWU3dW8rYWly?=
 =?utf-8?B?bVlXd3FsaVhyY2hmY1ppWmU4cW9YcEtYc2JYajB5QVk3ZFA4UGtMT200L0Nj?=
 =?utf-8?B?OTNLMWZBUTczOXUyTWtMWkxaOHF5b0UrbXVhTFZ3RW5JZHdjdy95YXpmVnUx?=
 =?utf-8?B?b2FqQzNOa2RSZGVnY3U2dHVEUVBTa2tVbGFVaFp1Um5zUFk0WU1BMCtvT2Np?=
 =?utf-8?B?cU9qUU10eXFPU1dzNE9wYVRMUERnYVFRK1lhZzlGSk1hRmovSEtCbmVWWHd1?=
 =?utf-8?B?SHUxNTBObS9tTUIxblZ2a1d0VlpiSk1jUXphcFRGWkVwVTR6NVYramZ2d0JC?=
 =?utf-8?B?ay9KZk1lZGlxRlVkZ3RMcTdEVjRuT0UxYzJkekZoNUh5c2E0QVJiaTJaQ0Q3?=
 =?utf-8?B?TjFMWWtZU2FGZ2Z5ODRudFFYQnhPU01haEZ5ZFErcU5yKzJ3TXkxRmM0c3VC?=
 =?utf-8?B?VmJTRVVmVGhvOG5VY3huZkhIRHVlc2JmMTgwcSttNkJVbkFmNVUyeU5qUnhH?=
 =?utf-8?B?aWkzZXl3NGRoUERtT21pY3Q2bWVURUxtcFNKSzRFSyt6dmNxczF6WDJWa2hz?=
 =?utf-8?B?Z3M5am5NZEZxV29WNlN4aFAwQmN4QVZld250U3dTakhKVU9NTVRWRnEydVp5?=
 =?utf-8?B?b05DTjFGRjZqV1NPVjloa0JIVVlWeklBOVd3V1hMWFd2Q3c5anhDakg5bysx?=
 =?utf-8?B?bVdFZkNwUFRSNGp2YXNxU0dYNzh1VEsvV1V3cU5kRUErbjY4VDFVZml5MWor?=
 =?utf-8?B?MkZmelRGSXA2dnB6TjcwMzRPK2RQRW9ndWJsUjErcnZyWlYrUDh0eGRhck4y?=
 =?utf-8?B?Z0dnNnBLYU9rb3owbyttWU1HQ1lxWEhVeXBjZ1pUOUVQbG5OWkZqYVE0Y21s?=
 =?utf-8?B?clFPU3lOZmZsNUkvODE1QjhzdTMrVGlEd1ZIak5aby9sQmxlSnl3V0Z6VVNC?=
 =?utf-8?B?ZkJHWW0rK2JrZEV0OHVqSkQ2RnU2UW95eVNhVGNiTUp5S2I4b0JDVktxelEy?=
 =?utf-8?B?RWNnREpydzJBQXQ1VTRTUFl6NFdsNzlvNHJOdUZqVUxhSzd1NmsyNHhIZzdt?=
 =?utf-8?B?T2NqclVWME12SU5Pc1ZmeEJqWkUrL0RZYXc4YzU5R05lSFVWYkxuSHhST1Ba?=
 =?utf-8?B?RFRRYlJncDFMd2RndWE1N2lwa0kyM2NrTDR4MXBmanBvMlFLNFR3b2l4WnJP?=
 =?utf-8?B?UUJsdjNRb0lPR2JHSmhEdzNYTVl4L29XSHZCL2gxNThYQ3VhQnF3Uk41OUJk?=
 =?utf-8?B?b2VPemx1WThVVHFzYUNtVGdlSllqeHFsUWhTTk11ZFE0cHU1dnFJRTZnQzNW?=
 =?utf-8?B?dVhMYmRYVW53aXo3TmFuQlJrV2V2cTJieXl4T1YvWDNDb1licTdxeFZxOGox?=
 =?utf-8?B?MVJRV1p2ZGVMNW9VRUdFc0VuUnZTb0NaZTFDY0ExM29PV215SExVa0FpWFQ1?=
 =?utf-8?B?N1dvZ2psdnZNUVlTcU4zR3I1Mk12YXJkUHBzOTlmMmpXRVhSZ0xCcjlCUERV?=
 =?utf-8?B?V0hCNU43ekNBOVJwZWRFd1ZQWkNGZ04wUlR0MHRWSmdGMVVjbjFFMFBUZVB5?=
 =?utf-8?B?bTIwUE0rVVAxbjZOMmxOMm1iN1BmOHZoMk90YVUxL0tMTFprQXhYUUR5UHdt?=
 =?utf-8?B?WUJrbFlWYWxibmZ5RDRxUitYQzhxSk5ReWo4MTVEZDVQVy9maXV0RWJCQXV2?=
 =?utf-8?B?T2liUXM0UDZzaG9EeU4zbS9OMnUxMEVOVjJKbmZNYzV4N2hzZHU2RktUdTQz?=
 =?utf-8?B?N1JrcnplZkNaazYwbkxiMEYzRitrOUhTYkVGUU1oaCs5RlNVZkxlMWJpKyt1?=
 =?utf-8?B?QjgrajVuWWdUU3I0UTRWM1pjWDJwanM5S1pZMFNSTEJmd0FwMlNQc3NOT24z?=
 =?utf-8?B?cW0ydXFNK0wweXlNcVNGRjRYcXpxUG1QZXBrOVVjNXFVNllVS0hJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73316b64-376b-45ba-08a6-08de7e29c8ec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 22:18:26.4434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFLJbui80gjLS3q5KKsFow/XK08EuHyuquPmnNeWMojTqO/pmJO8eF4ndWezdIbfeuzx0RnUpPj/QgtfanjY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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



On 3/9/2026 6:05 PM, Alex Deucher wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Mar 9, 2026 at 5:59 PM Pratap Nirujogi <pratap.nirujogi@amd.com> wrote:
>>
>> Add NULL pointer checks for dev->type before accessing
>> dev->type->name in ISP genpd add/remove functions to
>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
>> ISP driver dependencies are loaded in correct order.
>>
>> The regression was introduced in kernel v7.0 where MFD ISP
>> device enumeration doesn't complete by the time it is added
>> to gendp. The timing of ISP device enumeration has changed
>> because of the changes in registering the device sources in
>> the device hierarchy.
>>
>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5021
> 
> I'm not too familiar with the underlying issue.  Does this actually
> result in the driver loading properly or does it just prevent a
> segfault?
> 
> Alex
> 
yes, this fixes both segfaults and automatic modprobe issues with isp 
device. Camera works along with suspend/resume when the system boots to
desktop without any manual steps involved. Please note that the below 
ACPI driver fix also needs to be included when verifying this patch to 
observe the stated results.

https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/

Thanks,
Pratap

>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 95d26f086d545..920595f0d22ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>   MODULE_LICENSE("GPL and additional rights");
>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp pinctrl-amdisp");
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> index b3590b33cab9e..485ecdec96184 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
>>          if (!pdev)
>>                  return -EINVAL;
>>
>> -       if (!dev->type->name) {
>> +       if (!dev->type || !dev->type->name) {
>>                  drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>                  goto exit;
>>          }
>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
>>          if (!pdev)
>>                  return -EINVAL;
>>
>> -       if (!dev->type->name) {
>> +       if (!dev->type || !dev->type->name) {
>>                  drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>                  goto exit;
>>          }
>> --
>> 2.43.0
>>

