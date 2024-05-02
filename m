Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E89EC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 05:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE87910ECC2;
	Thu,  2 May 2024 05:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jbJE33ur";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5096010ECC2
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 05:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNMqw+AzKw8ZgHG1cj3Dc3jMm0nYGtv9/lmLEuxzLEyTn0jdByvJGRwurH+N7Lq6Egf3pad/jid9+tNd0kMZNSypwISVSOySuyRIO6lYMVWC0W5w9EgD/o09EyNs/WFRs9mE+17JZkDGkUwvfe3cBbJM1Jx8o1uf+Nn5eREBDwwLiJIMcWJHZGxzSda8XrH7qA0lWFJ53y4YKEpXn6tIviwTp/zjsFSb3tlm1hsJuX+w757A3j71TNs7a6vgY7VG2QTbwkhG1SVK83u+qf51cQLjgkc0cTHsxp5VMmzbTDF2nNdAeD2u92w4cuzfkPo59pR5fxUNm4eDkJDJX691QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOiO32DZP4wYlT4PEJTvH58fRyW5qf/MyARbE9UrxNE=;
 b=gPZCeP8KgHg65l0EK/N436rWCjSxKeByAF24oRqa1g2K+wkvwEZRScgHPFaPmNzFTiLQ1SPUxUNio+xlxvBcN+b0/LKneQePZcWQs0iuG9D/muBE2tj0bg2TOnnOMk8i/mHY/5Voxhsv16mQ4jGUyApQhKi50roGMQBlDpnXl7LFvyTeP8PPuBoY2eoiSietdkDGXrFpT8VQ4crhaZn0Xqze1PxSkbYC7Ft9xE42hFLHw+HZ1vSXmCuWZsr1KLJ7VLwG/uyyqhrENtl9VF7LxYF16Pb37RKxB2etBFnCTXXdwF64kkAZ+CpQETJrFIqz6V8ZRIdZjgtm4C27NKF/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOiO32DZP4wYlT4PEJTvH58fRyW5qf/MyARbE9UrxNE=;
 b=jbJE33ur0L3lbvSWp+dXFHzYcFPK5W9348jNemc8SWFplhn4lkaR+LhjqQm+KnKyBRKbKbY68Wz9uw8WF/aXLqvKEfzBGRJ0dtiJi2i88XSfSN8gEXmIsu3SAN9xI7Uohd2vjjJYoDtwXZkUG4CkShqIRRUCFCJ8Fz8nDclmViw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 05:26:08 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 05:26:08 +0000
