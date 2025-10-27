Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52DFCCF9EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 14:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AF910E4BB;
	Mon, 27 Oct 2025 14:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pRm7Hp67";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6A710E4BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 14:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko2QQUiu1g0r6ofWrWYFjjHHa/JMAp2W+RZ8cFnDwp1dionZ2PamsnRhCziteZNJcQT2sink2OTqrqtUOSOO1Atmw3Ze21nWPZr2JBWFap6rbvTx/yjCb7VJ1tWMbkSZ5xRyO3WF0Zgp1OkUEyS5kwW8Ask46ap4dWqWpo6F7lRrSXYF/Oqk66/+zKeFuBxjds7K9MAMX0rtRgVlRoMKyrfD1nXBnnuz42ejArHSwsNW8sVk3cgrYjPXXVrz/g0llA5ha79i/6tS2zRiA0DRTf/T7lIwqxsMFDdR/qFbhsbwCfSpfEYj5CUYxm+hUqShVLtH5eovuwwKj2xNrmcPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTHAJ1OOaqVAZU0kbVxaq6IS2yYEbohpX8HMEQxPitU=;
 b=pH6mARyRJnJwb4vSHaaM8BQcAwCciZWSILudqDZO/zySOk1ti7k/gWyr8f6FrsMj3rrHn6ZsAFAxWOKyOwmqlT8j+oGRIvxw84Ij6wb+l0QOQQ6KTGSs2ciaWktuy5xQH4x0w1lD+PD3LFEVLn0D3YcsNKW34YnG+89/ZY6xO3WdP/6GGCrPuMq2tD7Zrbiclp/gEhGyRWTimczxkpi84CRk+q3WtsLaGGNXoeW6PvnsDM0bPEatHYx/PbWZQllBIUPK9taxH+xIQBszPKNIHqg2hgkUsmaHyhjKWO+++IW741h/kc/jAIlg8M+8BgKuP8RGk7ssvAvbB45jJYMsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTHAJ1OOaqVAZU0kbVxaq6IS2yYEbohpX8HMEQxPitU=;
 b=pRm7Hp67WvCK6dx+cf1LY+8JUarl6l4PHuJWPy6km+jjQ6CijqcYo9nrxb7PcvAW6pSIKSo0PwmsssP7uU3PEIouX7QQcDvkYknqGjXD+/Gj/Z8EtTPvEwBoXEiPq8hVaR7n2GLySbS6leeUHfHYsfDPoMWWzI2avS/eiK33bUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::607) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 14:40:17 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:40:16 +0000
Content-Type: multipart/alternative;
 boundary="------------nQPZQY0UIZzqQ0q4F7T40007"
Message-ID: <9976ad6b-2276-40d1-9479-7fe06b9bcb6a@amd.com>
Date: Mon, 27 Oct 2025 20:10:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: null check for hmm_pfns ptr before freeing
 it
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251023065848.1664757-1-sunil.khatri@amd.com>
 <dc5cbf60-d73f-4590-ab7c-0ac3e919fb5c@amd.com>
 <a1c87ae7-9f8d-4fb7-a141-c285776d76b0@amd.com>
 <f8ccd8cb-8ef3-4c6c-b512-a469da7f5512@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <f8ccd8cb-8ef3-4c6c-b512-a469da7f5512@amd.com>
