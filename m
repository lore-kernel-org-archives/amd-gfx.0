Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D0DC4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 09:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA5A10E6D9;
	Thu, 30 Nov 2023 09:47:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0FC10E6D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 09:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGgERiCvHCzYBZ1icYgiGmW32mKFAIs7uxB+nmMj5Ej4iudASBC9+eGVj0i5aWnZ6gv+yHxuFfUjxhNQJH/sMMVlhlJxLHr92j54/qUsLXeYPj+2LcyYsWWdx1HmK794+qfAXYYZe3j5AOAtLRD4BDeZcwvzD62HAfCtdfXNp6+EPrMpyOH4desNsoru4eJ5Q92Dou7Hl0YUFkdL9CslVyTw9ofIJ6MTsKx5+PhGRdXkOty59DiUzY+JZdDbynEidSd1Sc8713tTaGS6Z72LnVauXJ69Vu5PBsCDuGA458fyu7Jkde8BHgAC5YLtGcms0BnZDx+MEjWgbGMSUfO7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW2gKSOqecgPdwTfLSo1K0nYBs8ukyPmx/r7SouCD14=;
 b=WnxQrKdo2gShhkFXzkjp61l0gY1FvJXamCry2Yx3F9tuHa9PdQ3UVgHn2wNPQUq+yXCJlCxorwUxKboMJsFH0JazHoRSuVRHchKq0nM+Yg+a15xgaUGSPHcjU35kSBsXS2LS36BckPuYKW5taMpmWjB71IzQUR9L+iUkW8Y7Shy3eJiXcobph+A+BRe4Yk+d1+jk77myftZwblnM66fH670KOp8FcnP9logA2ueqATlUN/yKJthJgVuxGJOTTHE3z8r/aEA/9mHxoe1Ax+6L3csqTOYzR/AZPklve60GPw4DDEmO1LhJwldsJVFI1lgt0kblReY0CgJAFYZN8XHo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW2gKSOqecgPdwTfLSo1K0nYBs8ukyPmx/r7SouCD14=;
 b=yVsezP8Ow+9/a30ANrOWH9Iq2xVaW1X3GONk+7erGYOszUTsAFYT9j9bReTDpu5tVWeFTdfkFOR3rr1Df0Eu8xOdCG82QtpKHxY3MrIRcASVKD2y/cY6I6E6h/FN8cKDowybW/0buIWqjctJC2UXhMCo8gVJPNG1KvaD3ee+4Xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Thu, 30 Nov 2023 09:47:04 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 09:47:03 +0000
