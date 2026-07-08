Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1FCC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 10:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B4210E331;
	Wed,  8 Jul 2026 10:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qeQSiQ5o";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC3510E331
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 10:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huaEnSdq7LedjLzq/Ftg4ARFWx5eh4vUuPBObsjU/xcrayzXxtZJzix2Pn+vLtq6bJvXuvqiWECjDRRggOxJlRrsKYoWRV2nfGWXSr2bU5TYYz1E34iA3uAzwa31KkbCX7kMuUuOLEIcT2dTfbKoBFeIKvW5qlNCpZVAdHqLOUaKJRlBxEkIJAwkeQhNK5G/X8p6xtjgs02pGGff7G2aIL61M0uTJs+rn1vuUI6ti3oiv3sjnijwhV6x4DlP/4/I32e19O7n0MbVx3uXe2JnmoqRLT1Zqkz6AqUUMVPoTwd6z7fWig54s8r2CMBKwRChF5V3XG+bYHvIWfEgoI8taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrwHUfyF4oAxQ7sTsOP64CfjTiJgJdyopzlT01WA5hA=;
 b=LI4fbE7JKEwohMRFRiGDo3K5ZBfZ5m7oVXq9siXFsofVQrCZ+w+vWPBKrLRqwkSYo2oDZjvg3sLt8QdqwT2kksnBozyC62CiuVoGvhFk52zA45v1C284xRK11EZZ9OO36FDGJN5tXtdyRMUfJc8oJMrWJIsnRY6YEpYmdhdSFgJ5sa/ulazNLJ7REohGeCz+QrGbGuJicNF9JkUbrYuI4sC2u2ofRUlw8rtgWw5+7h8YCZtSfHQQu3OkkOYOQw/gTXjFbVuUgzGoTSAZTakzdstl/RlrOp5r8Ugx0E65Aqp2180Y0UpHZxTYOC/HQdbCRJRxj3YFI4VF/YRpqeqe7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrwHUfyF4oAxQ7sTsOP64CfjTiJgJdyopzlT01WA5hA=;
 b=qeQSiQ5okUb5sxj0Anvys5g6Y/grqIRAAK/M/jdrcsEKO3ttCo6i8bqBHcpsVXWMjR23SNLpYxeJps6hIFlU094nKpHUJerz4rxtSPMBZfN7pVLdsehqbtYRLcYddvTnPCJpOnjBoJmRPAh5BdXlXCH7/e4PtoHs2U0mgRgwSeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 10:48:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 10:48:38 +0000