X-ClientProxiedBy: MA5P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dcfcaf-bad6-4330-cb07-08de1566be4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEdWMCtCTVIrYkdBU2FsTjc4ZGFhUVA1SWJKekhVdG5XTGN1YzRHRlp4SVBN?=
 =?utf-8?B?Sk4ySGhmTEtaekMzOEoxbDE0QWRLNklaMjd2cWFQczkySGJtTEN2MW9LN2Z6?=
 =?utf-8?B?anl6MXd3L25Lc3EyclNtRlAzNjR0eWZ0OTNjR3lFYzkrdUtHNEJoMWtVNzgz?=
 =?utf-8?B?cG8rMGEzRnJNRnlteUQwVUVmZlRWT0RVdTQ0bWFWMmsvOGpJN011bG9Vb2s0?=
 =?utf-8?B?c2o2cVlYbDI1UjdxM0IyWlp1WEFHUExLSHFUYm1leHpmZ214eDFTY25ZTmlv?=
 =?utf-8?B?R1NNaXREMWtJYVY3ZjVPa1NJbUZMV3N2cTR2MTZxYnRUUnVoKy9DTWQvMEJ6?=
 =?utf-8?B?Q29YQSswRVQzZU5HY21PTU1BT1IxNXNqaGpQWk9wVHFXZ3NRbHZSMEEyT1dh?=
 =?utf-8?B?SEZqOW1nMHdDaDNjdkFGNy9XazlTV05wbEhTUWNJcTIwS2szckswRnExL21J?=
 =?utf-8?B?Z09kVG1jSnJOVDYxc0lyMFpvQWE0YW5TVXJZMmFKeFlVN01DZzJMQmpXcHpx?=
 =?utf-8?B?S0E4UGZPM0dFYlA5d0xYTEFiQnUxbkRPYWhsMjF1T0Jvei90bTJWN3Y1cTNP?=
 =?utf-8?B?Mm4zTTJEZG5KNklZSXhVVVFPYnNxSjkwY2JzWE1ZS1plc2RPcG14VHliNnFR?=
 =?utf-8?B?Vk1OMFg3bzI3bU02V3c1T2NwWjN0cm9mdmdrd3hPaU4vWS9EMTR3aWNjYUVT?=
 =?utf-8?B?S1djU1dnRXE3amJxeTQ1V0tNb2VSSEpZY3k3YWhwdGRmNVhscCtrRVlQS1U3?=
 =?utf-8?B?OVdnNncwRVNvOC90K09KUkp6LzNIUCtnNHA3WTlZVlE0QUVFWmZNS0ZTSis2?=
 =?utf-8?B?QzhNZ0FDVWZCeW1VSGtIL0JVNmJIMVgwVTZ6NmJObUI1MkZsdlVsazFNOWlK?=
 =?utf-8?B?RS9hMlFTbElNdkV5TG5jZFFYditqSDhZMHE3Sm12OEZkeVlsMWhkcEtJU2lG?=
 =?utf-8?B?S1RITlorT0VHR0FCcm1Takp2TDA1MHprMGl2dFhmN0pJcUJoRVJQeHUxczdU?=
 =?utf-8?B?azhwTFp0YmcrdmxwS253SDZoL2FOVTloZXNLd1dKRzZFWUtzNXlmOFdMZ1NO?=
 =?utf-8?B?c2g3TWg1S2JjZytlbWt5dWZjUU1pOXVndXBDNnpqb0FDUFJ3WTVyR3NYMU40?=
 =?utf-8?B?Q2F3T3h1NDlRZTlmNy9KeWZMRlo3WjNIeFdWaHhwNzUyZkpKMCswM0dGekZa?=
 =?utf-8?B?WjV1VmZheXRjV3FkZ25GRXFXbTJybmE5Z3J2T1NFSmpBTEhKdnlORVVhWEZz?=
 =?utf-8?B?dFAyRDcvb28zYzdUWTRpcXhJL1B1dTBsUWNnV29CbThsVzNadG8ya3pKQ2JC?=
 =?utf-8?B?Q2RTRXdLdDFoMlNTN2FGdUgzYXA5Qm03b29lS3ZhSmdMUThaZ0NCL1h2MTNm?=
 =?utf-8?B?bExZY1ZGL0FubEpVSHRwSXZiZXUrdFZQMTNNRjZOMDQ5ZkY1OWNxVFpieWNa?=
 =?utf-8?B?YU81ckhzZ0c0SHFQV1dDYXdEOUNaeGpXQlNYTVJaRHRIaENlajA0ZG91M1N2?=
 =?utf-8?B?WlRDMDlxdVhCK3NNWVpGeWdKcGFOL2prM01KYXFBeU1YaktzTGM0M1E5amcv?=
 =?utf-8?B?UUlBb1pZaU9US1gxd2F5ZC90OVZ3YTN4NkdaV2s2VFNRa3czaVl5NG5wVFZm?=
 =?utf-8?B?WDRIbUN2WUpQMDUrb29nUnU2TWxjbWxtSEV6MFNIWjVtczMzRmRucXVFb0h0?=
 =?utf-8?B?WnhENHVRNVJUdVdkNC93ZkxxMi9YRXl2c2tUU0l4ZnBUS1kvcmN1NmtzNHNu?=
 =?utf-8?B?QSswMU5OV0pDckZ4MXIycHBRd1dtaXpqZHlqZmNrQWhWOWY5Y0hzNUI2SHRF?=
 =?utf-8?B?SGUwMm5ORGx5VHg2amJTalJPdW5tSzQzZU8xZ3VCQllQNklhNVlRUXE3bkFM?=
 =?utf-8?B?TWJ1MWlpeDFacElwWnRndkxkYWdvcGs3ai9JT3lSLzB6TGh5ZWhpb1kwYlBG?=
 =?utf-8?Q?QBDuxwE71MMm705/mxmDhLOdKS5o2IRu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVQTXFiQUR5Znh1ckJ1L3FwVG1TN1pna1hQNkliUFlwYkc5U3Y1cXdyd3hw?=
 =?utf-8?B?VHlKb3JYZHVsMHFpRXRKY1FiNkZjbVg1TjZiTTVua09sSGtXZy9uUlIvbGxl?=
 =?utf-8?B?SElBRUFVaG5oTEprMlFUeXVHWTZSNW9WK2t6ZENmam9kSGhXUXR1K01JMkFr?=
 =?utf-8?B?eGlqYU5vM2F4WlhJbkVtbERJT1pzRS8vRUlPb3BPTWpjbmxValpMOFg4c0hJ?=
 =?utf-8?B?ajZNWnVML2pjSy9SbTNiK0tOM294eXY3OHlVOGJtaFZCWmgrZ1Y0bXBIek1X?=
 =?utf-8?B?Yi9kb3EvOWxXUjk1eG5lSi95MGloZXROQ01FWE1GOUVRV2Y5WFBKMXd2bVFk?=
 =?utf-8?B?UWlpT3dGS1VzUjZma3BZWUtoTkF0WHVHRFM1OFcxS25uUk5GZ3J0V0lCY0c2?=
 =?utf-8?B?TVdnK3V6Sis5RWpJaEdxeGhwZGFIeVgzclduL2lybzVSc1YrMDVIZlhOU01Y?=
 =?utf-8?B?cUJhQ3NwUHNMcnpacEMrUWlPemNMOTg0TTBwZGltaXM1dnNoNmxwTlBNYmtz?=
 =?utf-8?B?ZEZ1N1VEZU94ZCtpRHZ6YS9Reis2eURTZHZrWENYeWZqZlgvcXZPT1MyTUpk?=
 =?utf-8?B?cmxpM01ObHFnN3B4cVkvcEFuUTBVNlpnWDNSV3c3S2lUV29VMFN6eXFuWEJO?=
 =?utf-8?B?ZXRGb3lmTkdLUXBMTVpIVlphTmc2c0c4VjVQeTRGSmNuR1NMOTFrbEV3THVh?=
 =?utf-8?B?SXFzRXJBUnV6NmZhUVR4RDJFb3dBOXJWWkhiVmFIS252Q3RTTHhpbmROMDJw?=
 =?utf-8?B?NjgvaURZaHhITWhZNEVGbVkwZWNDVERoRGdKajVvREg5VXU4cE1IZ1J6QjM2?=
 =?utf-8?B?bmNDTDBqd3lXdnk5T2o0TEc4TENhS0JJYzFBd2gwVlkzWDVscW81amR2Njcx?=
 =?utf-8?B?MzBJSXJ1VG1XbmZDcGRhSWN2WlNFZitmVm5KTllWalJ3SHpHUTJ4ejZQc05h?=
 =?utf-8?B?NUtSYkdvSzVzamE3NEFlODJoRThObGNtOGxMM2lNc214eU9GeHJoR1FCVTl4?=
 =?utf-8?B?VDBQdUVLajRjOGxwblIvN3ZtWXRBOWpKSEVVN2I1aWZQNWNMWXVrQnJKQW9i?=
 =?utf-8?B?cEhwdmxIVDVyZVoydVdHeWk5SkJZMWxqY0pUMGYxRytiZTR5K3QyZjBYazJu?=
 =?utf-8?B?OXRWbFF2WDM3T3dsd3AxcUUwS3Bud0ZZbzRIWkJ5RDZ4TWpVeDVsUWpmajRG?=
 =?utf-8?B?ejVSTEt3Wk9oMklyM0dkRnhuYWJ0ZlVQNmRtZ3d1UHlaL2NkSHd0R0hnakFF?=
 =?utf-8?B?Y1R2NVRsN0ZGUUNtMFNIZ09vc2lTVk52OEU2ZVQvNjJPVXptK3RpWllHN1FO?=
 =?utf-8?B?bFJnWTlaWHFDNjhjczJvRnBwK29VSjRjanhkdk1oRjQwMlhJTlNCdVZtN2Vm?=
 =?utf-8?B?Z3FCN0U4TDJRdnNPZDl1UHhnb1ZjNTlpeHZQcTJId0YzK1FSNEd1NUJjc2dI?=
 =?utf-8?B?WnFLRVdKNVZwN1BiTHh3cWRkVDFzUzFsM3NmbVNsckJmZVFTZFpmVHZoL1ZT?=
 =?utf-8?B?RUMvdCs2cnhFU1ArSm92V3o5blYzVFVrK1VzbE9KUVZqRTVoc2Zmbit6OHdo?=
 =?utf-8?B?TjY5R0ZDYlZtRENsekFBZXZJQmFIY09SUXFITitHQVpIdlNKQ0V5aEFyMEtz?=
 =?utf-8?B?TWtKT0ttTmxtWTRUajE1MU1yMksyZmFqY2s0TVltTWJJMzV5TGFvTHhKN2pJ?=
 =?utf-8?B?cjhSeW9VeXJIMVVMckt4UDRzWjFQdEh5N3BLNk16SXZlWDM4Z09CbTVjTW5i?=
 =?utf-8?B?ck5pL3Y3SlhyU2ovb3d2YmhRUy92ZUxvVHJ1MDBRVnU5Qk5HaGw4Um10cjdW?=
 =?utf-8?B?Y1VwQmx4L2M4elRCMndpbUlBamNyNEJOaUk2RUswZUhzTFJKS1RPWFhIa3Bw?=
 =?utf-8?B?NjJFbit1UlpkRUNPUTlDN3dwejI5R1FVdVZxUTUzZ2hibHBzSGYzdDlvdDVq?=
 =?utf-8?B?eVJVdHJBdHJoaTV2YTBMOXRtTEhuNzJBS1RLV2ZJVWZTVmlreEg5WldTMVBB?=
 =?utf-8?B?djhkSzQ4czlhV2VwRytYOEJyQVJCdTRiSFdxWFVWZDJ3cXhzWnRwdVpoMzZG?=
 =?utf-8?B?T0ZEckgvSXl0dURaS3BIZjR1bEQwN052cklpS0dreE1vY3pjQmZwNTVVKzZp?=
 =?utf-8?Q?MMtXvomPvEpvkaLVK1lxi6bTb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dcfcaf-bad6-4330-cb07-08de1566be4d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 14:40:16.5439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91yWEU7vEWnaC2+lc5beEI1b+HQkgRJQT8fhD5Zys5HpdYQrnCwyCxHWW3xrtr/+uYDYYjOYoL+ktp/2Fuh1Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0
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

