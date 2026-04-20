Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB856EA71B7
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 02:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7432110E034;
	Mon, 20 Apr 2026 02:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iT5df+h5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5603E10E034
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 02:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbxmU80dNYhSA+wi/A6Yn5wR6w/Mjndyaj6RtGUUVuQoJFxea9B0aYVERzcYjbdaYGaFJdZMyXxtoullxSA5aHRNuafQFCoSwUpknQydPETv1HTtnVHZ+Ks8JqdhTMPgkbgB65vdGVXfMuUvnqpgKodBTQHe73dYEUh2nUCK3S1Zksc+UjVn+RhBvPQhkbPqpyszE8lXNDc6BoMvGfIXSnaSLcNsRyLyO2VA8EqNH1H+qI2qbUv/0IHp2TdH7ZhnFHkbg3C5qG9umV5FWZxAoIlGp4ba9v+HYWDaUVIzSRoh8uEthCJ02uWa7wVvuWECyl+Jh8MI/ZEF8M1DB6fblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVPyNRE2mG/OSAJf94oWL3BjT5vBEfnEjlBh5iyWZ+0=;
 b=X4G9ZoUf1nmLzayzZ9OEF041/MveC4EYHxKcO1N5BLAOEBOYeYdwQkYwJaLWfHxo8/AzxfTeapNUJnNi4lS+24Lh1EiD24uT08wnFNViLEBBAuOfrNFfzQlsY8mPV2X5pj1fx64dzyHtDVpy+FUZ+zqa2WIclI85dUju1n4ESGVyhPX/bD4XmmJMxaJ0D783Uq+v5I12IDLphWLhZ3fZIk8FRATE3jobV6yxH6vsXkhALQpKZTbm9JX4hk7XfLjYbzlJAufwpp1UH1R2rxtO32R4Bp57ZH1LHZVCJgGN1sI6hokSauqXldqDB+HIYi9Qe4sazWNmQq5itwNd/dxBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVPyNRE2mG/OSAJf94oWL3BjT5vBEfnEjlBh5iyWZ+0=;
 b=iT5df+h5cF2y6azmoLvEH/4ysuhstf7i5KU5GmvcYU+89WRqZpIbUzcK8EOJvvtqKw6G3RfD0IKyBGxIX1pfStqozCL1hG6mjSOU/9dZtu92iETbWtcK9gIfaC/U5zNe2S7n8WVooKL6AFVZbPyGvu6KYVPlpglOPTSqDKMNdmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SAWPR12MB999139.namprd12.prod.outlook.com (2603:10b6:806:4e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 02:56:06 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.007; Mon, 20 Apr 2026
 02:56:06 +0000
Message-ID: <c3148de1-0a1c-418d-b3b6-31c4570694ae@amd.com>
Date: Sun, 19 Apr 2026 21:56:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Adjust ASPM support quirk to cover more Intel
 hosts
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20260419041652.17673-1-mario.limonciello@amd.com>
 <2231677.9o76ZdvQCi@timur-hyperion>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2231677.9o76ZdvQCi@timur-hyperion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::19) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SAWPR12MB999139:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e3260f-5606-43c1-7d34-08de9e885def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ahvI6bkqr6bnqLXFnAOha7UdQQCyw+D+u25g5oKL+3aEBCnH7EO3r7j4bFmKWdzolE/n7BtFZuIMJtYt0oaBL2r+z6MU80Vx0SSNDJUi1KP7A2LNakoHbpc21KOH7Mp0Sz2aDwJwKnfdZhcxrDiilLzLcxwIUglSoKhoNOUOH69VUbsu350TcoUBtEUt/vzY4xlRTEJql8pRvBTTsFWSI0cih9dQjWODNidkAAe3zHJIfrq5TBMKm65wHX1NKfHMAiWMJEPA2pCLImKL9FFeeHocPMNAkr5LD0yVqJTrkQHeODIJoObKajzt4xFsC0Xgg7RzGS10XOoVdi/s8k68AEKDhDbnxDJ4pjh6/zG3Fr+G6Tf3cg2tnSsNKU2OXqebVh8arjzpjh9tje4h8WmhFl2JYqASt0HA15TCxqmui+zQhc1LKp94ZH5NDOsrBb7yt+79GP5e5K+H08msDTjdSSIC3Myp9mljnPHHn6m4xLXPvJSj4Fx4+nTUtk8rgbiJfOsiweXucrsMpc+3jURNiA43OuNYFERL4QPBQZ2Xn2aNS7v42FGg4wIKh4cPvSGRDBXgttfICO+b0NbbXd4xFoIpSRn0WlcChO3dl/VPsXTWi+xm4HPcO2uLelhlYoi+E/c856BSrHhc8Vwj1//NrrsdrzximzPUQmoHd0xNy2oucriIpGRE2MpKR1Hvg9Xl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkdraEZjZmMzN2E1TTBYSXJodDh0OUZ3UHZneEg1SUpibTc5UTBHSlBoRjRl?=
 =?utf-8?B?VkFQNjBTS2VnT0xqcktHUUdETTgzZHhsSHo5WEtpMmZ4bEVXV3lPUVpIcFhP?=
 =?utf-8?B?V1pjWG1mS2V3RFR0enE1YnlwVEdiajExeGlIQUJKSEVJdWxtbHArSnV1UGl6?=
 =?utf-8?B?QSs4UlNWbTR0VXVZak0zUTlkOExqb0VPckRJUXUyaTArK1BESXJRVS9oVkVx?=
 =?utf-8?B?cHNRanhISkp0NllGbXNHeURlQnNaVkoyeG5lalhCSmlvNXhwdmd1MG16dVhs?=
 =?utf-8?B?K2dwdnpiTE5JVzROSk5WR3Z6MEhlYzJYVHM3L2VoOHZScWFNQWEwc25vRUdh?=
 =?utf-8?B?c1hYc1c5djdnc05jNzd4ejd3QjVBdlU4SzhjZ0Y5cEMvam51TzhHc1VEVDRo?=
 =?utf-8?B?R2hxZW8vRGMvb1lQMGx2VEUzdFdmYnBodzl4enc3VE1McHcvNC80MGd2TW5h?=
 =?utf-8?B?c3NOczNoU05pVVFGdUdrbjAyZG1QTStKOWNFSWoyOWhnOWNoQjBSWWtPZ3lS?=
 =?utf-8?B?dDROMFcvdVlvSnM1Z21rbXdKSHM2elM1TWFYWENPRmlmRXVHMER0UjRJNFpt?=
 =?utf-8?B?WlBncHdGUjJHZjNMYjV6ZkJVb2c4YVZXM3VEQmcvdFpNMll1Z1hyaDNFNU1Y?=
 =?utf-8?B?emdweXZVdExMVkdyZExRR0NIUWdKbDV5dUIxRVdGNm1FaFVDZEMrNTNLVGtn?=
 =?utf-8?B?Tkl1Q1YraWh1R2xjN0NGRHJ3VHZ0RVJJUnlLbEdTOUNnNEFKYzhLMlltMmJk?=
 =?utf-8?B?WStrZFhwTjk4OURjendrWXR1YVlZcjg5ajdRZzlON3Z1eEZLdXRHTXJSZU95?=
 =?utf-8?B?VlpnT2ZHbVEzMmczNmJ3S3RKK3lwN1dHb1BiOWpMakFQNVlSd3JBMG1ET1la?=
 =?utf-8?B?VzRSN3dTSXNOTlRUNUx4R0JRMHJzYWdWQkpvamp4R29JSEo3cXlNd2pabC9V?=
 =?utf-8?B?cTEyS3M2WkZjTmhMQ2p2Z2FCSWFZc21yU3BCaTZ3dlZnVms5SFB4MGNVTVpV?=
 =?utf-8?B?L1p3Yis4Vi9pS21BVURMWmVQbnI5Q2RTWHF1TTErbFJ2Uk1RTnh6Ump2eEQy?=
 =?utf-8?B?WEJ4Y0pIcElEKzNxRkJ5SVBsekE5Y0M4ZFo4YWprekhkNkJaM2UvbGhSK0E3?=
 =?utf-8?B?dHAxYzhZL3hiZ0tORk9LYjExOTNBdmNKZjQzeU5GVjhIaDZvT3ZTaFdPbVZh?=
 =?utf-8?B?VGhsbG4zd3BSdmtFQWxOckMydEJrc3creUZRcWh0NTlJZm9PNmtvMXBrbThH?=
 =?utf-8?B?SG14Y1k3K1ZNU2dlQWxkbEpEOTQ0N3IvVzJNdUk4Z25kbnRIc0pjNkY4dlFm?=
 =?utf-8?B?dUxPT3VBQXFCVXBTZlRDYllYcW5NZml6YVl4YkpoWHlKeE5ydXdIT0NlNmxD?=
 =?utf-8?B?ZXAwTGdkUjdFYVZuK3pWSzZOYXJhaU03cHlwdUM2Qjk3ckw2U1ZoZnBnZ3Rs?=
 =?utf-8?B?eXp4VjhiMXl4eUhGZy82MXl2WkRmMXdCaElFM3Rsb1RiWlg3VDY5aC9uR0lM?=
 =?utf-8?B?TDBSM1YwaXNiNEh1R2R0MkU2UzN6NHR0eDVIeVB0MzVMMDNyU0hrdEJBZHBK?=
 =?utf-8?B?S0s2TXhJUXg1bWZ3TzhicTBYdUF4RVRmOEhOUFI5UVJOaHF1TjN0bWdUZlY1?=
 =?utf-8?B?VHJlTDVBbHVDUi9jWlh5dlM1MGpiM1hoMFUxZC9oOWlUcDMxNjBxQmZ1TXVH?=
 =?utf-8?B?YmlJTm5scml5aW5HdUhvWnZFbXZCbWh2bEZoTit2bG4rNzJDdkpEME54czFU?=
 =?utf-8?B?WEVrWnhlaHNTMnJMTHBGWU9DU29KK3FLSFJoNDg3R29PWTRWM3FvSE1RMzNB?=
 =?utf-8?B?dnR1cWRhdVJSNlB6ZDV5b1V2THU0b3NMNWttbHI1Tk0xM3g0MFAreXhoSHdq?=
 =?utf-8?B?M1BSVWFRRVV6bVhaalZLUU0yT3VMVmRwQW1yTlRmQ2RpT0o5UTVSdDdYVCs1?=
 =?utf-8?B?RmdVc29SY0hSSDhIaVozcFJvU1ozK3Q2Nnp1TFVYbTJCNXlucHpGNm05ZmxF?=
 =?utf-8?B?U1FWNG9XM2JhbjJCOU5UNHJHciswVk4zM2E4dmI0QjE5REo0Ym0vRmV0OXY0?=
 =?utf-8?B?OURha0JFSWNYYlhwKytkUndoSE1BZ04xSmM3MWxLeTUwdHE0ZjExc0Y5QkVO?=
 =?utf-8?B?MThlbGxNeUtXbkxORG1ncnBSaGJNN0hCaytrelZ6b2VvZTc4OEgwU2lhTkdJ?=
 =?utf-8?B?RW0ycGdjRVZWcU5HR0dReFJQRytnd0pFVldFakdyaVlWS1pnL3AwTC80OXoz?=
 =?utf-8?B?RjQxNTUzalVqellycEM0V1B3MEdEZGJoMWxpSGlEazRPTnpPeXFhamRFSmpt?=
 =?utf-8?Q?NkIm53aTVWDg+N9jgU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e3260f-5606-43c1-7d34-08de9e885def
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 02:56:06.4756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg4xYnzuN81rk5+/YLxBsKrZhnzKjrNfNwQKGKOer+3/mzaOEb2TbT0Yh5P44w+cvTzbFI6/PgPXJU7VsRrJgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999139
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



