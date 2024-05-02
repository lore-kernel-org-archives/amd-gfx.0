Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF1C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 05:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E2710E78A;
	Thu,  2 May 2024 05:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKEOEcCj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0677C10E78A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 05:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S26bCpje/UvzLAX+OV+wQIb2MEIGFwTsah7RbNSgkh9gczL0t0DIuBLc9Ac1moZ4IkNH2Ltjm9bpLWDEINr5qsH59v+EJXT25fd+8yqwfUkqFl6RYGTWbyj+Roz8UsSSg+XFZxIZwi9EyScl3c9TCJoQk6gT0hHIQSZLrmUIFe3vbDOZzbyUAnkkBl0NmTcuxKd+ZrA0K+Cf+YhxBOLnSH32sjJqAiXQdeCSBgEvXjfGRU+ruuNCsailHb+X8Y2LsDIM3oSqupTZKzqOzOr5UJ3/vXP16i9zAtAXhGHejMzdoxvBAjTC0grvCbyUhsGwdNf/sYVd+ngikmBYKvNLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBVQHJvYM7S3oVKYO1888MWit9gHg/L3i9LwMN1TH4M=;
 b=eilOIAf/Wb1xIm4FAU2X3DRqgaYJw8BvHkpAoepgux8vYLfMhXG9qpTzjwXr3AAjEilYHvplTtdEQq7ZYOvvS4zYFEOzGK9DMIpDljK7DxEfY5hMsmwWGjAH1GcN/vlcM78AnfYHeeIXde6wlSkldSuHDPpmnuP+srKEkxAZUIM8xkjcUV8uvkpFrZ/GIydHwiJNfxpZJ4dHjPsDdbXmPZfczWm8xuGx3g/pUtglnZjoCurDnMFUNrrMSV7Bj3tra40nd2478bpbI1pX9XMfihopeeYgv2fbgHK9xUzYtN5UtxYXf3dA+6fcQGiJmWN+fBjKLuu0/lx4SvscMA0PfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBVQHJvYM7S3oVKYO1888MWit9gHg/L3i9LwMN1TH4M=;
 b=GKEOEcCjs97DGjU+JexAz41uTNNHQ31lARixP3cnWbsPqzFu81OrD3MyVRbWPbouGaNYZW31m0ngeyGQruMbBoPgnrSkUiP/T4w+GvSFlGd8PxjlBt51rDJ+KpCezrvhbQdI0fGBARSTn1Aj6infxL6UcdO24x7PTABDZHRuWdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 05:23:16 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 05:23:16 +0000
