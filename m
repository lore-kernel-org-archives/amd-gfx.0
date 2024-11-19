Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F8DD6204F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 09:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FA110E5FF;
	Tue, 19 Nov 2024 09:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z9agOkFT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF0B10E5FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 09:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ij0kjRjry4wITZwbWk3KiOTV1l7oU1V+10vDJquGmUO3/bKIUQfmhzi88W4xBzhV719cZ06luRyXrFGttHcbFOvXg5dRpbEItHxJJWd0WAJD9hGkFahz/nQqaTNl0gRzv1pXvW7MtLiQqMpKhO1QTz4JPFm8liPwgFvI+VPsO2Z33n7ewvDMaZNbQiJPoXO7hPFgCJmn8Dq4SIzUJXRhA+Q9eaHGfDzcMwKmkW7C6HwIonfuGaae16OiGe6fDVk+iaKYBDF1jBDx+WYE1VyzozM/aVitGk+vZ0VN7T2gaTUXjjc+l1wMxIbz8yyyz29Qmoxks3fk2l+rSCat843gfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEFJMfnBzcpD6Gq/Nsey08tkQj2vNP9k2vZFhYu8Seg=;
 b=rRARzBVINoILCs8Eu8CGy7SzbBxkKuYsa7+lTBOMM6nJ6NZyzhN+cY2iCyupcqT0RW0CI1S52Zf/4fCQhyLjnm2IqbcutH8PQKzQ747npfUL7O9+fjyheLbqshCKII/dL7iBSP+D7fEsNyHoT0f9fO0vYPC9bbLmlYa+GT7P8rpnYKVYNB7l9C0hXcZBwBxJjnJCrpvo+gb3zZVe8CkhF+j6PABkG3MdevCnao1JKMmqD7FS0HSoAtbVvt9eWG2KiSv5/QdzIMwQs9qUr+0nGO/w6rDiRbG2tkHga2eGkzz6c2xNhqw7d+03rHiGLmHiXItD1i140ycy+UtozWAacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEFJMfnBzcpD6Gq/Nsey08tkQj2vNP9k2vZFhYu8Seg=;
 b=Z9agOkFTsn5ohRbQavxhe4/sb64qTiQXk8u7eRSQ3q3eFtCMchNaVT2WQfJ/2qM3WAnHp0fTDyxAVBU5lbnNSon+Nf8SNx3B7+oqDlvokzwxBJ0DUYeMcW+IT0pLCd3mkrGSHzrql3AahJVXdE1luI2oSvKvWQnFD0hg7CZVocE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 09:30:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 09:30:42 +0000
Content-Type: multipart/alternative;
 boundary="------------VQ7sYyZGvimLUc0mbWl33CtH"
Message-ID: <3cfdbe8c-269c-4db5-90fe-a3346aa7f49c@amd.com>
Date: Tue, 19 Nov 2024 10:30:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Check fence emitted count to identify bad
 jobs