Message-ID: <68eb768e-cb10-4208-9ea1-bd9f09c38970@amd.com>
Date: Thu, 30 Nov 2023 17:46:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
 <d21116d8-9747-4b0f-b574-18b0d5558f16@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <d21116d8-9747-4b0f-b574-18b0d5558f16@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5f4cd2-9932-40a3-0cd3-08dbf1894ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTBoiRpdqJITx2FrWEdGk36UEmHyNw65ZoLEGJpyHuCMjp39Lv4lAXe1vwW8dDWfGZ8WHymRP9I8N7U4o5COXEHDmhmBBB6i7WWiJ9SneOh80hTAr1hI6HYXCtBfTJWevZWeU8XbUVGMyt5C3hH5Vd3bXcwlWy0/sawvcKKts4rf01k/BUiu+I9RMKlP5aZnnrSIsEhQPxiciN5+bAziOHeUxxi9nbH5ljabIsEG/Acb55rjpogTKwuN1wo+PPRGtCFoNE/0pMYCfr7mHOoHGuYZK1A4+m4G4nROhXsqJSmaBRMmm6LK8j5YYCQUPKC+vpTVt1BlHpqCvrxq49Ie9mcW6aCV+LDHr6gqLR04ph/z+5dR/iu4UWRlfYWEB9OJC9oxgjaylwhhd81O6i4dc3eunh2imu80aYQQtb1rdoFPvemHkz/cWA5gWNN/45CdVG/vDo64tFpc1JlsE9OH2X1Y1komhZDjRqk03Uki3YsaaTlmLR/4KBTVsNwpQOphKbrt1CogUd+j4CT1xRTkVvF55MnnZDhGCZJphaeiutu/bsrPODuBU5u6FoSTgruWN/KShg5+JHdkKWGMMlq1PXbwfvNQSf2P3Gnb209y7ZF5W4mzFHBRzteRZ9nSKrzKLHgHdcUPE6uPh4G82sxFA8cqzx9CPmcqzvZW7W1dRGk6+jUz6sghkszvJTrxN5sWjQUviGYndG0r31bgOI98Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(31696002)(2616005)(4326008)(38100700002)(8676002)(6666004)(8936002)(5660300002)(2906002)(26005)(110136005)(31686004)(202311291699003)(6506007)(478600001)(316002)(66556008)(66946007)(6486002)(53546011)(66476007)(83380400001)(36756003)(6512007)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2E5b0ZHSlo3NGNzQUFmMWFyMTI4dEJhcXFMSU9iYno3dDFRUk1uRy84OHZM?=
 =?utf-8?B?emoxQ0FqcSs5dGs4ZUcrTGJvdlJUMElYTXo1Vld4alBzVUQvQ2hiaUVrOUhG?=
 =?utf-8?B?azBoWlhIbTAyT2RjbFBiWkY4TUI1MUs5SEF0VUlMamFFdFZzeEM4WGpzTGUy?=
 =?utf-8?B?Zm5rVGc2OUZnT2wxMjBMSzk2d3FqU25IQ2t5MEl1YXB4aXFTck1zMzhEQng2?=
 =?utf-8?B?aDQrKzdLQjh2VWVhOGgyTmowdm5hQmh3UWFnblllbEZnbEJMaWpEVDliYjZZ?=
 =?utf-8?B?ZkR2OExLK291b1k3eDVkczFzMGlnTDB0SzBjL2JFQ1gyNjhWakJxeS9lWVM5?=
 =?utf-8?B?eDF1SUpoZFNpbE1FSVhldG9LVklaQ21qMHpUM1RxSkcvcUtuZTNSM2xOdlR2?=
 =?utf-8?B?UkJXN0hjUis1VXhETlRES2xHK1ozanJINFl4N3lRdEs3K3VuVWphVngvN0Ja?=
 =?utf-8?B?MEdoMlRBcWNadlVNeW5zWDRZU1BiMk5MY3lJOC9lazRRUTNzTUQySS8rNjZs?=
 =?utf-8?B?U0YySHZQQVpUTnBydjd1cmlpcWJtR0FlNmhiVUNueVl6VkxCdzlvWjJRdVBn?=
 =?utf-8?B?MHRIaU9yOC9VRWpZdFpxYy9ybkhsZ3ZDVU5OdlE0YmoyZU9FaU90Y2N6SDZW?=
 =?utf-8?B?czFrVnFQMVBZUjZNbEFCNE5NZnB5NVhhbkJhUndhQ2hRMDdEZ3l5Z1RFZkkx?=
 =?utf-8?B?VzFTeG1SZSs2N2JHT0NoamZHbVJ3WmJ0cGZkV2xZUFVreWtBL285R214cjNm?=
 =?utf-8?B?SlFZcGk2alVtSFBReE1leldWMkh6cWZxTWRuMm1DVE40aXFoM3l5YTVqSmJJ?=
 =?utf-8?B?NXB1MmVkaTl0ekxRUmlpWWFQaktHbUNESnJvZW1vOVh2ZDNCMU4xREowN0cr?=
 =?utf-8?B?V2NUQnJoRW4zWnozTkFXc0hpZ2lRQU1mdkR3WnhFN0ZHc1F3MjFuVU5BU1oz?=
 =?utf-8?B?bzE1QlhDZXVuZ042cDQ1WlMvOU1Na1pWbHJzeldUUzFzZWVYSUM0YVNObUgy?=
 =?utf-8?B?ZTZSaEI4OUlMSXNNUmsxNnBTWlZJS1NYNkNCYmtQRjZpeFErM2FIOHN1ZVpo?=
 =?utf-8?B?MktFTDdzRkd0cmJQVUI0ZGU4b2psSjFIcU5wNTNvN0t2cVlYQ04zU3J0Y0ll?=
 =?utf-8?B?OVNMT2VYMUJxR3JzdXNZbkU5UU9iN2VHdCtGU2Q5RWx2WEczUFhuY3Z3eXFJ?=
 =?utf-8?B?OXFROTNSSG1nczYzR2NPUGllanpyUXBpTDZ2N09MWkg5ekp5WCt0dEo3aVpm?=
 =?utf-8?B?ZWVwTmt1YWRHTk1EaDN0T2t5TlN4TThBd1EydlZrWWxFOUdXR04xMXpoemtZ?=
 =?utf-8?B?ckdFam9XQTV0aC92MDI2SHoveEE4Q0ZCR01HcVdNUDdVYm5nN1d6NGpPNmJn?=
 =?utf-8?B?QmtoVU1HVTdmcStWZHZSSHR5UHl6eHhDRzRWUzhvK0VHSXlET3BzbFg2Ni9u?=
 =?utf-8?B?ajIzeldYZ2xYZVpabTBqSnYrMlcxaWd0ZTUzRENKWXVoUlpFNko2VVJ4NWRM?=
 =?utf-8?B?SDBFS2xKcEVJZjZtY3V2UkdJam4wYmpLdnBydG9LNEp0bDVVUFIrNkhOQVU1?=
 =?utf-8?B?MklTK2N1blBSMkpncG43K2NRYW5qd0JGcTdvQStlUHArNlB6ZzV4TnlZNHRD?=
 =?utf-8?B?Y3ByRGZuTDBqR2IvQmFSMTdibjJzTXNIaGIzMXJCaHMxUmtXRC9pMmIxSnBW?=
 =?utf-8?B?Zk1qR1hlcnJJdGVaVVJjdEoxVkZIcW10b2IrS2JXV2I5QVN3bTVxbEVKemJ5?=
 =?utf-8?B?Mi9RUXgwOVlqVWUwc0N2bFNQVXczUzNUWjNBeGFvbDFwQVo0Y1VJb3FPazhK?=
 =?utf-8?B?Q0J4UU00MUZzSXFiNklDQzN4NEdNcmUxRVdGSWprem4xVGpVS201WS80R3Mz?=
 =?utf-8?B?aEZRVkxoQzRWRmRDMVJEb1d4dklxZWNwaU8wazNzcUZhL2h1MDVmWnc0MktB?=
 =?utf-8?B?TFV1WkdTeVpRNDNnY2pRY1o4Q1RNUjFrSVBHaWdpM05pSE5WRzBIOEt3ZDFM?=
 =?utf-8?B?QUFDL0V3dTVHRTFyK0s5UjBsVC9EN29rM2FZWW9wY2R3cE9lSSthdkJHcjFq?=
 =?utf-8?B?WktpQlIzWWRybGJBVlFTa3lTOHh0RTFVaVVsU1dvUnNuc0t4Rm53MFpjWXlh?=
 =?utf-8?Q?9XNoRaZrwlnJ6/X5xjxAJ2WVz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5f4cd2-9932-40a3-0cd3-08dbf1894ec5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:47:03.8496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVdy8AAgNPmOVvytIzIayocoxt/9dgFk+3/IYd/uA8z62RtAcodBpM8zglg5yQxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Mario,