Message-ID: <ce777a44-5c0e-27c8-fbeb-d3dddf037635@amd.com>
Date: Thu, 2 May 2024 07:26:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 05/14] drm/amdgpu: create MES-V11 usermode queue for GFX
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-6-shashank.sharma@amd.com>
 <CADnq5_NJy9NB8eohN65s5EcnSVpLJ+xjtp1VMgQTGH_r-GtC0A@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_NJy9NB8eohN65s5EcnSVpLJ+xjtp1VMgQTGH_r-GtC0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eac3f3e-aa71-45e2-4ff4-08dc6a685f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlRnbzh3NVdlejlaRjZ3TkErVGN0UUVJc2kzVkpOOTVHbGpmUzUzeW41N1ZJ?=
 =?utf-8?B?Y2N2K2VtYzNrRE04L1NWZ0ZOR1NNYkZUNFN2VkdEaWdCQTFJcE90R2tRbzVY?=
 =?utf-8?B?NVpOaFJrN0hYRjJ5eGdZMmZ1NjBMcWVaeTlwcExZc005OEU5NHBueUkzRStt?=
 =?utf-8?B?VytMcDgyQms4NzhnZjhQQjBmZlNSTmpoK1RYQ1VidVprR3BLTktXMlhrSXd2?=
 =?utf-8?B?cWplT2pvMnpQUzdPcGZRb3Jabm44dVI5Vy84TUVuQllEZVB5Z0tPRzBjQS93?=
 =?utf-8?B?TWVZaVhSZ1llOHZvbCtxcUdGYllDY1ljSWN1ci81blBtM2I5OXd5TFI5Q25z?=
 =?utf-8?B?NDA5WXlRZFB6TURUSHJCZFU0VWFEeUt5ZHlNdXVRWUJ2V0hiNFY3TGEyMjdT?=
 =?utf-8?B?TS9lSDNRV09NazViZ01rZDZjcHZML3pkMnZ2TUoyZmV5TXVCZjJHTzB2MjFK?=
 =?utf-8?B?ZG1HSVBoZzNtK2lBYWpRWmtxc2JIN1p5d0dOeGlBMGxINmJsenVUZFVPdkda?=
 =?utf-8?B?TFlTQ1pxc2Y3cEZoT282Q0sxMHRXMmRsQ1h1eEhJb1VSUmxPbDhHTEdUYkVj?=
 =?utf-8?B?SkxLZnpyck1Mbk1ReDNRQ0YwRWpKbFdqYk5PZTZzU0gxSEpaM0tJVEVKdjYr?=
 =?utf-8?B?czl4aG9WUTE0bGVMT0FnTG5IcUVPWklqSFBaSnhBZUtsMzEreVVkUElLQmoy?=
 =?utf-8?B?TlA1a3JWNnN4NUxmcXdsSUZGSEpRczNhWE9vdGlaUkwveEJmcURTTmpIdzBz?=
 =?utf-8?B?YUtUMnJvWk1UUGVka1FERy9CSFBmczdUaEMwVU0rUmM1cW13NmZ5Z2pxNURE?=
 =?utf-8?B?UTY1UWR2OWw5bDR2UE5kZGNxRy9HMmxQbm5uWWlyZEtqeDdLZFpaZmZaZDVO?=
 =?utf-8?B?d1F6WlJVYUhvZlJMY1BEOHdjNFdOZGt5M1h0cUsyWG9ubjBEem1yYTlrMjlm?=
 =?utf-8?B?aGliclZ1TEhXTTUzVTJMOHowK3pOOXNuYXcyKzNneU8vYmxDa0ZidDVTMkxo?=
 =?utf-8?B?a3oyR3kzNXR0TE1TRHJ0eDV0Y3VEbFlJY3lyMTU3WmFjWjQwWW5GblF2Tk03?=
 =?utf-8?B?Wi9sMXdWOGhmYWJoYjBFcnE4dzR1N2cyZlRGQWtFYU9EYnhBNEFodllhRFJ0?=
 =?utf-8?B?OVBLazFrSEl6RWp3ZDFtOXljZnk4clpOTllSczVZSWZxbjFSUnVFa1JIRUpD?=
 =?utf-8?B?RXc5cVJ2cHYyei82UWpPVzhCNjJVcUFIRXJDSHpWc2tOWGVuS1dWekRNNml2?=
 =?utf-8?B?NnBDNEVENCt1MmxPWThrU3ROL2FyYzVRZjBOL0E2YUovVDZid2grY0VQRDFt?=
 =?utf-8?B?WG5VU3psZ3pWbTlyNlpRTWJYNXo5aFM2bFlreTA5bmJGd1Z2ZGpTeFBwalJt?=
 =?utf-8?B?YmgxbVBRblZTZmp3NnV4emhZYnJVRFYzeS9KbzJJVmY3cUdaT25CWkhDTGZ1?=
 =?utf-8?B?ZzNic2E4RU42U0t2MllkN2xOY2gvN2kvdnZRTHlXZUY4OU5DSExzeEp1bFhv?=
 =?utf-8?B?aUlOWWZXYitqYlFheHBYd2Vnb0dtbUNpYWhvdnM5em5LejdsTEl4dDNHZXhJ?=
 =?utf-8?B?ZkRjMGttR2sxeVVSWlBERS9yMEliakZLb0tjRnB4TzgwejZxMklacDMybThT?=
 =?utf-8?B?Q0VweU9LSklmZ2R5R0VrcWdPalIyeERObUQ2bGd3QVBvc1ZBV3BFNWtmOVVj?=
 =?utf-8?B?c25MQzlFWmlJOXJxYXNUUEhYM1ByeWZqOThJeEhJVzJLL2ZiYW03QjlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tJV2M3cllCYURNZVBXelVkWjUycWp0K01pNzRydXhOVFcxTG5jUDhQdmJN?=
 =?utf-8?B?UE1EbE4yRC9TTCtDRmN0T2FWVU1oUEZzam5HKy81dUtTaUk1eXdqaUFQVEdZ?=
 =?utf-8?B?TW9qWlhiQlo3U3RYaVBWTUlXR3JhYnJycnVzWXd6bEpLS211OHlCa1BBQUx0?=
 =?utf-8?B?Y1pFenJXS2hEbG9mOEpNbm5TdE1TVkY3bnAvWnhncDBqNFVqbU0xZ0NBZ0Z0?=
 =?utf-8?B?QnBxQUZVa1NVd1J5SVZDSU1wdEV2ekViRmtITk9jWWQzbWtqVDQ2VXJYbWNG?=
 =?utf-8?B?QzAzTy92cHJnN2JldjlBQzBlQVFheUFJR0VmYzNKWXZTbEpMSzhuQUFuMDkr?=
 =?utf-8?B?NkFzVUZaMXowV2Uyczc3RFA4WXRVQlJpUE9oMHBpZDNpaGJ1Rm1ZZWswckpr?=
 =?utf-8?B?RE96WkFwVVNtOEpETit2UTd2WFIzMEdXY2d0Q2diWWM4d3ZSNzNvWmw1Z1Uw?=
 =?utf-8?B?Um5sYkw2SG5BbkI3c3hQNFV5VzlJYTRqVVp4aGJkTk9CV0F3S2ZObzFvUEk0?=
 =?utf-8?B?NkhmZ3kzQkNoTk12bXRGUmUzdmFic0VVdVF0WGFxblR2SFF0T1NQWW1QUXR4?=
 =?utf-8?B?WU9zRkxtcThaUkFIcC84Ukg1bWpDdllaNUlTN21NK2I0UVhZMFVMU1RMZFdK?=
 =?utf-8?B?R2p5SHZuemtKQXQ3TTZCZGFrUnVTSm42OGhuNmsxY0xIVVpXRUJ5TzdYNVhL?=
 =?utf-8?B?RG5Bb1M4ODd0Q29TMzJpcTdKOGlja1ZkZnlZYkcyWE1rUDBjL0JMKzdTcVht?=
 =?utf-8?B?ckd5YkVGc0tGS2hHWHJ1NXZzT0hYSU9Yc3duVmdvNndoenQ3MHFFdFBlcVYy?=
 =?utf-8?B?eUlPNGJjTHZYRG56RE1BWlhySmVOTnh5eEw1azZhL3JycmE0Ukl2WjRONU9F?=
 =?utf-8?B?M1N4TGhyeVRSNzJKNVpXeXN5ZDZmbS8rQ3loOE52L3Y4dUY3Sml3bkdWNlRH?=
 =?utf-8?B?eFpqUjU2b0Q5dFE4RnNBVlZNeEU1WUg2TFhZY0IybzE1WTN6WTZ5Ly93TU1t?=
 =?utf-8?B?dEU4V3NMS0gxOUZxMGR2dVZ0RVlKSEJKVS9LMXRJNndKWTJYY0t0alY0aE5I?=
 =?utf-8?B?ckZYVXRLS2F6cWE4QVl6OWJGNUpLQ2dYOGEvQUFBMGxBdGNMZFgzT25uMktU?=
 =?utf-8?B?SjFBVEFSeHlpaks1V3hqamtBWXYxWTZTaUVwN2JUNnZZemhNWlRxU0lyVFRw?=
 =?utf-8?B?NTA5ZGxXVVY3YTBDVk5GQTdtTVhtOUZTV3dmWHFCVFp6SUpHV2hhNGxyak9I?=
 =?utf-8?B?N1hiSUQwcWlxZnFkYzZNUS8zTWU0RWpNby95MkFSMlBTZnlscGVxVVYxRHRD?=
 =?utf-8?B?QUJXK0dsTHV4d1QzWXlyOHZXQ3MybURsZkJGaFF2RHluck9NbXlxM1NlcWt4?=
 =?utf-8?B?QmViRUR6em45ZGE2dTNmTDBBL003YnI1aTR4U1QzeWxOYmJtdjJhZ042Umtu?=
 =?utf-8?B?UEhtMU9ocS9ZbzFGN2RWMUtuaERjK0ZHVzJuN05kS3AyOUFKUythMUQ2enQ0?=
 =?utf-8?B?S2k2NFBrT2doQ2lxbDFBOVFXZ1M3bWQweXZGT1RNOWdsQmxIdkhrSDBlZjJs?=
 =?utf-8?B?M2puMm5FcTVnNzJld1hDRXZiVEFhRlNmKzJVRmFETDZ0UjBqMGY4Zm9nSmRn?=
 =?utf-8?B?dmowWFdwRXRZRlpSUzN4SlE0MW9vdi9JSm14LzN4bUJIVXA5WXR0S3dseVpH?=
 =?utf-8?B?cmdYWmNVQnBiTEI5YVp6WUVqaW5LZC9EeEQxbjBBV09hdm5BMGJCVUhodlBZ?=
 =?utf-8?B?dTUzTERCOXZrQmJpRkNTa2J0bmlwcDJhY1hULy9UVE90bzh2T3ZwdHlCcGRD?=
 =?utf-8?B?V1BWZnlNNHgvblNRWWx3ZGNoVHRHYXdGc3lBdEhKbFVQUms3bUtkSkw5Y1dt?=
 =?utf-8?B?UjcvRzg1Uk9yQW8wL1RwRGx6Yk5FdG92UkxGR1Nka3hJc0E1cExGUytqL0sr?=
 =?utf-8?B?RGNXai9MbFZxSUNnb0VMWlh5QklQZnN0MWdLRGpKb1pLQXdNdGl1bm11cDVL?=
 =?utf-8?B?bHlRbDNldkxnVVZiRDFURGxTOGIxUFY1d2xzUDROQ1plTTE1QVA2MFZzd21P?=
 =?utf-8?B?bk1aN3JpZDN3NXVZOEc3T25Gc0Q0L09RaDNSZHZYZVJYTGk4Wkc0YWdHQ3Nx?=
 =?utf-8?Q?Ze5qegCuSy4qTypDXFOs9WV4r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eac3f3e-aa71-45e2-4ff4-08dc6a685f0a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:26:08.5876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9SCBAsJztmpHGoI8SF2DkILEWSe8bptmD9dkxUuZ6NbqPCawM2+lqjMcsJOgbHAd440PKGTe1epZxL8swO8sw==
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


