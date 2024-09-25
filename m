Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE72CCCF9ED
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 19:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D02610E12F;
	Wed, 25 Sep 2024 19:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y+liJKWx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4CC10E12F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 19:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwFGJgmNoheMjhG7Q0jTCxk8TzQDBhh1jGtWS+uQktXz8JPmuAWC1pEC5zFllrI/n8JCofwDq/m1fESMos+MI/jwohYKiyQI8QKL23LTPg1GFZoZJzBhqAKl9I0UBH+NGm+kwNOr5YPzlkv73JZO/DlEVQM79hSqc2h6mCVgiaH4vNnStogjvB1i0eHrL7ek6RmOWWQHBo7n5w3WW8RQlZdkQdoxv6BVWhCfO/Zp7+bVkRbYSRmT0CbbXtDnftGsq/z3ikxGCdAfhxZzzUV6IgRjG2p2aBqVI1GinDJfL4zmOY9h876usxBVac7zaeuyepsMrIdzV3lYsGh4Rh1fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcCTKP5+7kEWr1lluHX5qVSEUfhewP1V9TOfavQ8CBY=;
 b=BJDI2toTp0GfWNZcR/PhINySw0Gp3Aa2mhoMR8HcmzmfxB14fcYmfE2pJ/UYxefx+AMPytU8H6c5h/EJM8fFm2IKXKZ3HzqymLl/McyKYybQaQ4HSbcQnB0HwUob+Xi73czvl5w7q6yTHXY3x5rSXjed2DvjoroMO0FrXAaoAVw0y+rSgn7qnkZvNj5kDktrL5LO+ipHlYqGEQn1RJCz30D8o5zTZt2QRIDFmVpTxcBIbK7Gbz09nIgyjG+D3gKHy1AsM/y3YtIwm27B7kqZK2yvuosweQqbQh/3lluXMhUWofYpPPcSqd4hWv4llnGsd+wmb3ZH7FK2X593dRy4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcCTKP5+7kEWr1lluHX5qVSEUfhewP1V9TOfavQ8CBY=;
 b=y+liJKWx21eAFfII/fYAC6NwqS+Cj/tCZigPgZ8NBPfS77woPc07tD82EBZWXs6xZDt9d5qn4CkGWkjWGLDweOcDxGyHb5SHd0p8Xm+NVmdzf84QagQLCrBrUdxHZQlt7U5VjrOy3jhtrLXFL5e4GpaZZP4hZjZT6DIo48qU7iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 19:45:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 19:45:35 +0000
