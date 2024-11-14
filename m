Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E36D65C52
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 07:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D3410E7A7;
	Thu, 14 Nov 2024 07:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vh+XEW5t";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292BD10E7A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 07:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+aHc3Y2mP3huBcVkdmgX+4Khza7xyOUfgThCJ3cvH7ooNlZVzoXgTYBVliAhLgdUHEM17Kz1aog4NRjmgPUC6nxJ51EfhVX1KQcfXDVFIkqrA4BTPJu/qbmUYbHtkMbav3jxYZgAYMh7TuMv5W8xW7cXrU2PukK5Ziuh7Yofkl4onotaunYNUhI/wnogQfRaHvH1jdR4aQbB/TLgI2Fjf1oA8Ld1pQBInkAu1rX6U9lbXRSnqOFUkCXTzB9qamRoEOMQK0pi2wt4vdywBb9omCWNs2yOnRysEZh/UMqHgh+9IwlTr9ndUmBXpenQ4Sx62GL6zT1zGypmLHj2su/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbiIcN9HVrdXfnAqyYAd1v0TU3w9mrtqcCoZdMfNy60=;
 b=QQGDSUBrlEzx07XZiyiFrtb3MJ6W3VvLKpMGRrsm4Roe17DcHN6+0GY57zpetSIzlaJFP1oC+vUJcBruyJIluCfM6Dzt0S3mUOXLcdjrEYNvdp5HtYafi/3bfK2NtOXXDBzTOfV5L5ohcmbssWVBryIUTWsIDSmuXS5t5UIW8IocWzi78mJnW5LlAUHsRFBrHMsKmqzs7sT3f7zhKnqDMSmcI2zS+NZW22qTeK2kBaLFzHaiNrIO/W30JO5yaO9p2r/Lzj+CixppKwPJLxmWorVsW4CokGKJVFksUGlx1dhq1YkK4lzCWNUZHXjH3ZwK2ZUDzVsGgBvBO0IAKPFWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbiIcN9HVrdXfnAqyYAd1v0TU3w9mrtqcCoZdMfNy60=;
 b=vh+XEW5tpKHDxGq2t2MVpTc/iBUoafjBaOzNFf0JBZXfSG39FctZvvNbaGHsJjkdJwbcg37dahT1pPvGzssZqR5ObKX8gc3ph4G6UNF0436n4c8ZIvojSTy9mzO+uaJIiD8peoT8puULIDTPl4IywwRKLOUAZx3aVcP3wFF4FGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Thu, 14 Nov 2024 07:12:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 07:12:56 +0000
