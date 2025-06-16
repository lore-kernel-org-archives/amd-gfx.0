Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AEAC71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 16:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041F510E33F;
	Mon, 16 Jun 2025 16:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V/XPTMRU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD79610E33B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 16:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxbR19PnW554gF6QQvwFo5b8HeURnsi/yFYoT0TflSUicTUwzx6niQB5/UwkzatquENRsnJdqe1d5xb+zHkm9BhkWIddk9CjlG1Q16bR8muQ3U8xgMw0nFkx1gnJybF87ytftJbDYLmtKbeu+wZzy6jXmCH387bopgS3rY3h5plzO54Sw9FeP7W7oWOuM2+EKTkFdHRig3AZQFfQIJgsWzfEdxy8URNf06hBIiJat9I9XfQzAZZD8TBM0RQ9HKY/+7hy4+Fx0VPak+zPQbvClNH4NTKNaSPaCXs3bPjdI+UdbwzXpdhdmFygMtqrmaMRUofUFO6XQ8QkAB+AfAEWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i5v6bNRMBCaRv/kOjna6gF2eItfK+/BeVSN+eGs7EY=;
 b=Ikwk7p7MvJP+EgvfiCQBKxtxrdymsFhwmji1GFhFACboMJCu0q3FQNIrIFIAcfAN3HPcPGeG73PD7lsF29RYnJZSAXD0gTneGFbmLXXPphcSZsIOMtaRJj1FfgU3VIu7PyzmHMCj1m2i/7OZAiD3h8LTjasyDJo3VC0QNe1qJ6RuexZzjZCd9hSu2mwpvf6rPPcKkTXRmg1f3jcCb7eOQKBFjPZYY+Bd+yWVLhSmEeAcxIefewTEkBt4Z9nhhG6kREgJFYuHktFne9Qyrl7wq/hp0HjQF//jR5o3uTw4Zp0/HlRXRJ3qGHJlouDkT4qzo4Bcbyt73pFHeUsiWZANAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i5v6bNRMBCaRv/kOjna6gF2eItfK+/BeVSN+eGs7EY=;
 b=V/XPTMRU0GuzpcN3mUce/Cry6pfPAQC1EOQCAwBzagDeDfNESTLCy6ONwfLTiiipNCUKgkXSj/HfkdiDm9bc49RvhU+TVvuNGP9OQ5htDJDEmrV1n2jefTX2HmGt1728vQZMBfBRsjt7JuEqlAcr/D+j4mKd9Bj3aWu8qFNEzOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:01:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 16:01:35 +0000