--------------nQPZQY0UIZzqQ0q4F7T40007
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 27-10-2025 07:58 pm, Christian König wrote:
>
> On 10/23/25 17:30, Kuehling, Felix wrote:
>> On 2025-10-23 03:48, Arunpravin Paneer Selvam wrote:
>>> Acked-by: Arunpravin Paneer Selvam<Arunpravin.PaneerSelvam@amd.com>
>>>
>>> Regards,
>>> Arun.
>>> On 10/23/2025 12:28 PM, Sunil Khatri wrote:
>>>> Due to low memory or when num of pages is too big to be
>>>> accomodated, allocation could fail for pfn's.
>>>>
>>>> Chekc hmm_pfns for NULL before calling the kvfree for the it.
>>>>
>>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> index d6f903a2d573..6ac206e2bc46 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> @@ -286,7 +286,11 @@ void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>>>>        if (!range)
>>>>            return;
>>>>    -    kvfree(range->hmm_range.hmm_pfns);
>>>> +    if (range->hmm_range.hmm_pfns) {
>>>> +        kvfree(range->hmm_range.hmm_pfns);
>>>> +        range->hmm_range.hmm_pfns = NULL;
>>>> +    }
>> NULL-checks before kfree and friends are unnecessary. There are actually static checkers that complain about such unnecessary NULL-checks. For example, seehttps://lkml.org/lkml/2024/8/11/168.
>>
>> The same is also true for the standard libc free in usermode:https://stackoverflow.com/questions/1912325/checking-for-null-before-calling-free.
>>
>> Finally, setting range->hmm_range.hmm_pfns = NULL is also unnecessary because you're about to free the whole range structure anyway.
> Agree completely with Felix.
>
> Sunil why do you think that this is necessary and blocking KFD for some reason?
>
> Regards,
> Christian.