Message-ID: <080840a3-0660-434a-85de-66949fd0c878@amd.com>
Date: Wed, 25 Sep 2024 15:45:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in
 cleaner shader code
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240904095120.1813377-1-srinivasan.shanmugam@amd.com>
 <BL1PR12MB51440CA6B867F66075BD50ADF79C2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <b775c53c-9367-4364-8a16-f805ba406ac0@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <b775c53c-9367-4364-8a16-f805ba406ac0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2283db93-5941-45f8-93d9-08dcdd9a9fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bld4cjFDZGgwMEVnU1BhYWt0cmlZWTI0RGtkc0NsRldxL3Z5N3JCUXpWdERC?=
 =?utf-8?B?RGFYdmw3L2hGei84b3NSR3p0aGNraFc4YzlZeUxsQTVwUnZJaE5aRllvd2d3?=
 =?utf-8?B?bjRkZXhuL09lUFMzdTk5TUdNY3RISlAyNXQ5b0NUL0I5eWFMb2ZURjVRNWJB?=
 =?utf-8?B?emxvZitkTDFaTDhna2xGNTlzcTY0aTh2WW5tYk5Kb0ozaCtQV0FCcFNhYzc2?=
 =?utf-8?B?K3FmRlpZamRodG9XUnhCK2cwb0dDU21qUkQvbFVMdEVCTnA2N1V6NitodW9F?=
 =?utf-8?B?MjZhUmsvYnlhYlhaVWl2MVE1ZXZnRW1Cdm0rTmxiVGptWWxwSFBYdVIyc0ZC?=
 =?utf-8?B?M2FkcEg4dkFXeVg5SFhQMTRxMDUyRlp3MlJ1cEhmVVRmeC9MZHJvbktHU1VX?=
 =?utf-8?B?Qjh1T2FNZjZSZTVjdW8vQ2Nnd0JLWUlEV3NkL0x2elNJTUlKcEd0U0dhb0hT?=
 =?utf-8?B?dmFXcVNoeFRhSUVGTjdTd3l1YVd2TGhYRDYrWCttbTBtVTZhamV3b2ZPcXd6?=
 =?utf-8?B?akxXRGN1ZnJwM1BCNDdTY0swVDJ2ZHdUVXV4aXBQV1JVaHFhalR6MjdHaGdq?=
 =?utf-8?B?TUQ0WDF2eEdNZWtNWE1QcXJjZlloSHczR0tScGgzS0J3ZFVkRkxXeWNFYlUr?=
 =?utf-8?B?cWhwMTZ1UnVwcTluZ3NXLzh5eG1ZQTBYdGNxcDUwMHJyc2RldDRHR0hSRDEx?=
 =?utf-8?B?YkZOeGRRTE9lbVAyZkdCaUR3a09WdHo0TVNqdEFUNVN3bTc0QnpCVnlwNmZH?=
 =?utf-8?B?bkhHOWdEVnRSWmNPWmRYMm1hSi83SEQ3elk2T0NSTWR6M0F2aE5LNTlCMm05?=
 =?utf-8?B?TDU0bmtxSDdzbUdyR2ltQzVZUC8zREtkemxyM293K2hWdzI1UmpaTUhoSFg5?=
 =?utf-8?B?L0ZqM2NmaGRtdzh0SXNpR1NwVGljOHVvMVo3ZTJOL1RNSktJM2lxTjhrWlBE?=
 =?utf-8?B?ZGZwMFMybngyL3gzdE5iNzIycEJET01Md2FQSFhmOFVpVXJNamxYRm50VHkv?=
 =?utf-8?B?NWhoR0VSNGtKajR2QnoyTmFQb3dqRXRYSmFYZU1zOUhxaGtRaGRrMis2cEk1?=
 =?utf-8?B?NzlZMHpTK0c5a0l0VjJNYis0b0lsVnVhRWUrTzhIWjVESURIRVd4NXlLM3Rr?=
 =?utf-8?B?YUVseSs3dG1kOWlhR3ViWTU1ZVlCK3hWNHJXZ3NXM3lWNVBWeVc3Qk9ram55?=
 =?utf-8?B?c3k1ZlNJVHQ4eS9kUHNoNSswbnRFOWdybW9ibG1jYkY0WFRPVU1PWW0vNXVQ?=
 =?utf-8?B?WnF0TzZUcTg4ZU9vN0YyYTV5TmE5UEZyZE5vTy9wbGdRdGxpeitZWnJrblFP?=
 =?utf-8?B?VXpmclJESWR2akh6RS9GZXg4MXlmQk5XUmtyUmhseU9KL0tjc3dyQ1RkSkRu?=
 =?utf-8?B?OEk1VmRjT2ZmMzNqOElSYkpNNXFEVEM5L2hwN3JXcHdDcFd5UmxOcndZcDNa?=
 =?utf-8?B?d0lINTFleU51bGtWR09JZDdoM0ZWWWdldjladlhyVHhXYVlNcTh3cEJQYndz?=
 =?utf-8?B?ZFpvS3BIc3p2STZoMERyb01OZ0xZOFdTNU5BK2cxQ3d2MjFmUS9NUGFPK3VL?=
 =?utf-8?B?eUxVNWdtd0hnK1NjWXFSNE1ZRnJ4SjBiKzRSM1ZMMmIxODZwV1BnNUE5ZmRy?=
 =?utf-8?B?VUNWeHY5NmFETGdVRW9rL0tCRk4vcnZ2NlhwVWFiWXpVQWNMREpuWXRsaHo3?=
 =?utf-8?B?SXRNcDdaOHdFVzFjUmRjditEZlNzSGIyQ0dkd3FpalowOTc2VFd1bFh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWIvME1wby9qbzBoN3pOblFKQTlWWFJMSW9KMkNSelZobFlQNWFJaHg4dDhN?=
 =?utf-8?B?VlAvTlpJTEU4S0tEMEZrdWpRY3RkdHZ6Nkh6WFBXMUJDY3VteTZIM3ByU3Nn?=
 =?utf-8?B?Zy9tSWRNS25DdGFoYjVZMTdrdG9jRUxGSFNBWDB1YTN3TVlJaFVaK20xcTJD?=
 =?utf-8?B?Umgwc3ZRTU9TUWFPb010S2FHT1h1QlpFWU1NWlE5RGdFZ2RjOEV0blN6czNa?=
 =?utf-8?B?TTluOFVOSitRUkRCU2FkWGJoUzNxSHIxTWxlK01CS213SjBVOFBKb1RIM3lW?=
 =?utf-8?B?dmRlcUhJZHYvTiswb3RkaUhGQWE0YVNxRkJSMUFlZU9FY3BhcDd5SnhIQTdL?=
 =?utf-8?B?S01kL0pTYjNKejliYUtpL3JrWHJjaFAxMFlBZUljZEpVMzd3cm1VWmJIdGVY?=
 =?utf-8?B?bFNNUXFvMVppa25iZkw3RjZUc0RTZGpLUnVRQ1Z1RC9CdnhTd0diZUtiYVgz?=
 =?utf-8?B?cnByV0kwaXNqUG85WUExNWhoeWt4RkR2azdSUHQxRWNWTXhSWDJPS1owSFNq?=
 =?utf-8?B?ZXRYOUxEUEdiRURsSEZYOXBCYVFZSWVXdE0ycjRCb1dBUDRJbzZFVVJYZlNv?=
 =?utf-8?B?YTZoQ2QxeU5IUXdoRWxQQXBVeW5sS1R5bW05b0R2Q0tMNmZpcjhGZTg1VnNv?=
 =?utf-8?B?VXZWMTlRekhjVEpxY1NKRGxPV1FFa28xRjZzQkdkQlhwL3Y0eHFhY3BJYWVw?=
 =?utf-8?B?VzFkUEIrSVl4QUFpcXhmQWtSNW9PRGIzZTNpa0tFN1p3aFY5Wnk4NHI3Rmx5?=
 =?utf-8?B?TTdSVE9ycENzZWIyQjlEOW41NWhkUTlGbUM5N0hSQnE2Z1h1R2poaHJkTCt0?=
 =?utf-8?B?ZkxWanBiTTh2T0hFT0ZNbDdkUjNYMldOTlhla0JiRUpFeFBNYlhsUGF4NjRa?=
 =?utf-8?B?cmJIUUFtZ2tWekZ3bmZhZTQ4a2FBUlRKNk9VMFhvTEdTQlYzZ1pYYW53Ny9M?=
 =?utf-8?B?RzZ3R1ZNSGgzOWJJT2lTeDVNWnN6L0NKTnM1RWtmczh2Nld6K3owaFNpYTdK?=
 =?utf-8?B?anR0c3dHWStvYmQ3dHhCS1hscmJwejg4aytNbjlQdU80azdXREhtTlczMnpT?=
 =?utf-8?B?SmdxZzlabXFlRW5hUHdIOEFlQlphVGs4THFpbUpsREFXVWRqQzArZ3ZWWGdF?=
 =?utf-8?B?S0NVWm9OUWZhSmxKdkI0VGQzajJkdkhtU3Y0ZHFZbkxIcnZ6SVVYcloyZHFC?=
 =?utf-8?B?S3UvbUxnWFJFWjlWY0J3RVJxMGxhK3JpbmRzZjRPMGZsSVlKTHJKeERlR0tu?=
 =?utf-8?B?YUowMnVVL0YzSkdPTEkwaWVaQ0pQNno4YnFYVjhERzhXREtCY1BsUVE4VXhy?=
 =?utf-8?B?YXRVZ2NQNFh5dzRXUnU5OWwrZnUvc1VMQkJNTVlDaEtTZlBZVUhQSGE1SFBR?=
 =?utf-8?B?bzNabGNxTUYrVHU2TVU3cmZGMHBBekk0N2VhdW85bXpJeTBCRkZEUURSRkxa?=
 =?utf-8?B?QVJ5bHdjV2UxWmpSQzZwUjltT0NjS1AzZGZobEFGWDc4WjllSTh5OTc3WjdJ?=
 =?utf-8?B?QjI0UTg5VDJCRy9SUEJGaHBtSFdtdjI5ZDg5OFdHeUlmSENBRSsySmc1a1lC?=
 =?utf-8?B?VW1yOVFwbTI1Y3A1Q0pVSjdJQnlRV3RUeDBUZGJyTkhhZlFQekpwT0xWSUE1?=
 =?utf-8?B?NTM1WGZ4RTd6eDZxZ0dFdCtxOThHNFliYTJqeFpWbHQ5cmtQSndaSTF4VWtl?=
 =?utf-8?B?WFQ5K1VxQW1sb0pFRmdRVmM0S1Y4R0Z2NnlJcVVNSFhTd3VZNkdHbEZSanlj?=
 =?utf-8?B?OUdkc1d5MXo2L2J5R1AxZzhNd1ZXVjdWbUpOdXI5NEhCbmxEYVY5TVZvY2hK?=
 =?utf-8?B?dFJPaTlESEpRZXY3cWV5cFdkeTZZcHJ0Y1VQTmFYZjdRM0dMeCtib1JFeFdF?=
 =?utf-8?B?djVUTTRpWFlsQkpCN2ErSTFZWFI3eExWeDdwMEhVam9FcVBIQktiMUU2Z2Nq?=
 =?utf-8?B?VFA1Mk1TRXF2cEtQVTlQRXhQeXY1Z2xuK2lCVmt2VDZjQWNOQ3FZV3VjSTlk?=
 =?utf-8?B?R2xUN0lJTDR0dlRjNEtuNEVENWNqKzEvYlpNcTFnMTgrWlZlVU85UlI5eTJv?=
 =?utf-8?B?TC9iOWVCQThSK0RORU1OUkE2dXJSL0hpT0tva21xUkVpZ2xKTGVoclh6cEI5?=
 =?utf-8?Q?+e9odFbc+CHDjkXolcDjPhd1J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2283db93-5941-45f8-93d9-08dcdd9a9fb1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 19:45:35.5152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ7tBWPXKEdjzHkHSZCUzXXI7/7x3WiBoX200jZOlHQTrEg5isA8EmVwo1dOwG3PBDkqNL1gSJ4/CvCBnkhDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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