Message-ID: <08bdbcf5-836f-4669-b4d9-00154a59bfc5@amd.com>
Date: Thu, 14 Nov 2024 12:42:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
 <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <7c0bc3a5-756d-4c60-b459-73a2ee910ce7@amd.com>
 <BL1PR12MB5269AC1E12A48107FA87A03084582@BL1PR12MB5269.namprd12.prod.outlook.com>
 <6950b5e1-c283-4029-84e8-7dcc42b16912@amd.com>
 <bef834a5-b7ae-4ef0-bd75-55003d38f4ac@gmail.com>
 <BL1PR12MB526909544DD2302032E2488084592@BL1PR12MB5269.namprd12.prod.outlook.com>
 <0b00a914-0274-4268-9e9f-c2ff3e43da12@amd.com>
 <BL1PR12MB52690ED7A33543722B48ACA6845B2@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB52690ED7A33543722B48ACA6845B2@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c9970f-f883-459e-b41e-08dd047bc36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1ZCSHlXbzNLTm1ST1RSazNVN3lXVndBZ3JOVUhMMHFhSVI3dHJyc3ltSnpk?=
 =?utf-8?B?bTJtbzdEQXNwYzkyOFRkYzZzM0o3T0xCZnR5NzJvN3g3SEZweTlOZHg5YlFO?=
 =?utf-8?B?aXBYbS9VWHJXREJMUVJZSWRXV3NEdDBlVGlEZDJHTDN6d2tjaFFsV1dQTUFq?=
 =?utf-8?B?Z2xuOTEzZXRvYXI0SExENXVpcUg2SWNBMUFla2RLUndJUDFidXBCM0NiaFNZ?=
 =?utf-8?B?dmdrMkdRV3pYTzVXOHNxMEJycTFoTDh2L1R1SEI3YmVzQlM2Qk85dlRhUFgw?=
 =?utf-8?B?UFROTVRXUG16M0J3bnBkakx1aFlRNTY3cmR6dVNHQWw4YzNRa1NSNisxK0Rl?=
 =?utf-8?B?TDZMSHFnbDNCWGVGTE9EVFpmc0sxSUNEYkhOZXlhb2YzZXJIMWp6RjBUUXIz?=
 =?utf-8?B?QWwxaUhLMTE1TW8wdTNTYmNlbEMyS2d3elhuUWRLWWlaQlRaNDZaaVZCYmFy?=
 =?utf-8?B?VTFIY0dSaDMyVjJQQ3hDZGs3eEx5VHdhUmhiSldBSFZLRGh1V1paOWkxdnQz?=
 =?utf-8?B?RTZqTy9QeGMrL0JNT1I0SWNvVldXQkg1b0FhL1AyZkxtaUpYRGxFbFZMd29j?=
 =?utf-8?B?SkhYQVl6Zy92dHdKbzMvKzZIUkxTNlFYQ05ua2pDUVFhOU9jeXJkTDRVZTU4?=
 =?utf-8?B?c0E3cU5NQWUwTHpHckdrUExDUjI3WDBDL0lDWGYzamJWLzBDRy9LaHVpK1BX?=
 =?utf-8?B?eHhxU24wY01KRHhCeGJKdE5TOTk4VVFxYjRGbm03M2dYeW0xejdnWE5OTEUv?=
 =?utf-8?B?ZzhSM0R4NW53QkoxcG9yUmVsRHozWnJ3YW81SU1MeHdZSU41MitROXpRYWw2?=
 =?utf-8?B?WjltQTgydmtuTnQ1MzEzMS90cXJ4Q0FUY0NUbkxKUVNOeGk2ZDlIVUZRT3o1?=
 =?utf-8?B?T2l2WTBHSkErbHN5cmRmVDFRSGtkTlZMemFGbzgyV3V5YVFSTy91WTFHUVFm?=
 =?utf-8?B?UDkwbTdUYUFFZVYvZ3RlSFZNV0todVl5dzEzc0ZmVE5VclYvdytMdUhaYWVH?=
 =?utf-8?B?R1pSbTB0SVVtaFl5NlRpdWlCZ3MwM0VtODZrM2tyUUo0QXg4RDlSbWYramF0?=
 =?utf-8?B?SUFJQkQzZHhYK292WDAxREg0R0F2UWNoYURKSW1uaG5FK0VZTVY5ZjVubXFK?=
 =?utf-8?B?QytYZDBIRU1vaU45STl3TUE5b0NyVWhqdTYzaDRuUUZwY0RQaTZ3aXlrclJi?=
 =?utf-8?B?WW5UbzJlNG9DcUJOQm5aR0NoYnZmMmFqQ3NsQkgyS0x2OGNQbzBMQ0l2aVdG?=
 =?utf-8?B?eVh0eHpUejZSdy9Ra1hBQWR0Y3B6M2N5eWlqWTFuVXJ0UjNpQ1BTM2s4dWJx?=
 =?utf-8?B?TnFzcmlab0NObFEwQk4vY0l6UWd3ZUllT3p4ejZqQ3JtREZ2ZkRDTXNzb2o0?=
 =?utf-8?B?TTArQnpCbWhMTi9XU1o2eHdtLzluN1B5NU5Db1JIRXpCV000aVVVNVluSzRL?=
 =?utf-8?B?SHlXb0xDVkZUUXJ0Nk96b0FXOVRjb3RNeVJIc0d3MkI0MjZDanFjeGQ5cEhV?=
 =?utf-8?B?bytIbEJtRVNoWVhYV3NzaWlqZXB5Nm83UUFsanNNSXh2OXhFMUsyR3dZUzQr?=
 =?utf-8?B?WnBNNlFpV3daZ3JqWWplYkV6aXpoMi9MYXV2cG8vVFhvNkhsOUxCN0xoSVd1?=
 =?utf-8?B?NXpVY2lVQlNkVkJLWXUwSlhwNjVyTTFpK1dqbGpNcVpRMUFZNDEzZ1RIOWVX?=
 =?utf-8?B?ZWcwQ0lkZ1hFcnp1amxOdFhKYkU1aTEzSjNsZ2N0N244QmV5RnBZZmh3cDA2?=
 =?utf-8?Q?XdTaUNrv1oWOFRW+bnphRqmGjFlyAgBfP2C6b9y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllYR0d0MTZUTnZlTzg3MlI0MnVkeUZFYmhVQys0VStOZ29YVm1SOU9YSnJ4?=
 =?utf-8?B?ZmJWVGF1YjhCYXl5TmJDNHBpNExhT3ZCdDBieStMNTlPNmROc0xSRlo5V2dK?=
 =?utf-8?B?ZVlCTEsyNWtJQW1SNmgrQXdFNkVVY0dlZGtjQ2N1cWVtUmNDRnJBOG9GeS9S?=
 =?utf-8?B?bEV1V09ZNHZ5Q0pEK0Vaai9PNEJCSkdndnNmcFVES3VKaWlOZGdMc0Vmei9k?=
 =?utf-8?B?TGhQRUhod3NvS3Yxd1NBU3ZqbnFvckRLaEpldmhuSVdhb2tTY1ozcE5QZHk5?=
 =?utf-8?B?WDFqdVZSc0JBTitEWmhyZE02N3QyVHk2YlFaYkVNYzRJMkdqRlNiRVgwdGtt?=
 =?utf-8?B?Ni9aYkVxVVVyNWh0M05ZamVoT3FWVVcwdmwzd24zN0V3RUtSaHF5TDRPVFFQ?=
 =?utf-8?B?OWwzVGNqMjRlUjJ6UGFacmdFT0NydFFhWkpncmltVGJOV2Y1K05lL3RnZG1h?=
 =?utf-8?B?NDdsSS94U2RlbVI2cDUrWUJvU2Nsc0RCeHZJZGxEaE9TUXVlaGJxb0d6ZnJ1?=
 =?utf-8?B?bGxtV01tS1p5aUJKWjZQQW1OV3Jua3lFNGZjanRpM1NFd1p6cFp5T1BSQmZ4?=
 =?utf-8?B?aGVvbkpvSjNMZU15bzRFaVU2d0l3V2JkNU4vV3hFRnkwTUZFcnMzZkRVZFRP?=
 =?utf-8?B?cW82VVExQWpxc29jRzI3UVRjMUI1ZklaQ0dZRUpRMDZhMkdvMHc4N3FWb0x2?=
 =?utf-8?B?ZXIrVzdFMHlib1NPaUZOT0ttTFlVNThFQlVLMHRWbjFkOHFOWFZFeTRlNWt6?=
 =?utf-8?B?UDlJNWswTjUzMXI1WlVpWEpPdklEak1NSld3L3pEWnZtZVZVNGRYT3hROFpH?=
 =?utf-8?B?NlV0TXg5Z2hMRzJ4Z3NobC9PUStUMmFUd3psb1U4blkwVHR3bkZITHNDSkJt?=
 =?utf-8?B?VnVJMkNvWEphUDBJSFd1Z2tjTFE5ekhIZ01LOFhtYTBOaUI2OE5XTUhWSnQ5?=
 =?utf-8?B?UzloUm5WUUZmQkNWME5XYmIyb2VNUHdBZkxLVGozL0hoVHplcGRzVzlNeVdz?=
 =?utf-8?B?Mi85SHl4NVZqRUhEaUM1RjlVcmg4SmNyK0czR1puOXcyNzEvcFc1K3N1Tldl?=
 =?utf-8?B?eG42Y256a0ZFYm9VaVFkRlkycmJIY1pXeEpDMzBVVHhTMldrQ0pmWjFpem1Y?=
 =?utf-8?B?MWx3YWdnaWZyTGpZSFFkWU5NQnFOVW1Palg2cGZzaEhLeXErNFpMV2VIMHgw?=
 =?utf-8?B?amdZaDRRUmptMi9zRW53UENMOWwveGhUVXJpcXJWUGx5c0I4eGhMTlkwR01M?=
 =?utf-8?B?ajl4VkdKcmhyalZUMlljV2dRRUZOWkJXSERLTENLWm5oZnZyTTFIQy9lbStD?=
 =?utf-8?B?d05FU2FNTTBMRjZmYUM5RnhzSkhiaU9OcnpKem8vM0V6MkdnbWU2aGhIelVV?=
 =?utf-8?B?bXdOVkVQUHdVWHRaR3EwTFUvVmVqN01CNC9xN093cjN1TjNYRW9nTG03aWVW?=
 =?utf-8?B?YW1NYlRJdDIrSldvQ2dFZHl3djNscXJDVnJMVXNia3NIQzVCcEQxaWRYZE5D?=
 =?utf-8?B?NzhvbEZKNHRVYzl0SWI5bHg4eUJFQng0UmdVdUtHYmNUMEMyZjhuQllaazB1?=
 =?utf-8?B?K0ZMMTRhOG1mUG8yTThGSGM1Y3d5TXVraUI1SVc4MHdEbWlCMDY2Wk9FaGYy?=
 =?utf-8?B?alJmS3JRWm5USi9qQWM0SlA4bmhrdW1haWtWYVFlMG1ka211NmlCR3pZa2U2?=
 =?utf-8?B?MXVOdmlKQnpZYkduVmhhUTN0N3FxbVlvTTFaU2tOS3dBL05DaVhINUMyOGRX?=
 =?utf-8?B?dEc4ejFTZG1aMGIra2hOYzBxelBtWEVYKy9rYmxoUHdES3NmSW9BUWJsT3Zs?=
 =?utf-8?B?OUl0enRkUWpqOGlTRkxRS0JsT1hzUDh3VnlQVGZuVmxFVmdEMTVFa2xZYzFx?=
 =?utf-8?B?UE5ZQWdRZ0t2aTB5VVJlMTM2b0RSLzJwS0tFOE51TW9yaWFsS1VwMG42dWZ3?=
 =?utf-8?B?cXlvTTRlZzgyMHlhUGl4ZTQyMW9qajRMeTJCNi9jcGg1blNjbmpyeGk5K3Ja?=
 =?utf-8?B?d1BqS3pZNWw0Y09KeldMNW1kVE1DQmhuUFJ5aFAzTURRYUVxR0o2ZmJ0MFdG?=
 =?utf-8?B?cmxuMGg2ekQwZFRmMGl0UXE0d2o4eVVZbE82VFV0U2RITzk5S3JzNFo0bjNo?=
 =?utf-8?Q?epZYJ4AcJdG+qGi2nnQaoStEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c9970f-f883-459e-b41e-08dd047bc36c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 07:12:56.4533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZiEPQfb0whMI0BPoFzk0ft1FNx9Nem66X4SySOiS0eXcQtTXPq7tnrLTo4s96Uz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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