To: "Fan, Shikang" <Shikang.Fan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
References: <20241118101013.917462-1-shikang.fan@amd.com>
 <SA1PR12MB734309748AB9340AFC555028EB202@SA1PR12MB7343.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB734309748AB9340AFC555028EB202@SA1PR12MB7343.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e59e20-a7bd-4286-e188-08dd087cd633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlN1NmpFZEd6d2YwUnFPVVlpK2d1ckJjSm5pcG1SQllRbWRtQ0h3NnhUWTJC?=
 =?utf-8?B?SElyaVJWcWRsWTlmMU5MRU9KZjhDL3Q3NGFvRWpJVGNtNDZ2aEg0bEJTbkdw?=
 =?utf-8?B?ODkwZ1h0MTExZnVzajhGYUdtcGlzY0xLYlhldFdiUFp1TjFaSW4vOFU1cTRj?=
 =?utf-8?B?TDFHOGhMN1NlaVIxUERXamFxTk5sbFF6Zkg2T2VwNWc0bldCZ0NFMFR6N2Jj?=
 =?utf-8?B?THBVT3pUeXI0ZHFuVGJYSmg2VnlxUEl3VlVaK3pqSlNoaEpLMmJsSUhnNm1k?=
 =?utf-8?B?UFdOK1VIQUxtcXcyMC8yb0w1RVNjci9ZVXdIQU1aVHVBazVVelFJK2oyblUr?=
 =?utf-8?B?UlFDWGJpM2VGUVkwLzV0YWpUcXVtYUNPV0NJZHN0eE9JS0g4Y1hhdUNzZ0sw?=
 =?utf-8?B?cGZMQ3VvSmw4WGY4TUVzSzNqUGtyWGpacjNkU3BlWkNQWVkvUkFhL0taZ1BL?=
 =?utf-8?B?L3FQOHBLbld4dW9oWDQwcEtNdXArYnNKcWhFT0ZwT2pYaWxGMy9QR29xTlB0?=
 =?utf-8?B?Q0JUVjF5ZHVxOHIrdU5kOEl4ellMS254NWJsT2Q3SEVJc0UvOWRMM3pPdEFn?=
 =?utf-8?B?L1JWYWdGMTNrWE1WZ2lXQXhlTUxKK0RjOHpCK0FaWGtNY244SW1KQldMRW51?=
 =?utf-8?B?RGx6Ky9Gb0FISm9ESkhOcE5SVEJQVzEzSkpPZnIxU2IrdkNLcTFPTG1CaTFz?=
 =?utf-8?B?TGo0TzlNbnN1RXFmTFFLQmxQaVNIVjg2N2ZqTjZVNmQ2N0tCcElKeWIyMVl5?=
 =?utf-8?B?VkRWNVRDWGR2MVdzb2FtSlgvay9pS1hlSkxXQmFVYkpNWE5sU0VBZ0pUN2xI?=
 =?utf-8?B?aWtSeXJmM1Uyc1JxTmcxdC9xNWlqbmFvZkFpTnlFV0lWNStOVnJwWmZOSmUw?=
 =?utf-8?B?VFEzNUJHdEZWOWZyU0V0M2x5NkFLWlVGd1BKYW00b1doRTcyY3lpRy9ndzV2?=
 =?utf-8?B?aElDTWpYUGgrMlVUYmx0NnFKTUhTc2cyejJMaTlIY1RXOVlJdmtoRm1yUzRo?=
 =?utf-8?B?bzIxcmYvSXV5V0JvZEtnNEs3dlRMYmExL3Z4dHdFM3p5amlscFZZTzgvbkc2?=
 =?utf-8?B?UmUxemZ1WFpHNXY3UXhWeWpzTTExMDk4Tjd6V20vRW9zMUVJNXhGNi9wTnV0?=
 =?utf-8?B?S2dUNVVnNEk3Q2gzY2dxeVRoWTJRZGM1N0lIb3pqYVZiUklKV0hPWVdDUEdK?=
 =?utf-8?B?YVFzcVpsd0tHRUJvdHhQQkN6K25QWGxNSUt4NXVCcXN2OC9sbWlMSjBRUTF5?=
 =?utf-8?B?WnpkNms3K3B0aHR3SHQ0Y3k3eUt0R1prZnJwQVozTDNsY0FYcDJUMVZjU3Ji?=
 =?utf-8?B?V3JXTmc2QUdzeHI1d1BxU0Q4elJ5YUFEYTR3bmZnM0JqZ1J4YnJWSEdmOUV0?=
 =?utf-8?B?dVBjYjIyRmhQdW5KYi8yNFBmVTNTY1d5ZU9ERUh4VnhRR3R4NnRwOTNwYlJr?=
 =?utf-8?B?K09ZTit3RlZHcTh2V2FvalR0MkFFVzZXZTRFRW02MnBFQkVCNlRXbFZ3aUpT?=
 =?utf-8?B?dnNvbU9PeXR2RGh1S3hSeXVwOE96MlY5NUt6NnA3dENYLzhpSWRWelhob3hX?=
 =?utf-8?B?aFZQblFWQ2lUVkt3SFMzL1ErUHFTcUpFUTJpeUFrTTlnbGNHc1RWNFYxZ082?=
 =?utf-8?B?V2dsTWlpRzdSdjFiMDdOcUpUa2JPZFQxUHpRYzNwaFVyalk4R3ZleTVXZXRR?=
 =?utf-8?B?bWJSUmF2WEpWRUZvanNkdFRZb2x2U1ZZTXc5cHN1NWVoUk1Zb01tVUhGd1FC?=
 =?utf-8?Q?+V0RnrvB8m1LGYb25JyhumS9zOLxVsBDXT1QzVo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUpIL3hRbVRSUG4vamk5bWVrZzhMeWJSQkVSeDZtOHQvR3UwSS8yN1NsUDRo?=
 =?utf-8?B?alBKcmwxNUJVZXhMVzF3RjhKUy9YUU5rYmt2STVSbUhmdGxXZjVnTVJWVUZs?=
 =?utf-8?B?ZnBuUjk4L283RFIxb3g5b0pVUTZQTmlmODZoWTFoTmVJSjVleVJreHlEb2Yw?=
 =?utf-8?B?YVhmMGh3WkNrM3NTbUVtZ0ZGMlJpR3ltWnJuMDBxT3o1QmpQR2hFSzN0eVU1?=
 =?utf-8?B?RUZDWFd3VmlaOUdjTlpiWWYrMmJOTUVlQkF4TGtjYVZ1OWtsVVVqc2pzMkxY?=
 =?utf-8?B?cVczWDE4RDJmVnU5MzdEYTVjdWhMbHZvWmkvekcyWGFSalZKTXVUbWFLVXZy?=
 =?utf-8?B?Z2tSMjRBbWhBRDY0NkFoTGlYNFg0M3ZidnErd3NhZ3ZGL0NhK05UUDJja25u?=
 =?utf-8?B?ZXZzVnE4Um9zcEMyNnBpa3k1Y21wR2JvUHk3bG9oclFnS3lQMndVWTZkOWdL?=
 =?utf-8?B?bjhraVVQNmZGY2tWY2xsQUp5KzRYdmNtMHdGa3Y2Nm5ES3prMHRwRzVTY1Nm?=
 =?utf-8?B?K2V6KzlYdERxQVhiS05ORnJERVAxa2FPNFdrWTd0WWxhcWFYZVdpL25ISkxU?=
 =?utf-8?B?Q2R6a3N3SDd2Nit3Ylc4QmdqWi85TTI4RFJiYStqRUFCVTFZc2YxTG9VQUFx?=
 =?utf-8?B?eFIwT1Q2NHlscklKWXpYOGxmVWhMWXcrL2ZEaHlvS25RVW55RCtyMlo4c0ZW?=
 =?utf-8?B?bVk1dGl1eTFKRlZoakxUTmZoajNWVnpNYUF0RXVzdDhLTXMycEc4NXV5WUJS?=
 =?utf-8?B?amEwcHJ5RTF3QnkzMzF3R1h0alYrVmZ2ZUhQMy9lbEwxcWdDTVY1RGZ4V29l?=
 =?utf-8?B?N2dpTFJxcXU4bEYvWGd2MHJuQW9lV2svSmdQaURkY3VxNSt3SzVZSnZyN2I4?=
 =?utf-8?B?d2FFNm5raE5YWEtJV1dlZU03ZlJqckRpLzd1b1FqYTdiWUJrN2tEMDU2VUkr?=
 =?utf-8?B?ZTJUdDV0QS9LR3Q1ZnpaN05KUVRyU2I3WUxnblgwM3FsYm83R1FFV2VmSU9B?=
 =?utf-8?B?Unl1SzJYREVMVjlZRUU3TyswakdoMnNDRE1zSFFxVHZQUTdITjNWZnZoZVdT?=
 =?utf-8?B?c3F1N1hacFBNQTJUSnM2ZFl0VjZBK1FONkRyUjNDdmczZ0IvdVlqaDlBL2Er?=
 =?utf-8?B?b2ZoTEV1Tlg0Q2R0Z0VPYm15Um9XY2xybjd6bmNUbnk5dzA0Z05aRVVjeGRs?=
 =?utf-8?B?Nnk4ZUVpMVFOM2IvWjhjWE82VmxRMVNJcksvVVFRL2dkSCs5QVVBbjQxcERJ?=
 =?utf-8?B?MS9KTTVFRDdKUldJK1YzZVJWbjd5MDBQd3NITjJpRlVQb3NYWU54bGRCTDI3?=
 =?utf-8?B?V2pKVEIvc2d2cWxZeVRXTjVRZ0hJN2M1S2M3bnpUTW5JQWdPeHo5NTRrNU9l?=
 =?utf-8?B?M3RqZ3hBdGFSakF0ck5yMFpQZVlibjRVOVpIRStVd2JLWlpydUduNTRNeC9G?=
 =?utf-8?B?ZEpmTTRNbWxRSldSYjBUL0xIQjc2eURMTEo0N29FQmM5OTlGQ2FYaHYrRnp3?=
 =?utf-8?B?YmFkbWt5elFseEprK2tNNUhkK2hnTHJrdk41NXpTRDZVNEhnZzBJSFp6anBq?=
 =?utf-8?B?UDdDcVZCSEx6L0luSi9PME5lei9pcGljeWVjakgyazl4dUlSbE5iL1czelpI?=
 =?utf-8?B?cU4vMDFmcDhDTUU0blNmUFYyNXE2amNtSWMxZXVDckoraGJoc2NzWnpHZ3Qv?=
 =?utf-8?B?a2ZQdUt6U3hiQzVGdHhxQWttQ1RzM0JwYnkwTmNWTXplTjhpTUp3c0NqWG9D?=
 =?utf-8?B?S2ZBOFVHMnlXRThESm9jMGVxYllkeGQrOEVwL1pBQjVDcEJFYnpMQmtQUCtt?=
 =?utf-8?B?dXgwbS9QeUx6R2YyMW41SFZYU2Nod3ZwRURJaVJ2NHkxaUcraW94VHMzYWJp?=
 =?utf-8?B?aTcySVcxODFLSFpiRkNvemlDSFh1dUNsZHJjcmJNa0Z0VktFNDFhc0tPSzlq?=
 =?utf-8?B?NGh2Nm4xbUVMTnhJb3FpLzF5QjRBWGlCcG10RVRicjhSUmF3VmtmTlFnZ0lT?=
 =?utf-8?B?ZEMyblFLb2FGMkFLeHJ2V2NaTmN3Y0JEcWNmUWtvOWN2MDFQMkVqZjFpZXN1?=
 =?utf-8?B?bktHdFpBYWp5WEFlTkRnL0xYUk5ZSHh0TG82YkxqWkNtSGZOV3J6cnVrdnNK?=
 =?utf-8?Q?C6uSdk7cUn1l4tZR2gvhUJYIj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e59e20-a7bd-4286-e188-08dd087cd633
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 09:30:42.1350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej6eGPSdy7fI0wW6tftayKmTw0YtnAIp+sC7QE64tP7bfqMwLrtSiwd5ldbjQXEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