Message-ID: <fa16ff42-b4a2-421f-902d-f6d03e814768@amd.com>
Date: Mon, 16 Jun 2025 21:31:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop
 sequences
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20250616144030.3497914-1-jesse.zhang@amd.com>
 <CADnq5_OpAaiBZaxU6RxNRvY3wcpz5WhDzX1iscuUnsu7gebrhg@mail.gmail.com>
 <ca06a3e8-cc16-4b98-99ce-7271c3efeb47@amd.com>
 <DM4PR12MB5152EA0811C75DCC4B584995E370A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB5152EA0811C75DCC4B584995E370A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ddd6a4-8d04-412b-3474-08ddacef11ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0FUZnlnQWJjcFQ5NGIvM1U3OVlHVllLQmFmRFRZNExWTXgvTnJELzJSVXk1?=
 =?utf-8?B?MG5LeTFCNk8zWHRhQXRueDVwMTVoeGFscjQ3d2RDVUhOcC85SDl6RlZZcURL?=
 =?utf-8?B?NzVpbzNaK0pQMkxBNDJrWGxXaGFrc1FhQU5HRUY2dWY3TGVwM3ZRZktuRHpv?=
 =?utf-8?B?dHFzOWdHaWRac1pUSythZWRNZ1d1MWtGLyt6WnBQU0trRWtCRVExWU9LWEVV?=
 =?utf-8?B?NGEyMFBKdXI2eHl1N0Z3SnNqWjY2RWYzMnFYdG5nNHR4RzF4V0hOTUQ3cGJ2?=
 =?utf-8?B?aDVRVDZwSmVpMDRKVlFiMW80N3BKQWtHZXNURkR1eGMxNW1BWThzTHc5cGd6?=
 =?utf-8?B?NHJFNldSVGN1TTVESU1LT0dzODhyL3M4RFFyQ2xhS09WVGIwQzJDMytmWkx1?=
 =?utf-8?B?YkxuUFBNMTVZMzRyUWxqVm5yRmhkbjhmbnpEMHk0NzNRcjZJaUs1NUtRUkZp?=
 =?utf-8?B?U09MTEpCYWRvTm5UdFAzZ1RzbVA5Zm1zdnR0cnJMMWFTTWtheVI1a3VNaGp4?=
 =?utf-8?B?Yk01UDhLNFp1Rno3RTV6MzVSU1dpLzFOMGp5RHVHeHNEVk9xUTAySTUwekFJ?=
 =?utf-8?B?dTBNUnpRdW5MQWVxVW1tKzRQc1NCc0dTeHI4YkN6MG5oY3h6Uy9ITkJsTVVJ?=
 =?utf-8?B?SjY3WDZvN3hRRmlwRUphbEZiMFRnQkY4N2V5bDBwZkdVdCtNdEN3OVRISmxD?=
 =?utf-8?B?QmVGbEErbzFoZXM4cnF5cmdUclRGWUhVZnlCczBiOUhsOXJSRTZyRHdyd2NR?=
 =?utf-8?B?S1RGbEpWangzZmVzK05kdTBtcWNHeFpEWExmT3RTZXNMZEpWY1hnbW01NTU4?=
 =?utf-8?B?Mm5URXhyWGR5bzUvNzJ0SSthbjdYT2pLSkJFRWxWVWpWempyMW1DVHhiRDdC?=
 =?utf-8?B?SncrTEtPb0Y5YlVnV1p2SW9CRmVYejE0RlJkT0VBZHNjaTlrY3lwYm5Wa3lN?=
 =?utf-8?B?dFRPRnJWTUtkYzFNeHhrenlsOXVmVmlMY3RhUnhXK3V1UkJBenpQaDhvQnlJ?=
 =?utf-8?B?dm9OQzVxYkpaUUNiSFluNVBTbVhoY01UdmFHZjJUajJZTkhOcWMxbndWNSti?=
 =?utf-8?B?Tkt3NFI4TDVreGs5bk9yWUxDbGR4bWpIV3FaUGp5SzBnKzMvcXYraFkwRUVz?=
 =?utf-8?B?QjFBcTlXMlJYb0tvMk5sUDc5RmtGMnkvcnpIeG5ESElvbEhlUU1KTGhldDdw?=
 =?utf-8?B?b0ozLzN1TkV4U21heHp2ZWpXMFdVVVVRQUw0c1ArVGx5YVZUc3BHTE96a2hD?=
 =?utf-8?B?cGdrNTh2SkFHS1kxSlZrejlGL1g3MFd5MTJuVXg0RFIwUHVBT09HUnJoUDBM?=
 =?utf-8?B?MU80RnFFQ3oxM21Ec3Q4NGpaYW9DTExwRlI3cVZJQW9jTUxuWnJWU0ZqWlJG?=
 =?utf-8?B?eE9oSlVRN2grRlNiSlhnamQzY0pqZnRwSy9jcFlZdmFnQVozVUVtdzlRcU1a?=
 =?utf-8?B?U2tERTZYRml2MnU1Rzd3WUVXQWU0SmNDR2ZUb2JoRUZKZThzSDVROWE5OTNJ?=
 =?utf-8?B?MXBCSGNGZkd4Um1BYjVmNE9NMmgzbzJzOGp1VFJZaWE4REZCU0JpZ2NwaHBt?=
 =?utf-8?B?MHBKaW9nTVp5SDVhNExpVEdsVkxsM1ZOT0xhTGk4azluK2N5UzRlNjh3TFU5?=
 =?utf-8?B?akxUNFFLTzZKWWdvU1JZMDM4MHF6MVB0Z28yOVVZZkFHeldhWlZOVVdpalhl?=
 =?utf-8?B?L08yMDkwYlJQTitwRGc3UjJ0MHVzYTB1VnJoYkdLRUJJVUpCK0lNOWF3cjJ2?=
 =?utf-8?B?MVAzdHp1Z1NacnBUU25aWlQzRGRlZmp4azNpRjRoQkZBSHVHcmdabUZKUEg4?=
 =?utf-8?B?YkpVdW9EZkdoV0lmY2tVMm1oTGJPcTJBY3l2d0ExRnNzYkZZS2xPbGxtY3lT?=
 =?utf-8?B?aDBYcmJCcHR3YXg5S3RQS2loZSswM3JidEs4N3R5SmkreHR6SG5nSWpOZjJK?=
 =?utf-8?Q?Jbf4f9urt3Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJBNUFuSUtiYWk0UEFURUNpMEg3OTlSd3VJVVhnME9UUFZTcjNzYUgzZTNs?=
 =?utf-8?B?LzN3MUhvTXM5NWZyR1ZSNG9EOTJQV2xHQVZRemdqSThUbkdrOG5GMUNwSFJF?=
 =?utf-8?B?djV4dSt3akUxTDM5UXpUT0xRUUx3UkNQUTNxSVF3aG9lVVdheG9qcmNoTSt4?=
 =?utf-8?B?MXZDK1Zsd240ZnNyUjBwYnVHU3NVaHhEOUpJd0xlRnlYSGZqNFBTUWdUWTdq?=
 =?utf-8?B?MXVwejN6U2F2NFVvN05pUTUxaHFGSDdUZzgvRzdkQWQ4U2NqdlZtYUdSUUQ5?=
 =?utf-8?B?ZE1sUXdaMWNUcHhNdmIxQm41eTZNWVFObVRkcXJpdW11WHF1RGd1aFN5UDZJ?=
 =?utf-8?B?QUt0VFk3QUtFZUdvenc2UFVJZFRJNGhnRjE3dEh2UGhSNzhPemM3NklaNEYr?=
 =?utf-8?B?OWx4RXB6dlVjTlBXeVR2c1IxVGcyd2E3YVV4ZGV0N3pvTXN4UzB2elorNDNu?=
 =?utf-8?B?R0Z2NitGR1JzbG8vMm42Tmh3ZWlzTkZ2KzVvYjIya3ZRRmVQN29qNWpyM0Nu?=
 =?utf-8?B?S1lmcHBVQWJsU0srOVlFdXVnRm1oWTJkMU9LZS94SmFKYUFlVWlzZ1IreStx?=
 =?utf-8?B?eENGVXRmS3dXU3FJblBydlNJbHVBWkE1RXZ2Zm5LemppQWU4ZW5VaTJIMWpS?=
 =?utf-8?B?bWtZZEZWMzNhQ0FVOVFGWlNpZEhBMWZ4SEM4MXduOEZKOStNZi9MRG5HbFg2?=
 =?utf-8?B?WnFrTE0vUzlGMSt2RmdUN2h6eVkxREdDM1dWaUJ2R1Y0L1Bkc3AyUlZQdWF3?=
 =?utf-8?B?QllFRkM4STkwTElQRWw2M1JNd2pJS1Ftb3ZSaXo2YTd4bHl5QlhTVnNRcUxM?=
 =?utf-8?B?dnZFbkZCem05M0JsUXVta0lUWm85ZXpCaE9BeitSbjAwZnYzR04vV3Z2dHUv?=
 =?utf-8?B?bVM1MW05SHR6aysxNXNhVU56cE9GRXRBSFlHcmhWZHRTVmpRcmU2eUp0eTVT?=
 =?utf-8?B?NmN4NmErRUtzKzl6WGFpNEpraFhWbzVsTzJBQW1iZXVkRHk2UUNsVXF0V2NB?=
 =?utf-8?B?bTJUNXV6dy9MSHdVdXZtbGxsT1p2YXZyZEdvUWhqMTh4a1ZPbjdsMm03elh5?=
 =?utf-8?B?MzJTc0I0Y3p4eG1UVWprMWJkdUFBVjd1WU96ZENRcnRLUndYZi9hdFNqMXpz?=
 =?utf-8?B?Q2NveEZZSHJPRW1FbVNPS0w0U21EWXkwRWpVYno2aGZvWjhRanRSN3JHT1Fz?=
 =?utf-8?B?UnhsL3AvUGg4VmQ3RnN2c01KdjVDSHR4cFNtQ3ZYN3NSZ2pEWW5OV0hzTTZH?=
 =?utf-8?B?Z1BBbEdrT3gzb1pmYTl2Z1o5VUJOUjVTTVBIT2paR1VqZVRLODUzMUxYMWVq?=
 =?utf-8?B?WVQwZi9GU1BXVUhuMko1ZzViM0pZcFBibExxNVpaMWtLelRUcS9VZm1JSitD?=
 =?utf-8?B?YW1FbUhiaU9FdWtpcWxianNjVC9nMFFiMDlRbWlwYldUa01RMW0yM01QSU9M?=
 =?utf-8?B?a20yTC9WSzVKZHhQSXM0bkpDMWR5NVA3aW9lT2J0UDZyZVR3Yk1vVE13dTll?=
 =?utf-8?B?Vk9TZi92d3kwMXFidUpkRWRyZW4ydnJmeWV3SlZiUnUxc2xTVW1TRE5XejZ5?=
 =?utf-8?B?UjdtOHRHQ0hrbEhTTWtxaTNkak1GTmppcGVFNGk5bGE4WUFwSUhHRkx0V01G?=
 =?utf-8?B?d1BRTW03RzVhZXE2aS9zOFpxRkU5VXFoWFRvYW1TZzdXOWpmYzJ1YklYOTVE?=
 =?utf-8?B?M0dGM0tISURTY3RMOWJJSStURkhpTGxkMGV3c0hQd2h0VzZNY2NLRWFqVUd1?=
 =?utf-8?B?U1c2WjgrT2FtRXkwZXhmbFpkUEFWV25KMlI1NSsxWGpORnppbExwaVZTeDBH?=
 =?utf-8?B?aVRpeE5UbEVhT1pUdmpWcXg2WXBMM1htcmNqTGk3aXNZekw3SEJ5cE9EYkZG?=
 =?utf-8?B?cUtqWFpJUFBuZjRoNjVpMDRIT3JHYzhwMXhQZzU5OGxMVlg2SzBkTDJjQTU5?=
 =?utf-8?B?WkpiZkhob096dkM3NkZXQlBNMnM0OXNaTml6RmkweDJCd0x0V0haTEVrZmN0?=
 =?utf-8?B?VWI1Wk95YWdRNGhrbFZjbkpUZXBTZUE5RkpiRlNnazl0TzVxeXdhcTBEU29U?=
 =?utf-8?B?a1QyTG9vb05jRG5CbVo5L0NDZDRmaTNqRmpZZHd5TkNmR2huVjJsSUNtRktB?=
 =?utf-8?Q?/HjMbaJaHkH+6Mn+ZEczZnVhF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ddd6a4-8d04-412b-3474-08ddacef11ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:01:35.6641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx8C7cSCLm6SQbQ2C2Z9rc5DokazunuDhgEjAMyxj8E+6LW7eWgyHoZVXTK+wrox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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