On 4/19/26 15:28, Timur Kristóf wrote:
> On Sunday, April 19, 2026 6:16:52 AM Central European Summer Time Mario
> Limonciello wrote:
>> Some of the same issues identified in commit c770ef19673fb
>> ("drm/amd/amdgpu: disable ASPM in some situations") also affect
>> Tiger Lake systems with GFX11 connected over USB4. Widen the net
>> to also match these hosts.
> 
> Wouldn't it be better to check that the connection is through USB4 rather than
> entirely disable ASPM accross all these families of CPUs?

Historically we've had a lot of problems with Intel hosts where the root 
ports can't handle the link changing.

I don't currently have any evidence to say the root ports used for PCIe 
tunneling are any different than root ports for tradiionally connected 
device.

So I am leaning on being more cautious here.  We can peel it back later 
if that turned out to be wrong.

> 
>>
>> Fixes: d9b3a066dfcd3 ("drm/amd: Exclude dGPUs in eGPU enclosures from DPM
>> quirks") Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5145
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c index
>> bc7e96b58d3fc..b11c4b5fa8fcd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1334,18 +1334,15 @@ static bool amdgpu_device_aspm_support_quirk(struct
>> amdgpu_device *adev) #if IS_ENABLED(CONFIG_X86)
>>   	struct cpuinfo_x86 *c = &cpu_data(0);
>>
>> -	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0)
> ||
>> -		  amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12,
> 0, 1)))
>> -		return false;
>> -
>> -	if (c->x86 == 6 &&
>> -		adev->pm.pcie_gen_mask &
> CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5) {
>> +	if (c->x86_vendor == X86_VENDOR_INTEL) {
>>   		switch (c->x86_model) {
>>   		case VFM_MODEL(INTEL_ALDERLAKE):
>>   		case VFM_MODEL(INTEL_ALDERLAKE_L):
>>   		case VFM_MODEL(INTEL_RAPTORLAKE):
>>   		case VFM_MODEL(INTEL_RAPTORLAKE_P):
>>   		case VFM_MODEL(INTEL_RAPTORLAKE_S):
>> +		case VFM_MODEL(INTEL_TIGERLAKE):
>> +		case VFM_MODEL(INTEL_TIGERLAKE_L):
>>   			return true;
>>   		default:
>>   			return false;
> 
> 
> 
> 