--------------VQ7sYyZGvimLUc0mbWl33CtH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shikang,

please completely drop the AMDGPU_PENDING_JOB_TIMEOUT workaround.

This is unnecessary when you use amdgpu_fence_count_emitted() instead of 
looking at the jobs.

That's one of the reasons why looking at the jobs is such a really 
really bad idea in the first place.

Regards,
Christian.

Am 19.11.24 um 09:47 schrieb Fan, Shikang:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> +@Koenig, Christian <mailto:Christian.Koenig@amd.com>
>
> Hi Christian,
>
> Could you please help take a look at this patch? Compared to the 
> previous patch, we now use amdgpu_fence_emitted_count to check 
> unfinished jobs. And this function is currently only used for 
> mailbox_flr_work In SRIOV case, soI believe the modification on this 
> function will not have any impact on the rest part of the driver. 
> Thanks for your advice on v1 patch.
>
> Regards,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Shikang Fan <shikang.fan@amd.com>
> *Sent:* Monday, November 18, 2024 6:10 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Fan, Shikang <Shikang.Fan@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> *Subject:* [PATCH v2] drm/amdgpu: Check fence emitted count to 
> identify bad jobs
> In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
> guest driver, there is a small chance that there is no job running on hw
> but the driver has not updated the pending list yet, causing the driver
> not respond the FLR request. Modify the has_job_running function to
> make sure if there is still running job.
>
> v2: Use amdgpu_fence_count_emitted to determine job running status.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3ca911e55d6..ea756eacebdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
>  #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
>  #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
>  #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
> +#define AMDGPU_PENDING_JOB_TIMEOUT     (1000000)
>
>  static const struct drm_driver amdgpu_kms_driver;
>
> @@ -5222,15 +5223,19 @@ static int amdgpu_device_reset_sriov(struct 
> amdgpu_device *adev,
>  }
>
>  /**
> - * amdgpu_device_has_job_running - check if there is any job in 
> mirror list
> + * amdgpu_device_has_job_running - check if there is any unfinished job
>   *
>   * @adev: amdgpu_device pointer
>   *
> - * check if there is any job in mirror list
> + * check if there is any job running on the device when guest driver 
> receives
> + * FLR notification from host driver. If there are still jobs running 
> and not
> + * signaled after 1s, the hardware is most likely hung already, then 
> the guest
> + * driver will not respond the FLR reset. Instead, let the job hit 
> the timeout
> + * and guest driver then issue the reset request.
>   */
>  bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>  {
> -       int i;
> +       int i, j;
>          struct drm_sched_job *job;
>
>          for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> @@ -5239,11 +5244,12 @@ bool amdgpu_device_has_job_running(struct 
> amdgpu_device *adev)
>                  if (!amdgpu_ring_sched_ready(ring))
>                          continue;
>
> -               spin_lock(&ring->sched.job_list_lock);
> -               job = list_first_entry_or_null(&ring->sched.pending_list,
> -                                              struct drm_sched_job, 
> list);
> - spin_unlock(&ring->sched.job_list_lock);
> -               if (job)
> +               for (j = 0; j < AMDGPU_PENDING_JOB_TIMEOUT; j++) {
> +                       if (!amdgpu_fence_count_emitted(ring))
> +                               break;
> +                       udelay(1);
> +               }
> +               if (j == AMDGPU_PENDING_JOB_TIMEOUT)
>                          return true;
>          }
>          return false;
> --
> 2.34.1
>