Message-ID: <989fc4ae-cbac-4f17-94cd-5be270845081@amd.com>
Date: Wed, 8 Jul 2026 12:48:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
 <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
 <de530731-21de-4470-9316-dccb767c87ac@amd.com>
 <DS7PR12MB5768E211043CC584F05A16569BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB5768E211043CC584F05A16569BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:208:237::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 873e7c3b-f638-4263-4ba2-08dedcde76f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|4143699003|3023799007|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oNTFx0bUedMEmZMGY1QdgdcD16rRLCgT1Elsf/GMtrQ2j/ReAixmkuJYzFFUhGojmGlmx7xJNvh3J5KKdiV4a0+uvJOZuoto3YfbEWP4AnRX0E6l5GCJhHaC1ZOBsLD2PD24fFseOhWuCZmQaU7PorNKmfraNi3ZsjD3WAQ0lo29DvAGBqdVnTlt8k+nR2L9EQjjjvYCZN4QdKLCdTYq+TEggZxj0hjTytYbbGNHqnnx0ylTR0AttVXaJJKXph6DlsHhG3InE58WJZ2e5Y18oZrwwoel+ICr7JGY/lAL3Y8lnQJLoe/XKg1Q8KVtbrZ728jI36hi8+DcIFSsHSvL/hkpNtS6drcZeqXubzQghe6vZHQ8YdRfcFHv0Br/TnDvW7ndw/nbdgduzsfJ7IhM3QEMEyoJJM3fdEFQNROY+9Qldkj1cOocTnfhr6IQ6RF5o3rt3gRGi9v3GFb2xRMkzOebsC2cTisY/QUK8o3bzhK/uV3ttrsjgw/1TzIZDZxEKKkfjM/aY0NB8APu6Omyc1XUwafg8LezGM5MTj62BDoxVEYW6NETvvumCB9MG3Ev0NN86mMyr+CFgUooT2fYZMcD+AmVDph92x+4D8F6e9JgR9Fa3xggYBhOWcCoO5kd8fD/OYuwZ9n+w1lUVaSSWfFPkay2Nmkoi4ewELAiqog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(4143699003)(3023799007)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRtNnY3MUhCaU5JSlRNeFJhWEtNcEVIdGNjRmhrenJJMmc1c0NVODhzL0JR?=
 =?utf-8?B?MmlwNXBzb2pWVWZDZFJaWFZTdUpxUXVDNndZQjVzUUgxVFg3SkpMTng3TFhv?=
 =?utf-8?B?WmE3bGx5MmJ4RjZqT0dJeUpFY1hGakJKME8rVlhpbGRnMVhaR3lRR3lNbDdZ?=
 =?utf-8?B?WWRnQ2JONFVZb2ordkxPUjZZcU11QmNiS3J5S1hSVVVCK1F4d01wWHRuMDBv?=
 =?utf-8?B?ZmJBUU5CNlJqWFlvRUJpbGN0cWYwZmxiODJ1UGdvYzNTdk8yQzFvOXVDMVBP?=
 =?utf-8?B?eXc1RmMwdjVVQWNjVVp3Ny9wUHU5Y25uYXZMVXU1MWdLZjc5ZzJMMVhTK09X?=
 =?utf-8?B?azdnMStVSEZxOElpcmU1UXpYZDh4aXc4bHpTcjJLU3g2Ny9WYnFrc242VUtq?=
 =?utf-8?B?bEdhRDMzMXRIOWJtOEdZQUoxNnFFYk1JMGdHNWhKakhVd3ViY0dIQXBxK3h3?=
 =?utf-8?B?WDVUVmFoSXpUOHM4U1ErMCt1Rk1mYkRtOUdOZFYrRnp3YlFabEdudjU1UXFV?=
 =?utf-8?B?a0YvQmgyZHdmenpSVlhIQlJzM2VJeG1PbGdZUVBueTc3S2Y4aTVCY09wWHAz?=
 =?utf-8?B?LzQzOTgwdmFuQVkvNUdYTXZ6RGFSVmkweTN2aXQ4dXNzanNiREQ1ZEZUNEhU?=
 =?utf-8?B?NmI4NUJIQzVLQTJVbEJxNzJ6Tmw4empsOTM1MGN2SEpaMmFiVFhZNnluSW1T?=
 =?utf-8?B?TlpLTnY2MkJ3VVhQd0luTkU1dU1vQ3hJaGdFT0pMc1J3cVF6Q0NGV09ESWxo?=
 =?utf-8?B?TGF5V1dFM0NwNjNLem5GSUJCcUxaR2Fqa3Ridnl4SGRWTlRMTnJIRmZrQWxU?=
 =?utf-8?B?L25mYU8ycUFlUUVZZTY2WnJ6ci9mQllOT1k3TEdadjlpREJHVmRZLzdkdUMz?=
 =?utf-8?B?aXdyRlB2VFJtSHNrWHdKUkNOUHI5aU9vSUlmWkxWNEU2UkxvaE0rSGFMMkRv?=
 =?utf-8?B?QlpPSXRNNHVHSHd1eE5XM1pBS2UwVmdhWnFjeERoTVZYeDRaWjBrZ2NmTmNy?=
 =?utf-8?B?aUI0OTFjc3pNRUhqcFFaem9GT0xCb0ZWZmdrLzEvaFFjOG5vYmdPM3htTTk5?=
 =?utf-8?B?ckVFNzJSNGI2TlpLUHpkSDNBY09hWW1IclZUWmdFMHVVdHFHSjhyN1BUL241?=
 =?utf-8?B?V3pseXhwdDZXdmtPODF6MUl1V1VISTNyNUNmR2R2dm43MU9oaTdRSjl3ZFo4?=
 =?utf-8?B?SXJ2TGhGOUZQK1hsbFNXck0rQUpKN1dHbjZkVndiYUVPUG9zM2t3aXd6Vk0x?=
 =?utf-8?B?N0ZTeDhQcTJrWEJzMjB6YTR4TitnRlR2SGI3aExMcWJYQU96eUJLM2VxZUVW?=
 =?utf-8?B?MURmaytUNW9mZUZ1WDUzNitHSy9PR2FiREFDRnU1Vi85MWJYSDdMMm56K04w?=
 =?utf-8?B?R1dQYUhjV0VYeGp1VzZSN1FaU2hoL0VpeHpobVRJMGZDVnprTGkvVFNNM09s?=
 =?utf-8?B?RForOURrN0pmaFZuMkJWSS96NzI4ZGsxbEdaWGN5MXhGb0FSQTJjeGc4MlEx?=
 =?utf-8?B?SnRnVVpkOUx0a0M5RDFOdERLM2x5ZlR2Q0JDbnhYLytnR1IwVUNPUmxzc2py?=
 =?utf-8?B?RzAwVWhNcFAwNFFHQzJhVnlybnNWcE81bXlhYlFHbjZ4WnJsdzZnOWpMK3ZC?=
 =?utf-8?B?OEU2S2RDVnVidVdTQlNvKytrTzIxVVhiNHdCNUczZGNnNjlpZXQxZ0tNOGd2?=
 =?utf-8?B?OWZITVNRdmdsQW94MlFiRnNEQTJEUm9EWmdHdkxJZkFveVBLTkpUS1RENkgx?=
 =?utf-8?B?elF0eGErcUVTMmtuenovOXlrSExEcFQ3M3JOc2JWZFgxN1RVcVo3eTN2RDIx?=
 =?utf-8?B?ZFl6cUg5ZExNR09Ta0FwcWQ2VjVyeXVDNkU2N0pCN1ovWHFPVmVwSjljTnMz?=
 =?utf-8?B?TEF3OCt0dmtJZ053czhsZHdGUWVSdDR6UFIrSUF1OEJCbG9vcFJlZ2ppMnZ0?=
 =?utf-8?B?eGo5SDhyQ0JPZmRRR1dmYWIyUS9uL3dLZFpzTXNnM200WTFaNld3bUx4NFMv?=
 =?utf-8?B?ZE1ZaW5DRko2VmRGVTErbS8xeHJ1NHJzbVpKaXdveC9IcTZscnpEL042b1FV?=
 =?utf-8?B?dHRZMmNJVzAzY0Zhazdsbi9uVlNNQ1FlaTBJLzk2Z2VNZ3VkTEk1TDRYWUFq?=
 =?utf-8?B?eHNXMDdpaDN2dm5yZlFHdDVSbG5Ma2owUGNmcmlpWVZHbUFKNUVmdGp5Smth?=
 =?utf-8?B?Q0pqeC9lNVEwb2h6S01PRzA5Z2llN1BJMklVVjlNTVZ5SncyRWZMR21zY29Q?=
 =?utf-8?B?QzdScnVab251bC9XNG9VUXpKWGNGcWRaZHBHcWFiK1hhMjRueE0xOVNleFFO?=
 =?utf-8?Q?RqMweHuHlGroWLzlU8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873e7c3b-f638-4263-4ba2-08dedcde76f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:48:37.2248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L43W79JTYUe5HWBa5OlNyAtJtY2oYZL+A4x9cDRy4bmZ2p8jvDeB1B1vVQcya+Gs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506
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