Message-ID: <39458665-6f59-305c-5b47-70eb1072213c@amd.com>
Date: Thu, 2 May 2024 07:23:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 01/14] drm/amdgpu: UAPI for user queue management
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-2-shashank.sharma@amd.com>
 <CADnq5_ML3xvC1-vP7AO5byS8oxq8_vayrsoWVghUhzqeCabUxQ@mail.gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_ML3xvC1-vP7AO5byS8oxq8_vayrsoWVghUhzqeCabUxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: a82ca10f-65f3-489f-c0b2-08dc6a67f848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWc2ZmdTL0NjK05RdXc0ZFRTb2hla2JWNDF4dE9aaHNFcklld1BLb0dqajhJ?=
 =?utf-8?B?QW1IM01xOXlIY3ZwS3dCdzRJcjZsZnlSL2FuN2dsUDFWSVU3YlVSQk5xcXQ5?=
 =?utf-8?B?Vlg5Vmd0K1RhTENPQ3dOS0ZVdFRlY20vWVFlcWdISytNNkYyT3NWdXNnaGVJ?=
 =?utf-8?B?R3R2V2owcmt2Wk9Bd2FCZEtuc1FzeHJueG55R3kwbFNjZmdMV3ZWand6cjNS?=
 =?utf-8?B?VVlXNnhFUHc4RXB6TkdsOHFMbVoxdnJ5YmFVOHh1a2ZSWWxEOEVjbzU0aVU3?=
 =?utf-8?B?cWN3SVNsUUpGTEoxNHh6SUJCN2YxZDEvSE5CTnNsL2E3d2J0Vm1SRlpUbUJY?=
 =?utf-8?B?OG5LTC93aGpPTDdxaVJpbzRBejcxVm1MbGV5aWNEUjRXQTNrbndnWkt4ZE82?=
 =?utf-8?B?cUJKTzFFT2l3TGdCU0ZHZm0rd3d5aWp6Ums2ZDY0clQ3RHJjZkRuY1c1LzBs?=
 =?utf-8?B?VFdFSU5BcVljMHNrdlEzTXcvMHNxckVWbDlrbTBLYk93RkdLTzM0WW8xVTli?=
 =?utf-8?B?S0VhNjMvOUZBM20zRmtvTFN3RXVZa1JYOTIvVzFFRXJPcU1mL0xvR1RJU3Vk?=
 =?utf-8?B?VW45eVp3QUYwNDFuT09YazFnUnBpWEJQRlZGVEZGL1BvV08raDFXWW4yY3BN?=
 =?utf-8?B?Tytna1hDeFd3dVI3S2NjN2svR0c2RVIzQVlqRlNRRjVIVTJGcEUrdFNhY0tl?=
 =?utf-8?B?V0xNaklWemF3ZWJMKzBJZ0ppTURrTkpaQklCVHFHTG45eXMyNjhXbE5SVHM2?=
 =?utf-8?B?d0I1MVkzM21jS0s4Skw1TlNrTVpRMC9xcVRqM1RaWkR4c0tGQnRDTzBMdkg0?=
 =?utf-8?B?YUlNVVBEb3JHUTJ0YmxkSGZaZzNXQVRBYWpKVzEyK0NJVGlhRzE5Wnk0MGNG?=
 =?utf-8?B?RmpsVENGUkpJQXVrSXJXN2djOWFGZzUxdUF2Qm1PeDI2SmxGZWxoZ2FPdkk4?=
 =?utf-8?B?eGg3bC9kNHpRSUtzelRoUnh3dUp4Ui9NazZjU2ZwK1FsckNpR29FT3U2bEM2?=
 =?utf-8?B?TWxEa3dBL1E0RjVUQzA1dFpIanEvREdzUnhQbjNpYnBERzdxVzkyQUlzZjZ3?=
 =?utf-8?B?S1RjR2UwRkhIRjNBMGxIWC9nYmNvbUYwaHU2WE5yRGRUSzgxMXRTZHE2V1R4?=
 =?utf-8?B?K1BUc1pVSXozQmhTTHBHS0w4VDNKOEErUCtKWktMdHVIL0dMMjg2YmJrSktO?=
 =?utf-8?B?VWlrQ2M5V3dCdVlzWDhwdDBCZHRTWFlldEs4NlN0VGhvdnlvQldoRU9TWUM1?=
 =?utf-8?B?bEVUL0g3M0NmRFZqenNFaDkyQW55L0lPUFQzNVZzNm53N0w5cGNhRldCVERU?=
 =?utf-8?B?c29qV1BFTG1JREI4ZGN3OHBJM1h1ZE50b05GRUNNUU4yT1dmQkJnbnk0dVJw?=
 =?utf-8?B?ZkNiZ2p1RVRydk1XNks2cVVFVkx1NVJka2VGeExtTTVxNDR6TVIrMkJaODVa?=
 =?utf-8?B?Qk1RakFTV3hIYWFydFg4NDR1a2hzUmw1a3ZvbW5WQkF2eUM0Sm1pZ1h3MXYx?=
 =?utf-8?B?VTJQdjBHOWRvbHUxUitFUk5OM0hMZm10d2hkNDUyK2NSQXQwMUVnd2VITjZm?=
 =?utf-8?B?aWtRcmNJSG0vL1RsUHlMeXU4aDVvTlJpMHZKRnY0QWd4bUF1eTAxbCtWaU12?=
 =?utf-8?B?TmtuSkNIeXd1cG9lUkkzbUdDU1lEUzVrTTZVRndLeTRIeEI4MXNGM2xUZUpL?=
 =?utf-8?B?WFBSTmIrMHRHRlM5OXZjd2NiTGNlbEI4N1d1WXNybmxORWJmVTNIQXp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDE5SzdzNmMxK2ROTE50MGl3L1gyV0F2SWlpZ1ozSVFkZFNoSWN2andGa0c4?=
 =?utf-8?B?c01JTm0rQUN4Y1F0c0tQaEFxREN2czBCcWU5Z3RHbEM0TXo0MUo2eWFtSmgy?=
 =?utf-8?B?VHRBVndUeW9JaWFlTUV5QTU2TGZ3aEh2eFJheGFDUHh0WFZ4QUFicVJIVGZ3?=
 =?utf-8?B?QlB4Y0lkYmRYTVBmdGhrTTdFSlhKc3VZckoyNWx6UmVsNDRoL0k4WWhCUXVQ?=
 =?utf-8?B?ZXBOL1VpZWMyL2tGakVpa0EvcFhWZ2ZIR3ppQytJWUtjLy8wNlRyZldBdzFP?=
 =?utf-8?B?SklUQ2hSakFUUm1XN1FsQnJ0NklJY2NUUDh5UWFxSnh6dm1FVkhYTW14YldJ?=
 =?utf-8?B?Ri9NU1dnMXdiTTd0eUdvV0VSSkw1Ny9GQkNrOGtzUzIzV3ZYNk5hRkt5Tk91?=
 =?utf-8?B?ZHo5K0o2TzhhdU4zWXd4am1UaGxIc3doVCs0Y1FBVXlWaE9wZk40UVNlOGdD?=
 =?utf-8?B?cTd2amdpcHliOGQ5b2dvVVNUVFFoMW9mVHlsQjhpVEN2VUlab1RkcGFFaXhT?=
 =?utf-8?B?akduMmd5ZGUyenkvVUNTaFZqcndQcVkvRVNENHJyY2svODdoRDJ1cTl5THNC?=
 =?utf-8?B?ZWgzYzVqa0dtdHJjSDdBK3d4T3NIbHRoYTJqUXR3NUJmTmRWNXh1TVI5YXAr?=
 =?utf-8?B?dGVGUDI2OFBKOUFMbkRwNnA3YXZnNFhJaW1IUHFPVERVWVFCKzVLVTcvbXR2?=
 =?utf-8?B?bUd3Q3h1R0RwalVJZUhsRHVYTm5TdVprd1N3d1hnSU10OXY4bFRrVGJMZWZE?=
 =?utf-8?B?eS96dHZtdXlFSFNZOVNJOE1lR2kxVFhRMDNSNEdwV3dnUmlSV29zcmhTOGZt?=
 =?utf-8?B?MjZLS0EwTjcvTFQ0aUJuY0Q4eE44MlNubVpvbkhNVW92a2Z4ZmV0cDZUSGRr?=
 =?utf-8?B?ejhvS0hNbzJiZTVkSllHdWlZU0hXSGVMWHlBM1RxUEFKOGxvZU5kdFRqU29I?=
 =?utf-8?B?MmRWSlBVYitTUGFlWlpMMEpRazIxS2xiUVBKUlNkSDdndVY3dkdWZU5iWFJi?=
 =?utf-8?B?aEZMVi91QUsrWkE4OHRBRGJxeHhzSk5hS3BxcFhMam1OY0EwQ0RKMEFweWtX?=
 =?utf-8?B?TG1DWmtCc2VGSjhiaEZ4L2c1bWlJU1g0VFBERWhteHdRUnpvMmpHL0ZRM1lT?=
 =?utf-8?B?aENrOEh3Q2JkTUFiNzhKQ1oyQytYZ2p6QzBIc1FyRUxJVEJrWWlFcGdidm5B?=
 =?utf-8?B?aUtxZkJtR0lFYmpIYkExMTVmVWtReDhrUzZDTmJCcWY5UmFrbWJnazFyRnhl?=
 =?utf-8?B?RHVGMGt6YzRIbkNNYlpIMHUzTmZpUkZhcGlRQnd1Rm5SRXdsRVozbXc2NS9E?=
 =?utf-8?B?VFQwek5JOFhCRXY1K1NjR2tKZWZPNWdCWUZQMWsxckFaRDlKSFF6a1FGVDRl?=
 =?utf-8?B?ZlZBclZBdnY1eHd0T1R5TnVSdUxEYjZBWnlzN2ZkM0NYang4Qnd1d2Faem1x?=
 =?utf-8?B?dWNBUG43STUrTjVndUJMRFJrc1d3b2pPVXBTd2htVk13Z0U3RDVKRlh2UU5W?=
 =?utf-8?B?RTlXNVlDZ3ZhbCtJU1JkK3hzZFB3K1J6SVVCWXUxT2g0UEQ5V1FkV0VCWDIv?=
 =?utf-8?B?b3pHK1NjOHo4Wkw0cW1ZR3F6M2FxNExjN2I0emJXcjRHNHdtbTVIdGN0dHFR?=
 =?utf-8?B?a2R6QWhGZUN0eU4wcXNaK0ZxOG1PNStSa2lTM0hzRmIzNkVWTy9sbHpOWk1v?=
 =?utf-8?B?Vi9oYTJBWlBDWm1RTXJPYzVzSEpWZnNMaHJQQ2hkYlY5QlFoZ1R1b2pRRkw3?=
 =?utf-8?B?RUZ3cHpmanA3aTJvTVcvbzF0djY5UUV1SkZnS1EwY253UTFTVDhNNjdpNmE2?=
 =?utf-8?B?Y2JPWURYMzNVNy94V051VjNmUXdEdFlzUWVSVGhKS1l5WjZtdmdkdmlMdmYy?=
 =?utf-8?B?TkdHaS9lV0ZYMldocFREUGxiZ3J2TGVsaFpNb0pXWnlCZ1BSL0pRb3ovK2ZN?=
 =?utf-8?B?eXlUOFBoY2FoZHFIeVE0aWk2MFIrL1BEVW1PYkw3bHhiaWdmcnY5SnJaQzg4?=
 =?utf-8?B?M0srSm54OHE2UUNxOWxQUnVhWmJSajlzSFdIRVBqYjQrNmNZcGpBTVZ2cllO?=
 =?utf-8?B?NjhKQ3BCYTdJdXZQV0NoQVhZUG5JcUlLTzhXRVRVcDNmNXJ5TFhRVFF3Q01Z?=
 =?utf-8?Q?DDke7DASrQ34sMtuLy7daqd+o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82ca10f-65f3-489f-c0b2-08dc6a67f848
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:23:16.2141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiwUacfSqN1N3VakWBouy1pkt55IXlrC+bxkg91wG0G6c6wwycRgn22IXAXYuOHDLkY5Pi7cNT2Mz3AfxAC0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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