On 2024-09-04 07:03, Christian König wrote:
> It could be that the automated testing tools will run amok on that.
>
> I need to ask Felix for details but I think the code for the CWSR trap 
> handlers were converted to C style comments as well because of that.

I'm not aware of that. I see both comment styles in 
amdkfd/cwsr_trap_handler_*.asm.


Regards,
   Felix


>
> Christian.
>
> Am 04.09.24 um 12:52 schrieb Deucher, Alexander:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> I think you can drop this patch.  This code is not compiled, it's 
>> just for reference, and changing all of the comments will just make 
>> it harder to keep in sync with the internal version.
>>
>> Alex
>>
>> ------------------------------------------------------------------------
>> *From:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>> *Sent:* Wednesday, September 4, 2024 5:51 AM
>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Deucher, 
>> Alexander <Alexander.Deucher@amd.com>
>> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
>> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>> *Subject:* [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in 
>> cleaner shader code
>> This commit updates the comment style in the cleaner shader code from
>> `//` to `/* ... */` to adhere to the Linux kernel coding style.
>>
>> The comments describe the operation of the cleaner shader, which is used
>> to clean LDS, SGPRs, and VGPRs. The shader uses two kernels launched
>> separately to clean VGPRs, LDS, and lower SGPRs, and to clean remaining
>> SGPRs.
>>
>> Fixes: 3b721dfb2c95 ("drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>> v2:
>>  - Corrected typo for iteraions
>>  - Added fixes tag
>>
>>  .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 139 +++++++++---------
>>  1 file changed, 72 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
>> index d5325ef80ab0..8951b5a87ae1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
>> @@ -21,47 +21,52 @@
>>   * OTHER DEALINGS IN THE SOFTWARE.
>>   */
>>
>> -// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 
>> Dwords or 256 bytes of 192 Dwords cleaner shader.
>> -//To turn this shader program on for complitaion change this to main 
>> and lower shader main to main_1
>> -
>> -// MI300 : Clear SGPRs, VGPRs and LDS
>> -//   Uses two kernels launched separately:
>> -//   1. Clean VGPRs, LDS, and lower SGPRs
>> -//        Launches one workgroup per CU, each workgroup with 4x 
>> wave64 per SIMD in the CU
>> -//        Waves are "wave64" and have 128 VGPRs each, which uses all 
>> 512 VGPRs per SIMD
>> -//        Waves in the workgroup share the 64KB of LDS
>> -//        Each wave clears SGPRs 0 - 95. Because there are 4 
>> waves/SIMD, this is physical SGPRs 0-383
>> -//        Each wave clears 128 VGPRs, so all 512 in the SIMD
>> -//        The first wave of the workgroup clears its 64KB of LDS
>> -//        The shader starts with "S_BARRIER" to ensure SPI has 
>> launched all waves of the workgroup
>> -//          before any wave in the workgroup could end.  Without 
>> this, it is possible not all SGPRs get cleared.
>> -//    2. Clean remaining SGPRs
>> -//        Launches a workgroup with 24 waves per workgroup, yielding 
>> 6 waves per SIMD in each CU
>> -//        Waves are allocating 96 SGPRs
>> -//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent 
>> these waves from allocating SGPRs 0-223.
>> -//          As such, these 6 waves per SIMD are allocated physical 
>> SGPRs 224-799
>> -//        Barriers do not work for >16 waves per workgroup, so we 
>> cannot start with S_BARRIER
>> -//          Instead, the shader starts with an S_SETHALT 1. Once all 
>> waves are launched CP will send unhalt command
>> -//        The shader then clears all SGPRs allocated to it, cleaning 
>> out physical SGPRs 224-799
>> +/*
>> + * This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 
>> Dwords or 256 bytes of 192 Dwords cleaner shader.
>> + * To turn this shader program on for complitaion change this to 
>> main and lower shader main to main_1
>> + *
>> + * MI300 : Clear SGPRs, VGPRs and LDS
>> + *   Uses two kernels launched separately:
>> + *   1. Clean VGPRs, LDS, and lower SGPRs
>> + *        Launches one workgroup per CU, each workgroup with 4x 
>> wave64 per SIMD in the CU
>> + *        Waves are "wave64" and have 128 VGPRs each, which uses all 
>> 512 VGPRs per SIMD
>> + *        Waves in the workgroup share the 64KB of LDS
>> + *        Each wave clears SGPRs 0 - 95. Because there are 4 
>> waves/SIMD, this is physical SGPRs 0-383
>> + *        Each wave clears 128 VGPRs, so all 512 in the SIMD
>> + *        The first wave of the workgroup clears its 64KB of LDS
>> + *        The shader starts with "S_BARRIER" to ensure SPI has 
>> launched all waves of the workgroup
>> + *          before any wave in the workgroup could end.  Without 
>> this, it is possible not all SGPRs get cleared.
>> + *    2. Clean remaining SGPRs
>> + *        Launches a workgroup with 24 waves per workgroup, yielding 
>> 6 waves per SIMD in each CU
>> + *        Waves are allocating 96 SGPRs
>> + *          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent 
>> these waves from allocating SGPRs 0-223.
>> + *          As such, these 6 waves per SIMD are allocated physical 
>> SGPRs 224-799
>> + *       Barriers do not work for >16 waves per workgroup, so we 
>> cannot start with S_BARRIER
>> + *       Instead, the shader starts with an S_SETHALT 1. Once all 
>> waves are launched CP will send unhalt command
>> + *       The shader then clears all SGPRs allocated to it, cleaning 
>> out physical SGPRs 224-799
>> + */
>>
>>  shader main
>>    asic(MI300)
>>    type(CS)
>>    wave_size(64)
>> -// Note: original source code from SQ team
>>
>> -//   (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 
>> 2176 clks)
>> +/*
>> + * Note: original source code from SQ team
>> + *
>> + * (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 
>> 2176 clks)
>> + */
>>
>> -  s_cmp_eq_u32 s0, 1 // Bit0 is set, sgpr0 is set then clear VGPRS 
>> and LDS as FW set COMPUTE_USER_DATA_3
>> -  s_cbranch_scc0  label_0023 // Clean VGPRs and LDS if sgpr0 of wave 
>> is set, scc = (s3 == 1)
>> +  s_cmp_eq_u32 s0, 1 /* Bit0 is set, sgpr0 is set then clear VGPRS 
>> and LDS as FW set COMPUTE_USER_DATA_3 */
>> +  s_cbranch_scc0  label_0023 /* Clean VGPRs and LDS if sgpr0 of wave 
>> is set, scc = (s3 == 1) */
>>    S_BARRIER
>>
>>    s_movk_i32    m0, 0x0000
>> -  s_mov_b32     s2, 0x00000078  // Loop 128/8=16 times  (loop 
>> unrolled for performance)
>> -  //
>> -  // CLEAR VGPRs
>> -  //
>> -  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
>> +  s_mov_b32     s2, 0x00000078  /* Loop 128/8=16 times  (loop 
>> unrolled for performance) */
>> +/*
>> + * CLEAR VGPRs
>> + */
>> +  s_set_gpr_idx_on  s2, 0x8    /* enable Dest VGPR indexing */
>>  label_0005:
>>    v_mov_b32     v0, 0
>>    v_mov_b32     v1, 0
>> @@ -75,24 +80,24 @@ label_0005:
>>    s_set_gpr_idx_idx  s2
>>    s_cbranch_scc0  label_0005
>>    s_set_gpr_idx_off
>> -
>> -  //
>> -  //
>> -
>> -  s_mov_b32     s2, 0x80000000 // Bit31 is first_wave
>> -  s_and_b32     s2, s2, s1 // sgpr0 has tg_size (first_wave) term as 
>> in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
>> -  s_cbranch_scc0  label_clean_sgpr_1 // Clean LDS if its first wave 
>> of ThreadGroup/WorkGroup
>> -  // CLEAR LDS
>> -  //
>> +
>> +  s_mov_b32     s2, 0x80000000 /* Bit31 is first_wave */
>> +  s_and_b32     s2, s2, s1 /* sgpr0 has tg_size (first_wave) term as 
>> in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set */
>> +  s_cbranch_scc0  label_clean_sgpr_1 /* Clean LDS if its first wave 
>> of ThreadGroup/WorkGroup */
>> +/*
>> + * CLEAR LDS
>> + */
>>    s_mov_b32 exec_lo, 0xffffffff
>>    s_mov_b32 exec_hi, 0xffffffff
>> -  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID 
>> (0..63)
>> -  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to thread-ID 
>> (0..63)
>> -  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each thread 
>> is a double-dword address (8byte)
>> -  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
>> +  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          /* Set V1 to thread-ID 
>> (0..63) */
>> +  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         /* Set V1 to thread-ID 
>> (0..63) */
>> +  v_mul_u32_u24  v1, 0x00000008, v1           /* * 8, so each thread 
>> is a double-dword address (8byte) */
>> +  s_mov_b32     s2, 0x00000003f               /* 64 loop iterations */
>>    s_mov_b32     m0, 0xffffffff
>> -  // Clear all of LDS space
>> -  // Each FirstWave of WorkGroup clears 64kbyte block
>> +/*
>> + * Clear all of LDS space
>> + * Each FirstWave of WorkGroup clears 64kbyte block
>> + */
>>
>>  label_001F:
>>    ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
>> @@ -100,11 +105,11 @@ label_001F:
>>    v_add_co_u32     v1, vcc, 0x00000400, v1
>>    s_sub_u32     s2, s2, 1
>>    s_cbranch_scc0  label_001F
>> -  //
>> -  // CLEAR SGPRs
>> -  //
>> +/*
>> + * CLEAR SGPRs
>> + */
>>  label_clean_sgpr_1:
>> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop 
>> unrolled for performance)
>> +  s_mov_b32     m0, 0x0000005c   /* Loop 96/4=24 times  (loop 
>> unrolled for performance) */
>>    s_nop 0
>>  label_sgpr_loop:
>>    s_movreld_b32     s0, 0
>> @@ -114,25 +119,25 @@ label_sgpr_loop:
>>    s_sub_u32         m0, m0, 4
>>    s_cbranch_scc0  label_sgpr_loop
>>
>> -  //clear vcc, flat scratch
>> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
>> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
>> -  s_mov_b64 vcc, 0               //clear vcc
>> -  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1
>> -  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3
>> -  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5
>> -  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7
>> -  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9
>> -  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11
>> -  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13
>> -  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15
>> +  /* clear vcc, flat scratch */
>> +  s_mov_b32 flat_scratch_lo, 0   /* clear flat scratch lo SGPR */
>> +  s_mov_b32 flat_scratch_hi, 0   /* clear flat scratch hi SGPR */
>> +  s_mov_b64 vcc, 0               /* clear vcc */
>> +  s_mov_b64 ttmp0, 0             /* Clear ttmp0 and ttmp1 */
>> +  s_mov_b64 ttmp2, 0             /* Clear ttmp2 and ttmp3 */
>> +  s_mov_b64 ttmp4, 0             /* Clear ttmp4 and ttmp5 */
>> +  s_mov_b64 ttmp6, 0             /* Clear ttmp6 and ttmp7 */
>> +  s_mov_b64 ttmp8, 0             /* Clear ttmp8 and ttmp9 */
>> +  s_mov_b64 ttmp10, 0            /* Clear ttmp10 and ttmp11 */
>> +  s_mov_b64 ttmp12, 0            /* Clear ttmp12 and ttmp13 */
>> +  s_mov_b64 ttmp14, 0            /* Clear ttmp14 and ttmp15 */
>>  s_endpgm
>>
>>  label_0023:
>>
>>    s_sethalt 1
>>
>> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop 
>> unrolled for performance)
>> +  s_mov_b32     m0, 0x0000005c   /* Loop 128/8=16 times  (loop 
>> unrolled for performance) */
>>    s_nop 0
>>  label_sgpr_loop1:
>>
>> @@ -143,10 +148,10 @@ label_sgpr_loop1:
>>    s_sub_u32         m0, m0, 4
>>    s_cbranch_scc0  label_sgpr_loop1
>>
>> -  //clear vcc, flat scratch
>> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
>> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
>> -  s_mov_b64 vcc, 0xee            //clear vcc
>> +  /* clear vcc, flat scratch */
>> +  s_mov_b32 flat_scratch_lo, 0   /* clear  flat scratch lo SGPR */
>> +  s_mov_b32 flat_scratch_hi, 0   /* clear  flat scratch hi SGPR */
>> +  s_mov_b64 vcc, 0xee            /* clear vcc */
>>
>>  s_endpgm
>>  end
>> -- 
>> 2.34.1
>>
>