On 6/16/2025 8:54 PM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, June 16, 2025 11:05 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: Re: [PATCH V2] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop sequences
> 
> 
> 
> On 6/16/2025 8:28 PM, Alex Deucher wrote:
>> On Mon, Jun 16, 2025 at 10:47 AM Jesse Zhang <jesse.zhang@amd.com> wrote:
>>>
>>> This commit makes two key fixes to SDMA v4.4.2 handling:
>>>
>>> 1. disable UTC_L1 in sdma_cntl register when stopping SDMA engines
>>>    by reading the current value before modifying UTC_L1_ENABLE bit.
>>>
>>> 2. Ensure UTC_L1_ENABLE is consistently managed by:
>>>    - Adding the missing register write when enabling UTC_L1 during start
>>>    - Keeping UTC_L1 enabled by default as per hardware requirements
>>>
>>> Fixes the commit 7f03b1d14d51 ("drm/amdgpu:
>>> Remove sdma halt/unhalt during frontdoor load") by maintaining proper
>>> SDMA controller state during initialization sequences.
>>
>> Proper fixes tag formatting:
>>
>> Fixes: 7f03b1d14d51 ("drm/amdgpu: Remove sdma halt/unhalt during
>> frontdoor load")
>>
> 
> The default reset value of that field is 1. Keeping SDMA unhalted but rings disabled shouldn't ideally be a problem - should be similar to the case when it's loaded also.
> 
> Yes, Lijo, I will remove the related description when submitting. This is our problem. We need a workaround to enable SDMA_CNTL::UTC_L1. Because when we call smu queue reset interface,
> it disables UTC_L1.
> 

Thanks for clarifying. While submitting, please update the description
to indicate that this is related to stop/restart of engines for an
engine reset.

Thanks,
Lijo

> Regards
> Jesse
> Thanks,
> Lijo
> 
>>>
>>> v2: Correct SDMA_CNTL setting (Philip)
>>>
>>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index e6af50c947a1..52157acab55a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -492,7 +492,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct
>>> amdgpu_device *adev,  {
>>>         struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>>>         u32 doorbell_offset, doorbell;
>>> -       u32 rb_cntl, ib_cntl;
>>> +       u32 rb_cntl, ib_cntl, sdma_cntl;
>>>         int i;
>>>
>>>         for_each_inst(i, inst_mask) { @@ -504,6 +504,9 @@ static void
>>> sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
>>>                 ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
>>>                 ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
>>>                 WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
>>> +               sdma_cntl = RREG32_SDMA(i, SDMA_CNTL);
>>> +               sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_ENABLE, 0);
>>> +               WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
>>>
>>>                 if (sdma[i]->use_doorbell) {
>>>                         doorbell = RREG32_SDMA(i,
>>> regSDMA_GFX_DOORBELL); @@ -997,6 +1000,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>>>                 /* set utc l1 enable flag always to 1 */
>>>                 temp = RREG32_SDMA(i, regSDMA_CNTL);
>>>                 temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE,
>>> 1);
>>> +               WREG32_SDMA(i, regSDMA_CNTL, temp);
>>>
>>>                 if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
>>>                         /* enable context empty interrupt during
>>> initialization */
>>> --
>>> 2.34.1
>>>
> 