Hey Alex,

On 01/05/2024 22:39, Alex Deucher wrote:
> On Fri, Apr 26, 2024 at 10:07 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch intorduces new UAPI/IOCTL for usermode graphics
>> queue. The userspace app will fill this structure and request
>> the graphics driver to add a graphics work queue for it. The
>> output of this UAPI is a queue id.
>>
>> This UAPI maps the queue into GPU, so the graphics app can start
>> submitting work to the queue as soon as the call returns.
>>
>> V2: Addressed review comments from Alex and Christian
>>      - Make the doorbell offset's comment clearer
>>      - Change the output parameter name to queue_id
>>
>> V3: Integration with doorbell manager
>>
>> V4:
>>      - Updated the UAPI doc (Pierre-Eric)
>>      - Created a Union for engine specific MQDs (Alex)
>>      - Added Christian's R-B
>> V5:
>>      - Add variables for GDS and CSA in MQD structure (Alex)
>>      - Make MQD data a ptr-size pair instead of union (Alex)
>>
>> V9:
>>     - renamed struct drm_amdgpu_userq_mqd_gfx_v11 to struct
>>       drm_amdgpu_userq_mqd as its being used for SDMA and
>>       compute queues as well
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 110 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 96e32dafd4f0..22f56a30f7cb 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -54,6 +54,7 @@ extern "C" {
>>   #define DRM_AMDGPU_VM                  0x13
>>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>   #define DRM_AMDGPU_SCHED               0x15
>> +#define DRM_AMDGPU_USERQ               0x16
>>
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -71,6 +72,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>   #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>
>>   /**
>>    * DOC: memory domains
>> @@ -317,6 +319,114 @@ union drm_amdgpu_ctx {
>>          union drm_amdgpu_ctx_out out;
>>   };
>>
>> +/* user queue IOCTL */
>> +#define AMDGPU_USERQ_OP_CREATE 1
>> +#define AMDGPU_USERQ_OP_FREE   2
>> +
>> +/* Flag to indicate secure buffer related workload, unused for now */
>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>> +/* Flag to indicate AQL workload, unused for now */
>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>> +
>> +/*
>> + * MQD (memory queue descriptor) is a set of parameters which allow
>> + * the GPU to uniquely define and identify a usermode queue. This
>> + * structure defines the MQD for GFX-V11 IP ver 0.
>> + */
>> +struct drm_amdgpu_userq_mqd {
> Maybe rename this to drm_amdgpu_gfx_userq_mqd since it's gfx specific.
> Then we can add different MQDs for SDMA, compute, etc. as they have
> different metadata.  E.g., the shadow and CSA are gfx only.


Actually this was named drm_amdgpu_userq_mqd_gfx_v11_0 until the last 
patchset, but then I realized that apart from the objects (gds/shadow 
va) nothing is gfx specific, its actually required for every userqueue 
IP which is MES based, so I thought it would be an overkill to create 
multiple structures for almost the same data. If you feel strong about 
this, I can change it again.

- Shashank

> Alex
>
>
>> +       /**
>> +        * @queue_va: Virtual address of the GPU memory which holds the queue
>> +        * object. The queue holds the workload packets.
>> +        */
>> +       __u64   queue_va;
>> +       /**
>> +        * @queue_size: Size of the queue in bytes, this needs to be 256-byte
>> +        * aligned.
>> +        */
>> +       __u64   queue_size;
>> +       /**
>> +        * @rptr_va : Virtual address of the GPU memory which holds the ring RPTR.
>> +        * This object must be at least 8 byte in size and aligned to 8-byte offset.
>> +        */
>> +       __u64   rptr_va;
>> +       /**
>> +        * @wptr_va : Virtual address of the GPU memory which holds the ring WPTR.
>> +        * This object must be at least 8 byte in size and aligned to 8-byte offset.
>> +        *
>> +        * Queue, RPTR and WPTR can come from the same object, as long as the size
>> +        * and alignment related requirements are met.
>> +        */
>> +       __u64   wptr_va;
>> +       /**
>> +        * @shadow_va: Virtual address of the GPU memory to hold the shadow buffer.
>> +        * This must be a from a separate GPU object, and must be at least 4-page
>> +        * sized.
>> +        */
>> +       __u64   shadow_va;
>> +       /**
>> +        * @gds_va: Virtual address of the GPU memory to hold the GDS buffer.
>> +        * This must be a from a separate GPU object, and must be at least 1-page
>> +        * sized.
>> +        */
>> +       __u64   gds_va;
>> +       /**
>> +        * @csa_va: Virtual address of the GPU memory to hold the CSA buffer.
>> +        * This must be a from a separate GPU object, and must be at least 1-page
>> +        * sized.
>> +        */
>> +       __u64   csa_va;
>> +};
>> +
>> +struct drm_amdgpu_userq_in {
>> +       /** AMDGPU_USERQ_OP_* */
>> +       __u32   op;
>> +       /** Queue handle for USERQ_OP_FREE */
>> +       __u32   queue_id;
>> +       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
>> +       __u32   ip_type;
>> +       /**
>> +        * @flags: flags to indicate special function for queue like secure
>> +        * buffer (TMZ). Unused for now.
>> +        */
>> +       __u32   flags;
>> +       /**
>> +        * @doorbell_handle: the handle of doorbell GEM object
>> +        * associated to this client.
>> +        */
>> +       __u32   doorbell_handle;
>> +       /**
>> +        * @doorbell_offset: 32-bit offset of the doorbell in the doorbell bo.
>> +        * Kernel will generate absolute doorbell offset using doorbell_handle
>> +        * and doorbell_offset in the doorbell bo.
>> +        */
>> +       __u32   doorbell_offset;
>> +       /**
>> +        * @mqd: Queue descriptor for USERQ_OP_CREATE
>> +        * MQD data can be of different size for different GPU IP/engine and
>> +        * their respective versions/revisions, so this points to a __u64 *
>> +        * which holds MQD of this usermode queue.
>> +        */
>> +       __u64 mqd;
>> +       /**
>> +        * @size: size of MQD data in bytes, it must match the MQD structure
>> +        * size of the respective engine/revision defined in UAPI for ex, for
>> +        * gfx_v11 workloads, size = sizeof(drm_amdgpu_userq_mqd_gfx_v11).
>> +        */
>> +       __u64 mqd_size;
>> +};
>> +
>> +struct drm_amdgpu_userq_out {
>> +       /** Queue handle */
>> +       __u32   queue_id;
>> +       /** Flags */
>> +       __u32   flags;
>> +};
>> +
>> +union drm_amdgpu_userq {
>> +       struct drm_amdgpu_userq_in in;
>> +       struct drm_amdgpu_userq_out out;
>> +};
>> +
>>   /* vm ioctl */
>>   #define AMDGPU_VM_OP_RESERVE_VMID      1
>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>> --
>> 2.43.2
>>
