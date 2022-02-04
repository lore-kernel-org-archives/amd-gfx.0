Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FEBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 17:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D6C610EE34;
	Fri,  4 Feb 2022 17:22:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD61A10EE30
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 17:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAV/p4NmPZvFjRZIm+74t/tQx47m7JmQ19UrY4+BZZgArq7bqZdTEfvLZFFejPSYeHKZLKT+MjxhBGx5qu5dl0M6Nd3xLcNcC10CSTgfSib2x7H7/BVxjcHGOD6KDOvdesBB6NFdYTisTuY9+EV950gotPciEYomfOZrqQoFmpgpC7Ix3ukOv30kxbJOS9sHSl6zsvi4Mrhr+82ekSENR4VNZz2FJEebfxGvG/VxirACU1rCaQs/rj5dGmCmGpF8b9rTcexztr/3sDHF5Kv5lRlkR/r0pLcZoU9JOgeoBiEW1dAVcz7hF1TK5WOS0pTRvZV5YsgJILB7guU+mc+5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQDv1F+dy8/mH8oc8+kFS7KDF6tX9ykkVU5fuTwN/J0=;
 b=heJ38V42Rj96bMoviZC3fL6cFZqCAWmgUNGJw5NqmIIQXtMU236Ud0krHuZWWoY9oLpp1LZKFsfsnO9kt8oZOH09mI/m5YvFkBocV2uQ2eBp7XCIa0zfKg6axa9rm50WO9RVKjGQ3JtA5gY4+A9uwYEsxbFc/eOzh5ou39bnXxF5TBNIBN/nhEUL4dFv7phElv90Z+2R5MbALsRVrs1n48wuGOZic8OiCrgCIl8RJSoyE8DWGg4vDp9j++IwRkQEkqHQ3T1vUdSoz9uEgJjkb/sCHTPSFpRuvIdLzjI3j23ymdEQV2gpUc83TQFmjwU4l2V2p9KoDYKXsqNKSxnvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQDv1F+dy8/mH8oc8+kFS7KDF6tX9ykkVU5fuTwN/J0=;
 b=pd9ParTXvkluiTKb59p6Ojse2s6Yj3MqaOS0wPR21TtRWQjickrYWmalO9OT8a1Bxbmn8jWLSmfLz8bGkE281JevYGOMIxtFVAwlFim5AKctMCimOqV8uTNhFVkWmLxdQWwt5Q8os9KhETayNTW9PPBaLYRWOGUwuhPvKPDVTCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 17:22:37 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 17:22:37 +0000
Message-ID: <b885ef98-3ff3-92b3-c238-041a0f5ab2a6@amd.com>
Date: Fri, 4 Feb 2022 18:22:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
 <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <77fd42df-be70-18bd-ebb8-503214ef6af8@amd.com>
 <BYAPR12MB461419D8152EBBD70BB9BAFC97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <c28e3fad-29ac-a326-30c3-4f4de0001e47@amd.com>
 <BYAPR12MB4614628DE8E6D39EE53307DF97299@BYAPR12MB4614.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BYAPR12MB4614628DE8E6D39EE53307DF97299@BYAPR12MB4614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0502CA0040.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ec3b13-cc1e-47a5-9c4e-08d9e802f034