KFD side reported the error of NULL dereference

pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL); //fails if the 
size is too big.

Now when we free the memory in function amdgpu_hmm_range_free and try to 
do a kvfree of the range->hmm_range.hmm_pfns which is NULL and we were 
seeing the NULL dereference.
So i added a check to check for the memory to be valid ptr first before 
calling kvfree.

This actually fixed the issue but i do agree that *"setting 
range->hmm_range.hmm_pfns = NULL could be avoided and that why i did not 
added that check in the final patch that i merged" This is the final 
code after this merge.*

voidamdgpu_hmm_range_free(structamdgpu_hmm_range*range)
{
if(!range)
return;
if(range->hmm_range.hmm_pfns)
kvfree(range->hmm_range.hmm_pfns);
amdgpu_bo_unref(&range->bo);
kfree(range);
}


Regards Sunil Khatri

>> Regards,
>>    Felix
>>
>>
>>>> +
>>>>        amdgpu_bo_unref(&range->bo);
>>>>        kfree(range);
>>>>    }
--------------nQPZQY0UIZzqQ0q4F7T40007
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27-10-2025 07:58 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f8ccd8cb-8ef3-4c6c-b512-a469da7f5512@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 10/23/25 17:30, Kuehling, Felix wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 2025-10-23 03:48, Arunpravin Paneer Selvam wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Acked-by: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>