On 11/29/2023 11:35 PM, Mario Limonciello wrote:
> On 11/29/2023 02:51, Ma Jun wrote:
>> Some platforms can't resume from d3cold state, So add a
>> new module parameter to disable d3cold state for debugging
>> purpose or workaround.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
> 
> This patch is essentially an 'amdgpu knob' for d3cold on the root port. 
> At least for debugging purposes we also have a sysfs file 
> 'd3cold_allowed' that will enact the same behavior.
> There is difference here.
In addition to disabling the d3cold state, BOCO is also disabled in this patch.
Otherwise,there is a scenario where the driver uses boco and the root port uses d3hot.
It may cause some unexpected errors.

Regards,
Ma Jun

> I do have a patch that I proposed to PCI core that stops d3cold_allowed 
> from working in favor of requesting pcie_port_pm=off to be used instead 
> for debugging purposes.
> 
> However that's a 'relatively big' debugging knob however as it will 
> apply to all PCIe root ports.
> 
> Considering above I'm in favor of this being available as a localized 
> debugging path for just the root port the dGPU is connected to.
> 
> Some comments below though:
> 
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index a9f54df9d33e..db9f60790267 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>   extern int amdgpu_dpm;
>>   extern int amdgpu_fw_load_type;
>>   extern int amdgpu_aspm;
>> +extern int amdgpu_d3cold;
>>   extern int amdgpu_runtime_pm;
>>   extern uint amdgpu_ip_block_mask;
>>   extern int amdgpu_bapm;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 22b6a910b7f2..90501c44e7d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
>>   bool amdgpu_device_supports_boco(struct drm_device *dev)
>>   {
>>   	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	struct pci_dev *parent;
>> +
>> +	if (!amdgpu_d3cold) {
>> +		parent = pcie_find_root_port(adev->pdev);
>> +		pci_d3cold_disable(parent);
>> +		return false;
>> +	}
>>   
>>   	if (adev->has_pr3 ||
>>   	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 5f14f04cb553..c9fbb8bd4169 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>   int amdgpu_dpm = -1;
>>   int amdgpu_fw_load_type = -1;
>>   int amdgpu_aspm = -1;
>> +int amdgpu_d3cold = -1;
> 
> If this was chained to a larger workaround (such as automatically 
> applying to a DMI quirk) it would make sense as int and with using
> -1 for auto.  However there is a pretty dramatic downside for using this 
> knob that it can break s2idle.
> 
> In my testing I've found that the following happens on an A+A design 
> after s2idle with this parameter in use.
> 
> [   70.572270] pcieport 0000:01:00.0: Unable to change power state from 
> D3cold to D0, device inaccessible
> [   70.572481] pcieport 0000:02:00.0: Unable to change power state from 
> D3cold to D0, device inaccessible
> [   72.855769] amdgpu 0000:03:00.0: not ready 1023ms after resume; waiting
> [   73.943545] amdgpu 0000:03:00.0: not ready 2047ms after resume; waiting
> [   76.055602] amdgpu 0000:03:00.0: not ready 4095ms after resume; waiting
> [   80.279550] amdgpu 0000:03:00.0: not ready 8191ms after resume; waiting
> [   88.983562] amdgpu 0000:03:00.0: not ready 16383ms after resume; waiting
> [  105.879581] amdgpu 0000:03:00.0: not ready 32767ms after resume; waiting
> [  142.743646] amdgpu 0000:03:00.0: not ready 65535ms after resume; 
> giving up
> [  142.743793] amdgpu 0000:03:00.0: Unable to change power state from 
> D3cold to D0, device inaccessible
> [  142.804011] snd_hda_intel 0000:03:00.1: Unable to change power state 
> from D3cold to D0, device inaccessible
> 
> So I don't see us ever automatically using this and it should be 
> debugging only.  IOW this doesn't need to be integer; it can be boolean.
> 
>>   int amdgpu_runtime_pm = -1;
>>   uint amdgpu_ip_block_mask = 0xffffffff;
>>   int amdgpu_bapm = -1;
>> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>>   MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
>>   module_param_named(aspm, amdgpu_aspm, int, 0444);
>>   
>> +/**
>> + * DOC: d3cold (int)
> 
> If you flip it to boolean as I suggested this should probably either 
> rename to disable_d3cold or you should default to TRUE.
> 
>> + * To disable d3cold (1 = enable, 0 = disable). The default is -1 (auto, enabled).
>> + */
>> +MODULE_PARM_DESC(d3cold, "d3cold support (1 = enable, 0 = disable, -1 = auto)");
>> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
>> +
>>   /**
>>    * DOC: runpm (int)
>>    * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
> 