Hi Chong,

On 7/8/26 12:25, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Christian.
> 
> The code " early_full_gpu_access = (adev->virt.req_init_data_ver == 0);" is related to the ASIC type, not the host platform:
> 
> 
> adev->virt.req_init_data_ver is initialized by amdgpu_virt_request_init_data().
> 
> Some legacy ASICs, such as CHIP_VEGA20 and CHIP_ALDEBARAN, do not send amdgpu_virt_request_init_data() to the host.
> 
> For those ASICs, the host dumps the early init data only after the guest requests full GPU access.
> Therefore, those ASICs still need to request full GPU access before the guest driver can read the early init data from the VF FB.

No, exactly that is not the case as far as I can see. See the commit I mentioned below.

According to that starting from SIENNA_CICHLID the full GPU access is mandatory for reading the discovery table.

So I absolutely clearly have to reject your patch here.

As far as I can see this is a hack for ESXi and that is not going to fly.

Regards,
Christian.

> 
> 
> 
>         static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
>         {
>                 ...
>                 case CHIP_VEGA20:
>                 case CHIP_ARCTURUS:
>                 case CHIP_ALDEBARAN:
>                         soc15_set_virt_ops(adev);
>                         break;
>                 case CHIP_NAVI10:
>                 case CHIP_NAVI12:
>                 case CHIP_SIENNA_CICHLID:
>                 case CHIP_IP_DISCOVERY:
>                         nv_set_virt_ops(adev);
>                         /* try send GPU_INIT_DATA request to host */
>                         amdgpu_virt_request_init_data(adev);
>                         break;
>                 ...
>         }
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, July 8, 2026 6:24 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
> 
> On 7/8/26 12:03, Lazar, Lijo wrote:
>>
>>
>> On 08-Jul-26 3:23 PM, Christian König wrote:
>>> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>>>> AMD General
>>>>
>>>> Hi, Christian.
>>>>
>>>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>>>
>>>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>>>
>>>> Distinguishing the host platform was a mistake, and I have explained
>>>> the situation at the end of the patch email.
>>>>
>>>> I have pasted the content below:
>>>>
>>>>          Hi, Christian and Lijo.
>>>>
>>>>          Sorry, I made a mistake.
>>>>          Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>>>
>>>>          I borrowed an ESXi server and tested this patch there.
>>>>          The amdgpu driver works normally.
>>>>
>>>>          I rewrote the background. Is anything still unclear?
>>>
>>> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
>>>
>>> As far as I can see that is Hypervisor specific and a NO-GO.
>>>
>>
>> I think this should be seen as a policy set by host driver on when a guest operation is allowed. Host driver could do it based on other conditions also, not specific to hypervisor environment.
> 
> No, this was intentionally changed in 2020 because of a new feature. See this commit here:
> 
> commit 00a979f3d69e0c275e88c741b854dbe0d5238ae0
> Author: Wenhui Sheng <Wenhui.Sheng@amd.com>
> Date:   Tue Jun 23 13:43:49 2020 +0800
> 
>     drm/amdgpu: invoke req full access early enough
> 
>     From SIENNA_CICHLID, HW introduce a new protection
>     feature which can control the FB, doorbell and MMIO
>     write access for VF, so guest driver should request
>     full access before ip discovery, or we couldn't access
>     ip discovery data in FB.
> 
>     Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
>     Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> So as far as I can see this change here will break older hypervisor versions and that is absolutely clear reason to NAK it.
> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>> Chong.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, July 8, 2026 5:05 PM
>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>> <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Cursor
>>>> <cursoragent@cursor.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>> progress in sriov mode
>>>>
>>>> On 7/8/26 10:25, chong li wrote:
>>>>> v2:
>>>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>>>
>>>>> v1:
>>>>> Move the initialization of non-GPU resources out of the full GPU
>>>>> access region during AMDGPU device initialization.
>>>>>
>>>>> Background:
>>>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>>>> VF_FB_EN and places early initialization data, such as IP
>>>>> discovery, VBIOS, and PF-VF exchange data, in the VF FB. The guest
>>>>> should then be able to read this data before requesting full GPU access.
>>>>>
>>>>> Before this patch, the VF still requested full GPU access in
>>>>> amdgpu_device_ip_early_init(). At that point TTM is not initialized
>>>>> yet, so the normal VRAM aperture mapping is unavailable and the
>>>>> guest falls back to MM_INDEX/MM_DATA register access. That register
>>>>> path requires full GPU access.
>>>>>
>>>>> Use the BAR0 framebuffer read path,
>>>>> amdgpu_device_read_fb_via_bar0(), for the early init-data copy
>>>>> instead of MM_INDEX/MM_DATA. This lets the driver delay the full
>>>>> GPU access request until after the early init data has been copied.
>>>>
>>>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>>>
>>>> So once more: We can't adjust the driver to the hypervisor!
>>>>
>>>> Either this works on all hypervisors or I have to reject the change.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>> +++++++++++++++++----
>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>>>   2 files changed, 19 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 610d82b79de3..ac66796e8634 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -38,6 +38,10 @@
>>>>>   #include <linux/apple-gmux.h>
>>>>>   #include <linux/nospec.h>
>>>>>
>>>>> +#ifdef CONFIG_X86
>>>>> +#include <asm/hypervisor.h>
>>>>> +#endif
>>>>> +
>>>>>   #include <drm/drm_atomic_helper.h>
>>>>>   #include <drm/drm_client_event.h>
>>>>>   #include <drm/drm_crtc_helper.h>
>>>>> @@ -1987,16 +1991,19 @@ static int
>>>>> amdgpu_device_ip_early_init(struct
>>>>> amdgpu_device *adev)  {
>>>>>        struct amdgpu_ip_block *ip_block;
>>>>>        struct pci_dev *parent;
>>>>> -     bool total, skip_bios;
>>>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>>>        uint32_t bios_flags;
>>>>>        int i, r;
>>>>>
>>>>>        amdgpu_device_enable_virtual_display(adev);
>>>>>
>>>>>        if (amdgpu_sriov_vf(adev)) {
>>>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>> -             if (r)
>>>>> -                     return r;
>>>>> +             early_full_gpu_access = (adev->virt.req_init_data_ver
>>>>> +== 0);
>>>>> +             if (early_full_gpu_access) {
>>>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>>>> +                     if (r)
>>>>> +                             return r;
>>>>> +             }
>>>>>
>>>>>                r = amdgpu_virt_init_critical_region(adev);
>>>>>                if (r)
>>>>> @@ -2159,6 +2166,12 @@ static int
>>>>> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>>>        if (!total)
>>>>>                return -ENODEV;
>>>>>
>>>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>> +             if (r)
>>>>> +                     return r;
>>>>> +     }
>>>>> +
>>>>>        if (adev->gmc.xgmi.supported)
>>>>>                amdgpu_xgmi_early_init(adev);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>> index 9a40107a0869..340703d89d6b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct
>>>>> amdgpu_device *adev,
>>>>>        } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>>>                /* Dummy REQ_GPU_INIT_DATA handling */
>>>>>                r = xgpu_ai_poll_msg(adev,
>>>>> IDH_REQ_GPU_INIT_DATA_READY);
>>>>> -             /* version set to 0 since dummy */
>>>>> -             adev->virt.req_init_data_ver = 0;
>>>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>>>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>>>        }
>>>>>
>>>>>        return 0;
>>>>
>>>
>>
> 