On 11/14/2024 12:29 PM, Liu, Monk wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>>> QEMU and their virtual drivers uses a virtual PCI MMIO BAR to map buffers from the host into the guest. Those buffers can be both point to the FB BAR as well as system memory.
> 
> Well, you are talking about virt-io GL use case? Or mDev solution ? because those conventional device like QXL, NIC, soundcard are purely software emulated and no way to point to the FB BAR ...
> 
> I can understand that Host make the final decision on the memory if it is FB can be leveraged by guest as some system memory, but brutely treat all system memory as cache no matter what guest do is ugly ...
> 
> Back to our topic, I propagated you and Lijo's statement to customer and they didn't buy it, rational as:
> 
> 1) they don't think let host honor the real mapping is correct as they don't have anything like virt-io GL solution in use...
> 2) they cannot suffer risk to revert that KVM patch on their server.
> 
> So the thing is they will live with a hotfix patch for now, but they are also asking:
> 
> Why cannot AMD make all ring buffer (managed by KMD/KFD) to the same type which is cache, as they know that GFX ring from amdgpu is cache type.
> 
> Besides, both customer and CVS team will also keep investigate why after the map is honored by guest there is still coherence issue (type is USWC, mfence is inserted between doorbell and wptr_polling updates)
> 

If this is truly mfence-not-working-as-expected, wondering how any user
app which relies on a similar mechanism can reliably work on their systems.