Regards,
Arun.
On 10/23/2025 12:28 PM, Sunil Khatri wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Due to low memory or when num of pages is too big to be
accomodated, allocation could fail for pfn's.

Chekc hmm_pfns for NULL before calling the kvfree for the it.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++++-
&nbsp; 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index d6f903a2d573..6ac206e2bc46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -286,7 +286,11 @@ void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
&nbsp; -&nbsp;&nbsp;&nbsp; kvfree(range-&gt;hmm_range.hmm_pfns);
+&nbsp;&nbsp;&nbsp; if (range-&gt;hmm_range.hmm_pfns) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(range-&gt;hmm_range.hmm_pfns);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hmm_range.hmm_pfns = NULL;
+&nbsp;&nbsp;&nbsp; }
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
NULL-checks before kfree and friends are unnecessary. There are actually static checkers that complain about such unnecessary NULL-checks. For example, see <a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2024/8/11/168">https://lkml.org/lkml/2024/8/11/168</a>.

The same is also true for the standard libc free in usermode: <a class="moz-txt-link-freetext" href="https://stackoverflow.com/questions/1912325/checking-for-null-before-calling-free">https://stackoverflow.com/questions/1912325/checking-for-null-before-calling-free</a>.

Finally, setting range-&gt;hmm_range.hmm_pfns = NULL is also unnecessary because you're about to free the whole range structure anyway.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Agree completely with Felix.

Sunil why do you think that this is necessary and blocking KFD for some reason?

Regards,
Christian.
</pre>
    </blockquote>
    <p>KFD side reported the error of NULL dereference</p>
    <p>pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL); //fails
      if the size is too big.</p>
    <p>Now when we free the memory in function amdgpu_hmm_range_free and
      try to do a kvfree of the range-&gt;hmm_range.hmm_pfns which is
      NULL and we were seeing the NULL dereference.<br>
      So i added a check to check for the memory to be valid ptr first
      before calling kvfree.&nbsp;<br>
      <br>
      This actually fixed the issue but i do agree that <b>&quot;setting&nbsp;<span style="white-space: pre-wrap">range-&gt;hmm_range.hmm_pfns = NULL could be avoided and that why i did not added that check in the final patch that i merged&quot; 
This is the final code after this merge.</span></b></p>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #569cd6;">void</span><span style="color: #cccccc;"> </span><span style="color: #dcdcaa;">amdgpu_hmm_range_free</span><span style="color: #cccccc;">(</span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_hmm_range</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">*</span><span style="color: #9cdcfe;">range</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">{</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #d4d4d4;">!</span><span style="color: #9cdcfe;">range</span><span style="color: #cccccc;">)</span></div><div><span style="color
 : #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">return</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">range</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">hmm_range</span><span style="color: #cccccc;">.</span><span style="color: #9cdcfe;">hmm_pfns</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #dcdcaa;">kvfree</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">range</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">hmm_range</span><span style="color: #cccccc;">.</span><span style="color: #9cdcfe;">hmm_pfns</span><span style="color: #cccccc;">);</span></div>
<div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #dcdcaa;">amdgpu_bo_unref</span><span style="color: #cccccc;">(</span><span style="color: #d4d4d4;">&amp;</span><span style="color: #9cdcfe;">range</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">bo</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #dcdcaa;">kfree</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">range</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">}</span></div></div>
    <p><br>
      <span style="white-space: pre-wrap">Regards
Sunil Khatri</span></p>
    <blockquote type="cite" cite="mid:f8ccd8cb-8ef3-4c6c-b512-a469da7f5512@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards,
&nbsp; Felix


</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;range-&gt;bo);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(range);
&nbsp; }
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------nQPZQY0UIZzqQ0q4F7T40007--