X-MS-TrafficTypeDiagnostic: BL0PR12MB4882:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB48827C884772B06A5585122EF2299@BL0PR12MB4882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQ4tx1tlTF3EqTzS4KAag86A8hERuYXorRM9RgDL3Rs9UESy5+Sorbp2GWANesHpQzDqm7O98+65O7Np9AQJ95mlYZHbiQRyMeF+S21D9b+KGGXYbnJm5bCfl3+mc/+tQp76ffv6HCgNIdDjjS0j3DvpBlQFAo3VRVgmLCS8wOLCMyFR/4ylaBY0U4Lg7nZ24FFB5yQjE8jfPLWJhu3cpQgQn7/6C/QoFZ2k4/KlHawTyqNjaZW3cquV1CXlf36+mh/0MyWPHrOoASYG8QRGjJonewvr3MFiRmOc9jbtLu1zshM01/CxF3r0dp3iS8VZRfNYhqGRBbm/7DrInijsAs3hyFXrQ6rd5jISj7SYX1OXGs5FsxtIGTxande9cAuKETwBwdurTFJpbuszfkQps7mUoBsowNxylsksb9jmv6eyNxQ+SpFFkR6ccLKn5TUgnSUeyBVjCKaQs1aWm7YdP7cUKu2S6AGrsyrxjkMUAcST3/3uVpYFJpTlvg6FJ1j32mXaf3+dVToRnGSEzLA/aLDlPL0QV5YKMTQafYt189Mb8+buoVwzWQ0EUNG04nP3LsReBpBV37/+mVXU4eyrasFNguVk0jP+W3m7vLR0JEoze/H7t6A+DR/oSE5k4fnJ0RNlZtvKrwbT71desULlJRSHIJj2SLbHyQoNHXXYGqqE/H9tGG8kFWbhgoVMdWvuh3O1t37lwPvVUhEMOR2VMYZqq/PGXdV9gY7WcW18tVNYLwUybKY/0PhPI40ovipR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(5660300002)(83380400001)(6506007)(6666004)(26005)(2616005)(38100700002)(31686004)(186003)(110136005)(36756003)(66476007)(54906003)(4326008)(6486002)(8936002)(8676002)(6512007)(2906002)(508600001)(86362001)(316002)(31696002)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1A4T1pORmJQNnlZbFFJTkQ0SlVXVFp2OHoyU21qemg1UUdoODVFUmFsSWVW?=
 =?utf-8?B?SFc3TWNndkZjbVNMcnVpckhFTjRwTnpiblJSQ3o4L3hSYmFUdU9HSzU0aCt6?=
 =?utf-8?B?MWpPRk5QT0U1cWV0WTR0RHVqMTgyV2tHQ2lITzN4YkN5em94clFKZUtGVlYw?=
 =?utf-8?B?MDVxYUplSkptRWFjcWpZSnZ6VnpkbE1YKzZLTVQxY3Q2L3B2RXVBV1pVd0l0?=
 =?utf-8?B?UjIraHhXaWxBVlFKb04rU2V1NFUwSmJrTnhCcHh1NWpGSXdjeVRRS3kyc0lO?=
 =?utf-8?B?TGFLaFdTbkw0NFNhUHlBeHpkKzZEQWZadWd6K3NaSVNYSFkyVWZYbnB4RUs3?=
 =?utf-8?B?NTVkNUJoUDN1WEc2cXBLandpNW5wT2kwbmJDdXU3Mjdmd0IxcVZOZTduQk80?=
 =?utf-8?B?RHlWbmhUMXArMi9yY08vZ2VYTG1RMlpaTVpHQmQ5ZnlEeHpuaHVkby9jSmNC?=
 =?utf-8?B?TGZ0MGY3U0o0dGR4dnRSOEVpeG5FVWkvakl3WlU1bkJKSnFFdmcxRzFXTmJX?=
 =?utf-8?B?SE10UFlaZzFtV29mT2twOERJemJtWlk2bTBYWjhRelBiQnFoRGxVSXVTVzVT?=
 =?utf-8?B?T0tHaU90UGJHbjVIZy9EZTVoVW5ya2dEWkpyS3JUMGQ2RnkvdTBqbDRnN0N0?=
 =?utf-8?B?aVRvNjNZVHljUDFhYWQ5Sjg4YmI4dFBzUEFja2UycWxQOUZibEtKQkhyZUZk?=
 =?utf-8?B?UDQ0Rlpzd3llQ3BoUzlXTFdKUDlHRW0wNC9JUHl1dFR2R0NMUmhEZ3NTKyts?=
 =?utf-8?B?dEpjdlZLbmE3ZkVrT3J2MFJHWlZHMVhWSUtRbStTVFZFajVITFptdHlham0r?=
 =?utf-8?B?a3Ewb0ZObVlIck1sSXpsMzVUV2s2YVVqbnhKanMxWHUyZjRUTDJYcXlEdzNU?=
 =?utf-8?B?MW5tUVlFS0NhbUhrU1BFRDY1cmhVNDcvTk9za3ZsUDEydCtRTmNzWkp3eTZu?=
 =?utf-8?B?OUM1OE9EQXc1bUpoRHQvSC9xRnZxdk9KRGJwUmtHbGpYa3lTWmlPc09JeERM?=
 =?utf-8?B?YVBINVBtT3dnaVJjN2lMTFdUVXFoKytTbDNyd1BsM0NQU2tpTlZyK0FZQ29W?=
 =?utf-8?B?d1lPa0pvdGRXQ2ZQYTJsUTJwdVlIN0JTMkZyYU0zckRkRzFzRmtXSFdxeGI2?=
 =?utf-8?B?UXRwVDZNSGswSjFaUmZaMzVLcXc0VldjSnBxUS9tMGQ4aWFKSVZQM2FRRHlE?=
 =?utf-8?B?OXhDZXdnY1pBVXViekNMc0tNYlVGMEJ5cWo3bXk0SklpczVvekI5alhPUjFp?=
 =?utf-8?B?S0tVNEh1WjE0SGx0Ym93RVRIRVFJdVRsM3FIRitkS0lFNGx5N2tUTEEwUCtU?=
 =?utf-8?B?dkFPTlNTbkZtdmI1NkR3Y2FVNTM1TkIvb3QxUi95YWxxTnArL2JBQ2JCeFFn?=
 =?utf-8?B?Qkk5YklqTWFYbGNvMldWR0NNbzRhQWc0MzljME14WjlaakRGME41TzFLcU9w?=
 =?utf-8?B?b1Y2K3lXbUU4K0UrOWZoOUVaU1hNbXJJZWUvOEFTOGZyMHRhSWZka2ZDY3RU?=
 =?utf-8?B?RmlkK1V3ckI1blFUOFlYaGJWdUJWNkNjR2RrWHo4V2FOdHltME9wVmkvUUVz?=
 =?utf-8?B?d2JubElVb0NEY0hodDM1elMwTHVjRWhQc05mMEhyV3hnb2F2YmR3bFVTbGxN?=
 =?utf-8?B?Q1JQdWdZZUZyK0hqYVZjdlNYZHdtRnorV0ljOWgwTkNtaUFKWFB6R1VmQXBa?=
 =?utf-8?B?bVpPbUU1RlY3NElyandsZG5mdi8yL0xxOXlqNldqRTUvdmNyN1doZGwrWGJZ?=
 =?utf-8?B?MGwxNGZxZis4cEV5VzFsWWIyOEYyZERUY2h0VVV0ZU9tMjY4bUNqSjdIcFcr?=
 =?utf-8?B?OFMyUWgzVklxVW9jb2lyYVVlTUtvcGxiMGo3YVlLTEk2WmkzQlhsZDlnVzBR?=
 =?utf-8?B?c1Zib3JzM3hQZEVqTHNaeEZpU1VsNjBka2IxMFU4REhiUCtoODVVczh2SXRO?=
 =?utf-8?B?VTBxSkxIOUhkZmRxOS9NNlhmdGJGcXJjbjI1UkM1SFdrV01NNWJHaXR5YzV5?=
 =?utf-8?B?YXo2TnRoSGxYaklmN0gyZGtOdlZLK21LVTB0K3pCcHB6TnFmamE4cnJKWnhO?=
 =?utf-8?B?ZXZKV2pXTm5aVW9qM1FUMjBXN2I1WU9aQjFsRTREYm9DQ0t4UWI3aTUyM0Fu?=
 =?utf-8?B?K3RqOUFQQWd0L01EWE9LMGNmSmMrTHRiWGQzKy9Gd1drL0tqb3dPN2c1QmFW?=
 =?utf-8?Q?qO1edZPSK0IRYKEw0ks8lG4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ec3b13-cc1e-47a5-9c4e-08d9e802f034
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:22:37.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpY6ZmmedXtz2QSI2gYgf6zeIR1bZOvT4aDLOhWPaIWFnJksPJhi0VKa1L9omYApQVF75/dKpJMQxePE6oNy3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/4/2022 6:20 PM, Lazar, Lijo wrote:
> [AMD Official Use Only]
> 
> One more thing
> 	In suspend-reset case, won't this cause to schedule a work item on suspend? I don't know if that is a good idea, ideally we would like to clean up all work items before going to suspend.
> 
> Thanks,
> Lijo

Again, this opens scope for discussion. What if there is a GPU error 
during suspend-reset, which is very probable case.

- Shashank

> 
> -----Original Message-----
> From: Sharma, Shashank <Shashank.Sharma@amd.com>
> Sent: Friday, February 4, 2022 10:47 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
> 
> 
> 
> On 2/4/2022 6:11 PM, Lazar, Lijo wrote:
>> BTW, since this is already providing a set of values it would be useful to provide one more field as the reset reason - RAS error recovery, GPU hung recovery or something else.
> 
> Adding this additional parameter instead of blocking something in kernel, seems like a better idea. The app can filter out and read what it is interested into.
> 
> - Shashank