On 01/05/2024 22:50, Alex Deucher wrote:
> On Fri, Apr 26, 2024 at 9:48 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> A Memory queue descriptor (MQD) of a userqueue defines it in
>> the hw's context. As MQD format can vary between different
>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Adds a new file which will be used for MES based userqueue
>>    functions targeting GFX and SDMA IP.
>> - Introduces MQD handler functions for the usermode queues.
>> - Adds new functions to create and destroy userqueue MQD for
>>    MES-V11 for GFX IP.
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> V4: Review comments addressed:
>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>      - Align name of structure members (Luben)
>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>        message (Luben)
>> V5:
>>     - No need to reserve the bo for MQD (Christian).
>>     - Some more changes to support IP specific MQD creation.
>>
>> V6:
>>     - Add a comment reminding us to replace the amdgpu_bo_create_kernel()
>>       calls while creating MQD object to amdgpu_bo_create() once eviction
>>       fences are ready (Christian).
>>
>> V7:
>>     - Re-arrange userqueue functions in adev instead of uq_mgr (Alex)
>>     - Use memdup_user instead of copy_from_user (Christian)
>>
>> V9:
>>     - Moved userqueue code from gfx_v11_0.c to new file mes_v11_0.c so
>>       that it can be reused for SDMA userqueues as well (Shashank, Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
>>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 110 ++++++++++++++++++
>>   3 files changed, 116 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 05a2d1714070..a640bfa468ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -184,7 +184,8 @@ amdgpu-y += \
>>   amdgpu-y += \
>>          amdgpu_mes.o \
>>          mes_v10_1.o \
>> -       mes_v11_0.o
>> +       mes_v11_0.o \
>> +       mes_v11_0_userqueue.o
>>
>>   # add UVD block
>>   amdgpu-y += \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index f7325b02a191..525bd0f4d3f7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1331,6 +1331,8 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
>>          return 0;
>>   }
>>
>> +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
>> +
>>   static int gfx_v11_0_sw_init(void *handle)
>>   {
>>          int i, j, k, r, ring_id = 0;
>> @@ -1347,6 +1349,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>                  adev->gfx.mec.num_mec = 2;
>>                  adev->gfx.mec.num_pipe_per_mec = 4;
>>                  adev->gfx.mec.num_queue_per_pipe = 4;
>> +               adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>                  break;
>>          case IP_VERSION(11, 0, 1):
>>          case IP_VERSION(11, 0, 4):
>> @@ -1358,6 +1361,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>                  adev->gfx.mec.num_mec = 1;
>>                  adev->gfx.mec.num_pipe_per_mec = 4;
>>                  adev->gfx.mec.num_queue_per_pipe = 4;
>> +               adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
> Does this work on APUs yet?  If not, we should limit it to just dGPUs
> for now.

I think if we get an APU which is GFX_v11 based it must work on it.

>   Also, we should add minimum firmware version checks for user
> queue support.

Noted.

- Shashank

>
>>                  break;
>>          default:
>>                  adev->gfx.me.num_me = 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> new file mode 100644
>> index 000000000000..9e7dee77d344
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2024 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include "amdgpu.h"
>> +#include "amdgpu_gfx.h"
>> +#include "v11_structs.h"
>> +#include "mes_v11_0.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>> +                                     struct drm_amdgpu_userq_in *args_in,
>> +                                     struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
>> +       struct drm_amdgpu_userq_mqd *mqd_user;
>> +       struct amdgpu_mqd_prop *userq_props;
>> +       int r;
>> +
>> +       /* Incoming MQD parameters from userspace to be saved here */
>> +       memset(&mqd_user, 0, sizeof(mqd_user));
>> +
>> +       /* Structure to initialize MQD for userqueue using generic MQD init function */
>> +       userq_props = kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNEL);
>> +       if (!userq_props) {
>> +               DRM_ERROR("Failed to allocate memory for userq_props\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd)) {
>> +               DRM_ERROR("MQD size mismatch\n");
>> +               r = -EINVAL;
>> +               goto free_props;
>> +       }
>> +
>> +       mqd_user = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
>> +       if (IS_ERR(mqd_user)) {
>> +               DRM_ERROR("Failed to read user MQD\n");
>> +               r = -EFAULT;
>> +               goto free_props;
>> +       }
>> +
>> +       r = amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
>> +       if (r) {
>> +               DRM_ERROR("Failed to create MQD object for userqueue\n");
>> +               goto free_mqd_user;
>> +       }
>> +
>> +       /* Initialize the MQD BO with user given values */
>> +       userq_props->wptr_gpu_addr = mqd_user->wptr_va;
>> +       userq_props->rptr_gpu_addr = mqd_user->rptr_va;
>> +       userq_props->queue_size = mqd_user->queue_size;
>> +       userq_props->hqd_base_gpu_addr = mqd_user->queue_va;
>> +       userq_props->mqd_gpu_addr = queue->mqd.gpu_addr;
> We should validate the user virtual addresses and make sure they are
> non-0 and not part of the reserved areas of the address space.
>
> Alex
>
>> +       userq_props->use_doorbell = true;
>> +
>> +       queue->userq_prop = userq_props;
>> +
>> +       r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
>> +       if (r) {
>> +               DRM_ERROR("Failed to initialize MQD for userqueue\n");
>> +               goto free_mqd;
>> +       }
>> +
>> +       return 0;
>> +
>> +free_mqd:
>> +       amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>> +
>> +free_mqd_user:
>> +       kfree(mqd_user);
>> +
>> +free_props:
>> +       kfree(userq_props);
>> +
>> +       return r;
>> +}
>> +
>> +static void
>> +mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>> +                           struct amdgpu_usermode_queue *queue)
>> +{
>> +       kfree(queue->userq_prop);
>> +       amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_mes_v11_0_funcs = {
>> +       .mqd_create = mes_v11_0_userq_mqd_create,
>> +       .mqd_destroy = mes_v11_0_userq_mqd_destroy,
>> +};
>> --
>> 2.43.2
>>