--------------VQ7sYyZGvimLUc0mbWl33CtH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Shikang,<br>
    <br>
    please completely drop the AMDGPU_PENDING_JOB_TIMEOUT workaround.<br>
    <br>
    This is unnecessary when you use amdgpu_fence_count_emitted()
    instead of looking at the jobs.<br>
    <br>
    That's one of the reasons why looking at the jobs is such a really
    really bad idea in the first place.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 19.11.24 um 09:47 schrieb Fan,
      Shikang:<br>
    </div>
    <blockquote type="cite" cite="mid:SA1PR12MB734309748AB9340AFC555028EB202@SA1PR12MB7343.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          +<a href="mailto:Christian.Koenig@amd.com" id="OWAAM957748" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">@Koenig, Christian</a><br>
          <br>
          Hi Christian,<br>
          <br>
          Could you please help take a look&nbsp;at this patch? Compared to
          the previous patch, we now use amdgpu_fence_emitted_count to
          check unfinished jobs. And this function is currently only
          used for mailbox_flr_work In SRIOV case, soI believe the
          modification on this function will not have any impact on the
          rest part of the driver. Thanks for your advice on v1 patch.<br>
          <br>
          Regards,</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Shikang</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display: inline-block; width: 98%;">
        <div dir="ltr" id="divRplyFwdMsg"><span style="font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Shikang
            Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
            <b>Sent:</b>&nbsp;Monday, November 18, 2024 6:10 PM<br>
            <b>To:</b>&nbsp;<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b>&nbsp;Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a>; Deng,
            Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
            <b>Subject:</b>&nbsp;[PATCH v2] drm/amdgpu: Check fence emitted
            count to identify bad jobs</span>
          <div>&nbsp;</div>
        </div>
        <div style="font-size: 11pt;">In SRIOV, when host driver
          performs MODE 1 reset and notifies FLR to<br>
          guest driver, there is a small chance that there is no job
          running on hw<br>
          but the driver has not updated the pending list yet, causing
          the driver<br>
          not respond the FLR request. Modify the has_job_running
          function to<br>
          make sure if there is still running job.<br>
          <br>
          v2: Use amdgpu_fence_count_emitted to determine job running
          status.<br>
          <br>
          Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
          Signed-off-by: Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
          ---<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22
          ++++++++++++++--------<br>
          &nbsp;1 file changed, 14 insertions(+), 8 deletions(-)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
          index b3ca911e55d6..ea756eacebdc 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
          @@ -100,6 +100,7 @@
          MODULE_FIRMWARE(&quot;amdgpu/navi12_gpu_info.bin&quot;);<br>
          &nbsp;#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 &gt;&gt; 2)<br>
          &nbsp;#define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 &gt;&gt; 2)<br>
          &nbsp;#define AMDGPU_PCIE_DATA_FALLBACK (0x3C &gt;&gt; 2)<br>
          +#define AMDGPU_PENDING_JOB_TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp; (1000000)<br>
          &nbsp;<br>
          &nbsp;static const struct drm_driver amdgpu_kms_driver;<br>
          &nbsp;<br>
          @@ -5222,15 +5223,19 @@ static int
          amdgpu_device_reset_sriov(struct amdgpu_device *adev,<br>
          &nbsp;}<br>
          &nbsp;<br>
          &nbsp;/**<br>
          - * amdgpu_device_has_job_running - check if there is any job
          in mirror list<br>
          + * amdgpu_device_has_job_running - check if there is any
          unfinished job<br>
          &nbsp; *<br>
          &nbsp; * @adev: amdgpu_device pointer<br>
          &nbsp; *<br>
          - * check if there is any job in mirror list<br>
          + * check if there is any job running on the device when guest
          driver receives<br>
          + * FLR notification from host driver. If there are still jobs
          running and not<br>
          + * signaled after 1s, the hardware is most likely hung
          already, then the guest<br>
          + * driver will not respond the FLR reset. Instead, let the
          job hit the timeout<br>
          + * and guest driver then issue the reset request.<br>
          &nbsp; */<br>
          &nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device
          *adev)<br>
          &nbsp;{<br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
          &nbsp;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
          @@ -5239,11 +5244,12 @@ bool
          amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
          &nbsp;<br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job =
          list_first_entry_or_null(&amp;ring-&gt;sched.pending_list,<br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
          drm_sched_job, list);<br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job)<br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = 0; j &lt; AMDGPU_PENDING_JOB_TIMEOUT;
          j++) {<br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_fence_count_emitted(ring))<br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j == AMDGPU_PENDING_JOB_TIMEOUT)<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
          --<br>
          2.34.1<br>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------VQ7sYyZGvimLUc0mbWl33CtH--