Had already mentioned this before -

Even by the assumption that mfence fixed ordering but data stayed in WC
buffer, there is one other hole in this theory. With DOORBELL_MODE=1,
any write pointer update is fetched from memory. That write pointer is
also maintained in WC type memory. If CP is correctly able to see WPTR
update, that means that part of write got updated in system memory.

Anyway, please keep us posted.

Thanks,
Lijo

> Anyway, Lijo, Christian, thanks for your explain and insight !
> 
> Monk Liu | Cloud GPU & Virtualization | AMD
> 
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, November 12, 2024 5:41 PM
> To: Liu, Monk <Monk.Liu@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
> 
> Hi Monk,
> 
>> The memory we are talking about is pure guest system memory not FB BAR right?
> 
> No, that works a bit differently.
> 
> QEMU and their virtual drivers uses a virtual PCI MMIO BAR to map buffers from the host into the guest. Those buffers can be both point to the FB BAR as well as system memory.
> 
> Only the host knows if the buffer is backed by MMIO (FB) or system memory, so only the host can setup the tables to have the correct caching and WC attributes.
> 
> The KVM patch completely breaks that because they suddenly say that not the host setups the caching and WC attributes but the guest.
> 
> Because of that this KVM patch not only breaks amdgpu, but also other drivers which do the same thing. The general approach of the patch seems to be broken.
> 
>>           if (kq->dev->kfd->device_info.doorbell_size == 8) {
>>                   *kq->wptr64_kernel = kq->pending_wptr64;
>> +               mb();
>>                   write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>>                                           kq->pending_wptr64);
>>           } else {
>>                   *kq->wptr_kernel = kq->pending_wptr;
>> +               mb();
>>                   write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>>                                           kq->pending_wptr);
> 
> We should probably move that into
> write_kernel_doorbell()/write_kernel_doorbell64() but in general looks correct to me as well.
> 
> Regards,
> Christian.
> 
> Am 12.11.24 um 04:50 schrieb Liu, Monk:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi Lijo
>>
>> Thanks for your quote to the SPEC, yes I read that as well, supposedly WC storage buffer shall be flushed to memory with mfence, but it just doesn't work after applied that KVM patch which honor the WC attributes from guest.
>>
>> This means the WC storage buffer from a KVM guest couldn’t be flushed
>> to memory even with mb inserted... I don't know why. (is there any
>> inconsistencies between nested page tables and host page tables?)
>>
>> Hi Christian
>>
>>>> The guest sees driver exposed memory as "emulated" MMIO BAR of a PCIe device, that's just how QEMU is designed. Because of this the guest maps the memory USWC or uncached. But in reality the memory can as well be GTT memory which is cached.
>> The memory we are talking about is pure guest system memory not FB BAR right? Therefore, I don't see why in reality it has to be cached, you see that only guest vCPU is accessing this buffer.
>>
>>
>> BTW: we should aways insert that MB() in our KFD part:
>>
>>>>           if (kq->dev->kfd->device_info.doorbell_size == 8) {
>>>>                   *kq->wptr64_kernel = kq->pending_wptr64;
>>>> +               mb();
>>>>                   write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>>>>                                           kq->pending_wptr64);
>>>>           } else {
>>>>                   *kq->wptr_kernel = kq->pending_wptr;
>>>> +               mb();
>>>>                   write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>>>>                                           kq->pending_wptr);
>>>>           }
>> Thanks
>>
>> Monk Liu | Cloud GPU & Virtualization | AMD
>>
>>
>>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Monday, November 11, 2024 8:40 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Liu, Monk <Monk.Liu@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher
>> <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>;
>> Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>> wb pool
>>
>> Hi guys,
>>
>> trying to merge multiple responses back into one mail thread.
>>
>> Lijo, you're completely right, but there is one really strong argument you are missing:
>>
>> The patch here doesn't change the write combine behavior, it changes the caching behavior!
>>
>> So when the patch works and fixes the issue, then the issue is 100%
>> certain not a write combine issue but rather an incorrectly applied
>> caching :)
>>
>>>   From what I heard there was a KVM patch to correct the mapping behavior -- previously the mapping is forced to cache mode even guest KMD maps the buffer with "WC".
>>> But after the patch the buffer will be really "WC" if guest maps it with WC"... and this reveals the bug and hit our issue.
>> Yeah, exactly that's the problem. The guest doesn't know if WB, USWC or uncached should be used!
>>
>> The guest sees driver exposed memory as "emulated" MMIO BAR of a PCIe device, that's just how QEMU is designed. Because of this the guest maps the memory USWC or uncached. But in reality the memory can as well be GTT memory which is cached.
>>
>> So forcing the cache mode even if the guest KMD maps the buffer with "WC" is intentional behavior, that's the correct approach.
>>
>> The upstream people realized that as well. That's one major reason why the patch was reverted.
>>
>>> Can you explain why USWC for ring buffer is safe, why it will not hit coherence issue, why you don't make all ring buffers with USWC even for amdgpu side if you really believe USWC is innocent ...
>> We already tried this, but there is simply no benefit for it.
>>
>> Regards,
>> Christian.
>>
>>
>> Am 11.11.24 um 06:58 schrieb Lazar, Lijo:
>>> On 11/11/2024 7:00 AM, Liu, Monk wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> Hi Lijo
>>>>
>>>> This is the patch we verified before:
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>> index 4843dcb9a5f7..39553c7648eb 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>> @@ -308,10 +308,12 @@ int kq_submit_packet(struct kernel_queue *kq)
>>>>
>>>>           if (kq->dev->kfd->device_info.doorbell_size == 8) {
>>>>                   *kq->wptr64_kernel = kq->pending_wptr64;
>>>> +               mb();
>>>>                   write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>>>>                                           kq->pending_wptr64);
>>>>           } else {
>>>>                   *kq->wptr_kernel = kq->pending_wptr;
>>>> +               mb();
>>>>                   write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>>>>                                           kq->pending_wptr);
>>>>           }
>>>>
>>>>
>>>> This mb() doesn't resolve the problem during customer's testing, I also thought of MB() first in beginning like you and Christian ...
>>>> The mb() here shall resolve the re-ordering between WPTR and doorbell kicking so GPU won't fetch stalled data from WPTR polling once it receives notification from doorbell kicking.
>>>> (in SR-IOV we set doorbell mode to force GPU still fetch from WPTR
>>>> polling area, doorbell kicking is just to notify GPU)
>>>>
>>>> And by your theory: mb() shall flush the WC storage buffer to memory, thus, this mb() shall also make sure that the ring buffer is not holding stalled data anymore, right ?
>>> This is not my theory. All the quotes in my earlier mails are from
>>> "Intel® 64 and IA-32 Architectures Software Developer’s Manual".
>>>
>>> Yet another one -
>>>
>>> <snip>
>>>
>>> Writes may be delayed and combined in the write combining buffer (WC
>>> buffer) to reduce memory accesses.
>>>
>>> "If the WC buffer is partially filled, the writes may be delayed
>>> until the next occurrence of a serializing event; such as an SFENCE
>>> or MFENCE instruction, CPUID or other serializing instruction, a read
>>> or write to uncached memory, an interrupt occurrence, or an execution
>>> of a LOCK instruction (including one with an XACQUIRE or XRELEASE
>>> prefix)."
>>>
>>> </snip>
>>>
>>>
>>>> But we still hit hang and get stalled data from dump.
>>>>
>>>> Maybe we need to put mb() in another place ? can you proposal if you insist the cache mapping is not acceptable to you and we can ask customer to verify again.
>>>>
>>> There are a couple of things which are still working strangely, they
>>> will need some explanation as well -
>>>
>>>        Even though write pointer allocations are also to WC region,
>>> and are correctly seen by CP every time. Since it needs to get wptr
>>> updates from memory rather than doorbell value, don't know how your
>>> snooping theory works for this. Also, it is weird that WC writes to
>>> those pass MQD buffer writes even with fence.
>>>
>>>        MQD allocation for user queues are still from USWC as per your
>>> latest patch and they still work correctly.
>>>
>>> For debug -
>>>        Is the WPTR reg value correctly reflecting the memory value?
>>> Have you tried initializing MQD to a known pattern (memset32/64) like
>>> a series of 0xcafedead and verified what is seen at the CP side?
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Thanks
>>>>
>>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, November 8, 2024 7:26 PM
>>>> To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>;
>>>> Zhao, Victor <Victor.Zhao@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip
>>>> <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>>>> wb pool
>>>>
>>>>
>>>>
>>>> On 11/8/2024 4:29 PM, Liu, Monk wrote:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>> To be clear for the mb() approach: Even if we insert mb() in prior to amdgpu_ring_set_wptr(ring), GPU might still fetch stalled data from PQ due to USWC attributes.
>>>>>
>>>> Inserting an mb() doesn't cause WC buffer flush is a wrong assumption.
>>>>
>>>> All prior loads/stores are supposed to be globally visible. Hence mb() followed by a write pointer update also should guarantee the same (From Arch manual).
>>>>
>>>>           The MFENCE instruction establishes a memory fence for both
>>>> loads and stores. The processor ensures that no load or store after
>>>> MFENCE will become globally visible *until all loads and stores
>>>> before MFENCE are globally visible.*
>>>>
>>>>
>>>> Ignoring the amdgpu driver part of it - if mb() is not working as expected as you claim that means something is wrong with the system.
>>>>
>>>> USWC or WB for ring type may still be a separate discussion.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> The issue here is not the re-ordering but the stalled PQ.
>>>>>
>>>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Liu, Monk
>>>>> Sent: Friday, November 8, 2024 6:22 PM
>>>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
>>>>> <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao,
>>>>> Victor <Victor.Zhao@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip
>>>>> <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>> Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ
>>>>> and wb pool
>>>>>
>>>>> Christian/Lijo
>>>>>
>>>>> We verified all approaches, and we know what works and not works, obviously the mb() doesn't work.
>>>>>
>>>>> The way of mb() between set wptr_polling and kicking off doorbell is theoretically correct, and I'm not object to do so... but this won't resolve the issue we hit.
>>>>> First of all, USWC will have some chance that the data is still in CPU's WC storage place and not flushed to the memory and even with MB() get rid of re-ordering GPU might still have a chance to read stalled data from ring buffer as long as it is mapped USWC.
>>>>>
>>>>> This is why only cache plus snoop memory can get rid of inconsistence issues.
>>>>>
>>>>> Besides, do you know what's the rational to keep all GFX KCQ cache+snoop but only HIQ/KIQ from KFD configured to USWC ?
>>>>>
>>>>> For performance concern that looks to me always the second priority compared to "correct" especially under the case HIQ contributes very little to ROCM performance when switching to cache mapping.
>>>>>
>>>>>
>>>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Thursday, November 7, 2024 7:57 PM
>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>>>>> <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>;
>>>>> Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix
>>>>> <Felix.Kuehling@amd.com>
>>>>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ
>>>>> and wb pool
>>>>>
>>>>> Am 07.11.24 um 06:58 schrieb Lazar, Lijo:
>>>>>> On 11/6/2024 8:42 PM, Alex Deucher wrote:
>>>>>>> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>>>>>>> From: Monk Liu <Monk.Liu@amd.com>
>>>>>>>>
>>>>>>>> As cache GTT buffer is snooped, this way the coherence between
>>>>>>>> CPU write and GPU fetch is guaranteed, but original code uses WC
>>>>>>>> + unsnooped for HIQ PQ(ring buffer) which introduces coherency issues:
>>>>>>>> MEC fetches a stall data from PQ and leads to MEC hang.
>>>>>>> Can you elaborate on this?  I can see CPU reads being slower
>>>>>>> because the memory is uncached, but the ring buffer is mostly writes anyway.
>>>>>>> IIRC, the driver uses USWC for most if not all of the other ring
>>>>>>> buffers managed by the kernel.  Why aren't those a problem?
>>>>>> We have this on other rings -
>>>>>>            mb();
>>>>>>            amdgpu_ring_set_wptr(ring);
>>>>>>
>>>>>> I think the solution should be to use barrier before write pointer
>>>>>> updates rather than relying on PCIe snooping.
>>>>> Yeah, completely agree as well. The barrier also takes care of preventing the compiler from re-ordering writes.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>>>            if (amdgpu_amdkfd_alloc_gtt_mem(
>>>>>>>>                            kfd->adev, size, &kfd->gtt_mem,
>>>>>>>>                            &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>>>>>>> -                       false, true)) {
>>>>>>>> +                       false, false)) {
>>>>>>>>                    dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>>>>>>>                    goto alloc_gtt_mem_failure;
>>>>>>>>            }
>>>>>>>> --
>>>>>>>> 2.34.1
>>>>>>>>
> 
