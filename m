Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A0606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZUwMT5T8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B4810F71A;
	Tue,  3 Nov 2026 16:57:48 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F263B10F71A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 16:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Azh+gQ+jsRzqv1zHQjPlKFtvWCK/4fsNGD/yh4GxLcLEQhZXceAP7uDe1h37usLqXGhpHUDrauK+K482oKwkyEvz9iga1Tqkd1siGqdUwPSlUZwCy+M4B1F8k3r49CIEAxTmsSFWx8x0ALFBgzlo1FKAI8G0otMuXdbVaXJ6DDKT/a38pG0E5KTXaHKqaxzn3lTUbnUTpj4Ri7qJoyh0rVaSqflo32mOSayYJjDYEbr7wlO8uKMWxDibcujQs6Y/Vo/CVjSyRusrXJg0n0765BXTfBKf5KiBwRIFrJmVJCA7sa43p6hxVUAdOzio7jk8kWroZunDTjLl65PON2ehOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5WTZS+7v288jkx6v11wyipOK5XnXaHnck6y00c6AGg=;
 b=mxu7sDKlCAZBoBwDyfsYy2NP7KC5+6mil+X8uTRQQ0fh3blqd6CA4TX9gjnopsR8WbMbpYBl7CpsNZvV8MmDPQj6h4FJ+uxXIvEOI2Hi8l08V2/oV1e0FUb1VEtOzILHoY+fjcwGCtXcGSeXXlOCny1TWE1ZrvogQR3HX+kiZE1TlUU2CEMkvEqmkk+bzffbw/08LaIw+vUeDNGdTZgv8wIEQ1H68WOlaNAdsZs0HGtcWGGi8VbY8W6CJGdSd1I183UfQbRtW1fOewVasuhhE8y5FwswGMwpgIYego1dYwbgPv2/HlRxJxlttPw/kl6kzmX8cdjMWbJAq3t3P4e1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5WTZS+7v288jkx6v11wyipOK5XnXaHnck6y00c6AGg=;
 b=ZUwMT5T8qA8n/hXdaOJl7BayMZUp+i79Ep3koI9UtzoPuGe/U70AKwCw8t1cnMsX6nj6BSqz2SIr7eEKc+dbG73jEh48kBBGaMnolUwdcg/G1JZe/ZzbSxupFBWk6OJ4aadQbZfJ8//jfpcTgxM/Cz2abxPjAmMDJIz/7dp9TBU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:57:39 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 16:57:38 +0000
Content-Type: multipart/alternative;
 boundary="------------lId1VL25uJNirKQr09lOeY60"
Message-ID: <39984cf9-fe4a-40e3-b076-20bea95f2127@amd.com>
Date: Tue, 3 Nov 2026 11:57:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: "Mishra, Apurv" <Apurv.Mishra@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Faizal, Sahil" <Sahil.Faizal@amd.com>
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
 <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
 <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
 <601d1612-ea3d-4379-9336-9c36e9485230@amd.com>
 <PH9PR12MB13592198ABB2BF96C9F290F41D9F6F2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <ee715a81-5643-4da7-a0b9-7205e34758b5@amd.com>
 <PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::27) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 079cc3fa-9991-4236-dff5-08df39cb8f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|8096899003|10067099003|22082099003|261102123227099003|18002099003|3023799007|13003099007|261021135927099003|56012099006|5023799004|4143699003|11063799006|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: f+mz/VeH8fCQjv0dNz73T3q2JjfBkYWRql7NQhhOatqp0W3mNt26FqNBN58JFihOiov7hQbaQwkzdHE8Ugwz67jrZat56XgQAtx/4NnCiakQcj6tWfPnAUuB2fVB2pEXc8g9QVBIzBgwuJXDWa+iyIO08J/9k+7o0CO5Nuykfj1yJZz/p/+HPnypeeMxDXS3e72vIUAR6WVasRIcapYLtS11bXXb11gjMqKpg/zQj/sddfs6NQR4cuuRmZlzj3IgD2QY2Yi1bLJPknBNGCLZHPPZWe193/K/35EiKncFmBOGeRY/DvDcpD0fYZN+os1c3hQsVSUhmu0IxH8tiMhxmtafcamK2ezlooFgnaTkYoDZSrnmu6r9SV+TaS2h/9m2OuhB7tqlPz4kJd2MO6axwXnjSxlYkamU3cGnd16yYGu3rSIt+huXwxUHHkpkLLy95OgMNXJDfW9uSDptErR3cLQocY4rXlDG5QvygTGo7SeCiQn3OLwmjINpz65A+zqovnOf3JZGQiYu/Ew4vWmaKqwroDM28dVRvov0GzPyFhpOaEWgHKZ8SOu2fqnbZrwoKgzalBTyOWdSEkmF7hJ2NjB8Z/kzoC+LysVMgyBdSTMWhPnd5GHPR5b5uEfJRk21
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(8096899003)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(13003099007)(261021135927099003)(56012099006)(5023799004)(4143699003)(11063799006)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em1memp6UnEvUUdpc3RFSGdPczBYSmN4SUdZVXRISE9iNmpiVUhOcUdCQllr?=
 =?utf-8?B?NlRDdThSVEQ1eDVtWUxIRE85azBWbW1GdnZCTGxya2dnRVBLQUt3RkR0UHJi?=
 =?utf-8?B?TjIwMzRReC9keDdKT2o2RzY0YTRseW4yeHJaZ0NYYUFGdHVLaThZR0srQ3Bl?=
 =?utf-8?B?QUxmVUs3QjNBMTlYTFlRVUF5dVZpTitualAxUlNGTy9Wb0J5bHlpVXdqOWFp?=
 =?utf-8?B?N2wxTTRrUENlMnlHNDRhdjg0Q1VtVDQxQlk0RmJWYTVEcXh1WlVheUszYVFy?=
 =?utf-8?B?RVRIck51NmJxVVEzM2oya09nYjgwb3VoVHU4VUV3ZWRTbzBnZWtKQ2VOTm9R?=
 =?utf-8?B?eTNnSW1xeUU3ZWlPWDZpT2JzUk9udTZTclhySnpoNDlrSmZRenBQR0NVZ3lh?=
 =?utf-8?B?OWJPUUN4eG5QMURsclROY2MyVnpWOW5DNjRNVjhhNkFQQzNCc0JQVDRQdkFB?=
 =?utf-8?B?Ni93bU16MjJFOWNzSnBLNmRQRkdXZWFrMml4dGFmRWEwNVpRL0djNFlsd1hp?=
 =?utf-8?B?bXZTRXZUZkMzVlRoeElOR0RsVUZhWE8yS3JwNmJEcy9rZ2p1TnFldmRuWDlM?=
 =?utf-8?B?cnpWc3pOMFozbTJuNTBhb28ya2lxM1hlTTJ3NHVua200OFA4b0Y2Uk5OUG5h?=
 =?utf-8?B?UzM3Y2xoNi9wN2dTYjNMTVlEU1Q4TkFyL0RKV05ubDY2RmFNVUVFM2w0STk5?=
 =?utf-8?B?OVNncGxMVTBFM3l4WFZQZEVrS1hHcEl1VGVQajNqYlU5b2VqVzdYSzhLS0xW?=
 =?utf-8?B?NXcvRFJxZjZ0WkFmY0lkWDdZcHlYc1RlZjkvN0h5dTZUc243MGlnSjBDVkt4?=
 =?utf-8?B?Z1ZZSFVZaEpUcFVuTUxZUjlXV21sbmxTUHVFU2VjZ1o3eWtaalJmSFhTOXhq?=
 =?utf-8?B?TWE0SnVRcjlpMzU2TTMycUFhSDI1T3JpTExSRy9YdHhoOFpqOWlGWkFjbHFU?=
 =?utf-8?B?cUdUTGZHbG5XaTlSNURTb0k4VkFVN0V1VnRuRWFDT2I3SHVCZ3QrZk92TlpN?=
 =?utf-8?B?MDdyZkdMSGVrb1dUYkkxbjNsaXo3ME9WVlhzNDhWTyt0RnF5NjFCYjNVdHBP?=
 =?utf-8?B?L2hYaG5PQ2k1Rjd1MzNrWUwrSHgwN3B2TWhVRDg3dUVEWkhDeDZNdSsyYWM0?=
 =?utf-8?B?TWEzcEVCQ3RadCtlSTdGV1dmeERjcGw0RS9GUFFnSVpJclVLYkZ2MXROa2I4?=
 =?utf-8?B?NFFMencwTEdvV2tMWWhUVlJxTG80cHJxbW5VV1pOZEZicGdPRFRmRlhhSzI1?=
 =?utf-8?B?Mm5STi9mVDhHbEM0UUhkdUxwbklFMnY5VWVaTVA4ZElCWDlmZnRnejVmRWQv?=
 =?utf-8?B?RnlKcnRnUHlvOUJ3MGZUUUFvNTU3Q3R5b2VHUUEraWZvMW55bUpzbE44UlJB?=
 =?utf-8?B?bjE0RFVlcDh3WWFsMG92YWJvclhWVTZoTDNSMExEUXZDRkRKaHZMZW9xdFVi?=
 =?utf-8?B?RXlvUUdaTjlIN3U0TkpicWVnK1hGaVdncEJuYk1RZit0aDBTbmxKNWFzOVBB?=
 =?utf-8?B?K2E3TXlzSUM2YTVYSzgzM3JNTHRUVWNxa3pQWEFsK3FnVGNNdTRlbWdVZ3hC?=
 =?utf-8?B?WFJiQzBiMUNjUEVpR3RqTnB1L1ViZXV3MXJ5eFIxdFA5cFJFUTl5TENGdm40?=
 =?utf-8?B?QzJ5dlJHYmtRZTFGWTErU3NQc3V6M1cwRFZGQ2J3enEwT2hQbW1OWGtxY0pn?=
 =?utf-8?B?WE8wc3FsK2phN2tGbVBxTFJ5V0ZETEM3UXcvQk5vR2xtQ0dsQjlsRW5RME9R?=
 =?utf-8?B?Y0lZcFJwbjRURzZMY3UrUEE5VjVlREgwNkZnTStML05EaUJQam01UTczVTZR?=
 =?utf-8?B?NURobFpQQ1NYMTFyLzJPd0JiZkFFNDIxZkVGWnZwRUFrU1NFck0wSnRnMWJT?=
 =?utf-8?B?dEIxVlhpTFU3MnFhV1AxREdlengwd2pzemhzR3RpUFg5TnA1NlNyMTB1VGNO?=
 =?utf-8?B?alJobW9OWVRjMm81WWVsMFprSzFETlZQRlFNcVBxZkRlV0IxczlGSXoydDlB?=
 =?utf-8?B?MklLM212QWorSURGMFF3UldNSlRqT0hxQ0RHNnNTQUdRcDZ3eE85NWphV1o4?=
 =?utf-8?B?SGVHUTJWWmxvVTVwUjRqV2Z4WU9reC91TmlyUjZpNVZZRkZOMmRlSVZlT2hC?=
 =?utf-8?B?Qmx0VTFIdExZWmZzSlVJMmRLajRHeDFoRkNRaFBpQysxMmtmRGZUQmlISG5G?=
 =?utf-8?B?S3JHejJQVEthNFdkdDFpelJtdEhwSkJIYW1rRDZYVGRORmIzb3UxYy9ZVnRk?=
 =?utf-8?B?Zm9lSytLeGR2T2RtT2NEbzV6bXVRUkFMellycyt0ZDZMaFNidmMvS1liaG9G?=
 =?utf-8?Q?Hd8YPdR4WoKyYCFkea?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079cc3fa-9991-4236-dff5-08df39cb8f8d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:57:38.4905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb6rqws19+xJMoCvGnv8EUJ5kNaKvaUi8RskmtjXNphZsmzWfbmrfxYQ57+sOWK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------lId1VL25uJNirKQr09lOeY60
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-02 18:32, Mishra, Apurv wrote:
> AMD General
>
> AMD General
>
> Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com>, following up on 
> your comment...
>
> P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8, 
> |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|, then 
> |put_page()| (/mm/memory.c:3861–3864/). The extra reference outlives 
> |migrate_mutex|. By then P's data has already moved to S, and the PTE 
> points to S, so nothing else is wrong.
>
> The wrong place is KFD's reuse. |svm_range_validate_svm_bo()| reuses 
> the |svm_bo| because P's pin keeps it alive. 
> |svm_migrate_copy_to_vram()| then hands out P by offset without 
> checking it, while |zone_device_page_init()| requires the page to be 
> free. The fix adds that check where KFD hands out the page. When the 
> pin is still there, the page stays in system memory with a valid PTE, 
> and the next GPU fault migrates it normally.
>
> Mainline is the same. |do_swap_page()| now holds the page lock across 
> `migrate_to_ram()`, but `zone_device_page_init()` resets the refcount 
> before `lock_page()`. The race remains on mainline, because upstream 
> KFD has no such check. My patch adds it. This has been tested and 
> verified.
>
> Adding @Faizal, Sahil <mailto:Sahil.Faizal@amd.com> for updates as the 
> fix needs to merge soon.
This is the corner case I tried to fix with the patch "drm/amdkfd: Fix 
svm_bo and vram page refcount". That patch was rejected because we 
cannot take a page that is not free and treat it as free and safe to 
use. The approach here makes sense to me: if the page has not been 
freed, we skip it. With that said, this patch is

Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>
> Regards,
> Apurv
>
> ------------------------------------------------------------------------
> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Wednesday, October 28, 2026 6:41 PM
> *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, 
> Alejandro (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com>
> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
> still referenced
>
> On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
> > AMD General
> >
> > Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
> <mailto:Xiaogang.Chen@amd.com>>,
> >
> > The migrations don't overlap. |migrate_mutex| serializes them, but 
> it doesn't
> > cover P's last reference:
> >
> >    *
> >      |svm_migrate_to_ram()| releases |prange->migrate_mutex| at /
> >      kfd_migrate.c:1073/, after the VRAM→RAM migration has finished 
> and before
> >      the function returns.
> >    *
> >
> >      |do_swap_page()| drops its own reference on P only after 
> |migrate_to_ram()|
> >      returns, at /mm/memory.c:4851–4853/.
>
> Before do_swap-page drops the last ref on P the cpu mapping of fault
> address has not been changed. Then at following sys->vram the
> migrate_vma_walk_ops->pmd_entry will not collect this source(sys) page
> because the address there still point to device private page(since you
> got cpu page fault it is device private memory). Then (migrate->src[i] &
> MIGRATE_PFN_MIGRATE) is false.
>
> If P got used at sys->vram, but P is still used by someone else
> something wrong is in other places. Skipping migration does not solve it.
>
> Regards
>
> Xiaogang
>
>
> > So, the GPU fault takes |migrate_mutex| legitimately, while P still 
> has |
> > do_swap_page()|'s reference. KFD gets P back without P ever being 
> freed. VRAM
> > destinations come from the |svm_bo| by offset (`cursor.start + j`), 
> not from a
> > pool of free pages. That |svm_bo| is still alive because P holds a 
> reference on
> > it until P is freed, so |svm_range_validate_svm_bo()| reuses it and 
> the same
> > offset gives P again. Nothing checks whether P's previous user is 
> done with it.
> >
> > Regards,
> > Apurv
> >
> >
> > 
> --------------------------------------------------------------------------------
> > *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
> > *Sent:* Monday, October 26, 2026 5:27 PM
> > *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-
> > gfx@lists.freedesktop.org>
> > *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, 
> Alejandro
> > (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish
> > <Harish.Kasiviswanathan@amd.com>
> > *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
> still referenced
> >
> >
> > On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
> >
> >      AMD General Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
> <mailto:Xiaogang.Chen@amd.com>>
> >      <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>>, 
> thank you for the review. The two migrations
> >      don't overlap on that address; they run back-to-back. What 
> overlaps is the
> >      lifetime of the VRAM page. This was reproduced with ASan and 
> XNACK, which
> >      make concurrent CPU and GPU faults on the same ranges 
> frequently. As per the
> >      logs (ROCM-31012 
> <https://amd-hub.atlassian.net/browse/ROCM-31012 
> <https://amd-hub.atlassian.net/browse/ROCM-31012>> <https://
> >      amd-hub.atlassian.net/browse/ROCM-31012>):  *    A CPU fault 
> enters /
> >      do_swap_page()/, takes a reference on VRAM page P, and /
> >        svm_migrate_to_ram/() moves the data to system page S. The 
> PTE now points
> >      to    S, but /do_swap_page/() still holds P until 
> /migrate_to_ram/()
> >      returns.  *    About 66 µs later, a GPU retry fault migrates 
> the range back
> >      to VRAM. src =    S with /MIGRATE_PFN_MIGRATE /set is correct 
> here, because
> >      the data really is    in system RAM.  *    KFD reuses the 
> /svm_bo/, which P
> >      keeps alive, and gets P again as the    destination. 
> /zone_device_page_init/
> >      (P) runs with ref=1 (traced) and    overwrites the refcount.  *
> >
> > How KFD reuses same P? From the description above CPU fault has not 
> finished
> > because  svm_migrate_to_ram has not returned, P has not been 
> returned to KFD
> > driver, so P still has reference count.
> >
> > Then GPU page fault happen on same range. For each migration on a 
> prange there
> > is prange->migrate_mutex to have migration on the prange happen 
> exclusively.
> > Then how can svm_migrate_to_vram enter migration if 
> prange->migrate_mutex is
> > still hold at svm_migrate_to_ram?
> >
> > My basic concern is a vram page can only be involved at one 
> migration at a
> > moment. If it is getting migrated in two migrations at same time 
> with difference
> > direction there is syn issue. Checking the page ref here to avoid 
> migration is
> > not fixing the root cause.
> >
> > Regards
> >
> > Xiaogang
> >
> >          The CPU fault's /put_page/(P) frees P mid-migration and 
> clears its
> >        mapping. /migrate_vma_finalize/() misses that PTE (263 of 264 
> restored),
> >      and    it's left pointing at S. S is freed, and the next 
> /hmm_range_fault /
> >      hits the    BUG_ON in /swapops.h:504/. The trace and the panic 
> registers
> >      match this page and S exactly. With the fix, the /refcount 
> /check skipped a
> >      busy page 705 times on the repro host with no panic. Regards, Apurv
> > 
> -------------------------------------------------------------------------------- 
> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com> 
> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>> *Sent:* 
> Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv 
> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
> <mailto:Apurv.Mishra@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>> <amd- 
> gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>> *Cc:* Deucher, Alexander 
> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Sierra Guiza, Alejandro (Alex) 
> <Alex.Sierra@amd.com> <mailto:Alex.Sierra@amd.com 
> <mailto:Alex.Sierra@amd.com>>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com> 
> <mailto:Harish.Kasiviswanathan@amd.com 
> <mailto:Harish.Kasiviswanathan@amd.com>> *Subject:* Re: [PATCH] 
> drm/amdkfd: Don't reuse a VRAM page that is still referenced On 
> 10/23/2026 12:17 PM, Apurv Mishra wrote:    In 
> svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount 
> and    leave those pages in system memory for this migration. When an 
> svm_bo is    reused, a VRAM page can still be held by an in-flight CPU 
> fault    (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM then 
> re-initializes the page via zone_device_page_init(), resetting its 
> refcount. The fault's    late put_page() frees the page mid-migration, 
> so migrate_vma_finalize()    never restores that PTE. It is left 
> pointing at a freed system page and    hmm_range_fault() hits BUG_ON 
> in pfn_swap_entry_to_page() (swapops.h). If there is cpu fault the 
> data is in vram page. If at same time driver is migrating data from 
> sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should be false since 
> the data is already at device side. Then if you got a  
> MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram after 
> migrate_vma_setup, but cpu page fault also happened on same page there 
> is a contradict. So, I do not see this scenario can happen or the real 
> cause is revealed. Regards Xiaogang    Signed-off-by: Apurv Mishra 
> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
> <mailto:Apurv.Mishra@amd.com>> --- 
> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    20 +++++++++++++++----- 
> 1 file changed, 15 insertions(+), 5 deletions(-)    diff --git 
> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/    
> amdkfd/kfd_migrate.c index 8b96e1fe741a..1eb92ac6eb05 100644 --- 
> a/drivers/ gpu/drm/amd/amdkfd/kfd_migrate.c +++ 
> b/drivers/gpu/drm/amd/amdkfd/    kfd_migrate.c @@ -297,16 +297,26 @@ 
> svm_migrate_copy_to_vram(struct kfd_node    *node, struct svm_range 
> *prange, amdgpu_res_first(prange->ttm_res,    ttm_res_offset, npages 
> << PAGE_SHIFT, &cursor); for (i = j = 0; (i < npages)    && (mpages < 
> migrate->cpages); i++) { - struct page *spage; + struct page    *spage 
> = migrate_pfn_to_page(migrate->src[i]); if (migrate->src[i] &    
> MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j << PAGE_SHIFT); 
> migrate-     >dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]); - 
> svm_migrate_get_vram_page(prange, migrate->dst[i]); - migrate->dst[i] 
> =    migrate_pfn(migrate->dst[i]); - mpages++; + /* + * A reused 
> svm_bo page may    still be held by a CPU fault. + * Reinitializing it 
> would free it under this migration, + * so leave this page in system 
> memory. + */ + if (page_ref_count(pfn_to_page(migrate->dst[i]))) { + 
> dst[i] = 0; + migrate-     >dst[i] = 0; + spage = NULL; + } else { + 
> svm_migrate_get_vram_page(prange,    migrate->dst[i]); + 
> migrate->dst[i] = migrate_pfn(migrate->dst[i]); + mpages++; + } } - 
> spage = migrate_pfn_to_page(migrate->src[i]); if (spage    && 
> !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 0,    
> PAGE_SIZE,      DMA_BIDIRECTIONAL);
> >

--------------lId1VL25uJNirKQr09lOeY60
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-02 18:32, Mishra, Apurv
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <div>
        <div style="font-family: Calibri; text-align: left; color: rgb(0, 0, 255); margin-left: 5pt; font-size: 10pt;">
          AMD General</div>
        <br>
      </div>
      <div class="elementToProof" style="text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
        AMD General</div>
      <div class="elementToProof"><br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Hi, <a href="mailto:Xiaogang.Chen@amd.com" id="OWAAM873340" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">
          @Chen, Xiaogang</a>, following up on your comment...</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        P's other user is <code>do_swap_page()</code>'s own pin. On
        Ubuntu 6.8, <code>do_swap_page()</code> calls
        <code>get_page()</code>, then <code>migrate_to_ram()</code>,
        then <code>put_page()</code> (<i>mm/memory.c:3861–3864</i>).
        The extra reference outlives
        <code>migrate_mutex</code>. By then P's data has already moved
        to S, and the PTE points to S, so nothing else is wrong.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        The wrong place is KFD's reuse. <code>svm_range_validate_svm_bo()</code>
        reuses the
        <code>svm_bo</code> because P's pin keeps it alive. <code>svm_migrate_copy_to_vram()</code>
        then hands out P by offset without checking it, while
        <code>zone_device_page_init()</code> requires the page to be
        free. The fix adds that check where KFD hands out the page. When
        the pin is still there, the page stays in system memory with a
        valid PTE, and the next GPU fault migrates it normally.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Mainline is the same. <code>do_swap_page()</code> now holds the
        page lock across `migrate_to_ram()`, but
        `zone_device_page_init()` resets the refcount before
        `lock_page()`.&nbsp;The race remains on mainline, because upstream
        KFD has no such check. My patch adds it. This has been tested
        and verified.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Adding <a id="OWAAM556080" class="tWKOu mention ms-bgc-nlr ms-fcl-b" href="mailto:Sahil.Faizal@amd.com" moz-do-not-send="true">
          @Faizal, Sahil</a>&nbsp;for updates as the fix needs to merge soon.</div>
    </blockquote>
    This is the corner case I tried to fix with the patch &quot;drm/amdkfd:
    Fix svm_bo and vram page refcount&quot;. That patch was rejected because
    we cannot take a page that is not free and treat it as free and safe
    to use. The approach here makes sense to me: if the page has not
    been freed, we skip it. With that said, this patch is<br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com">
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Regards,</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Apurv</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <hr style="display: inline-block; width: 98%;">
      <div id="divRplyFwdMsg" class="elementToProof">
        <div class="elementToProof" style="direction: ltr; font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <b>From:</b> Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a><br>
          <b>Sent:</b> Wednesday, October 28, 2026 6:41 PM<br>
          <b>To:</b> Mishra, Apurv <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Sierra Guiza, Alejandro
          (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>; Kasiviswanathan, Harish
          <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH] drm/amdkfd: Don't reuse a VRAM
          page that is still referenced</div>
        <div class="elementToProof" style="direction: ltr;">&nbsp;</div>
      </div>
      <div class="elementToProof" style="font-size: 11pt;"><br>
        On 10/27/2026 8:19 PM, Mishra, Apurv wrote:<br>
        &gt; AMD General<br>
        &gt;<br>
        &gt; Hi, @Chen, Xiaogang &lt;<a href="mailto:Xiaogang.Chen@amd.com" id="OWAeb706324-580c-39fc-9aaa-d63218f45b7e" class="OWAAutoLink" moz-do-not-send="true">mailto:Xiaogang.Chen@amd.com</a>&gt;,<br>
        &gt;<br>
        &gt; The migrations don't overlap. |migrate_mutex| serializes
        them, but it doesn't<br>
        &gt; cover P's last reference:<br>
        &gt;<br>
        &gt;&nbsp;&nbsp;&nbsp; *<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |svm_migrate_to_ram()| releases
        |prange-&gt;migrate_mutex| at /<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_migrate.c:1073/, after the VRAM→RAM migration has
        finished and before<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the function returns.<br>
        &gt;&nbsp;&nbsp;&nbsp; *<br>
        &gt;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |do_swap_page()| drops its own reference on P only
        after |migrate_to_ram()|<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; returns, at /mm/memory.c:4851–4853/.<br>
        <br>
        Before do_swap-page drops the last ref on P the cpu mapping of
        fault<br>
        address has not been changed. Then at following sys-&gt;vram the<br>
        migrate_vma_walk_ops-&gt;pmd_entry will not collect this
        source(sys) page<br>
        because the address there still point to device private
        page(since you<br>
        got cpu page fault it is device private memory). Then
        (migrate-&gt;src[i] &amp;<br>
        MIGRATE_PFN_MIGRATE) is false.<br>
        <br>
        If P got used at sys-&gt;vram, but P is still used by someone
        else<br>
        something wrong is in other places. Skipping migration does not
        solve it.<br>
        <br>
        Regards<br>
        <br>
        Xiaogang<br>
        <br>
        <br>
        &gt; So, the GPU fault takes |migrate_mutex| legitimately, while
        P still has |<br>
        &gt; do_swap_page()|'s reference. KFD gets P back without P ever
        being freed. VRAM<br>
        &gt; destinations come from the |svm_bo| by offset
        (`cursor.start + j`), not from a<br>
        &gt; pool of free pages. That |svm_bo| is still alive because P
        holds a reference on<br>
        &gt; it until P is freed, so |svm_range_validate_svm_bo()|
        reuses it and the same<br>
        &gt; offset gives P again. Nothing checks whether P's previous
        user is done with it.<br>
        &gt;<br>
        &gt; Regards,<br>
        &gt; Apurv<br>
        &gt;<br>
        &gt;<br>
        &gt;
--------------------------------------------------------------------------------<br>
        &gt; *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a><br>
        &gt; *Sent:* Monday, October 26, 2026 5:27 PM<br>
        &gt; *To:* Mishra, Apurv <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a> &lt;amd-<br>
        &gt; <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>&gt;<br>
        &gt; *Cc:* Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
        Sierra Guiza, Alejandro<br>
        &gt; (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>; Kasiviswanathan, Harish<br>
        &gt; <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
        &gt; *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page
        that is still referenced<br>
        &gt;<br>
        &gt;<br>
        &gt; On 10/26/2026 1:12 PM, Mishra, Apurv wrote:<br>
        &gt;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD General Hi, @Chen, Xiaogang &lt;<a href="mailto:Xiaogang.Chen@amd.com" id="OWA53c6fadf-6c71-168a-bcc2-1be8c432a31b" class="OWAAutoLink" moz-do-not-send="true">mailto:Xiaogang.Chen@amd.com</a>&gt;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;<a href="mailto:Xiaogang.Chen@amd.com" id="OWAf573e14b-b459-080b-cfcb-074f6b0953c1" class="OWAAutoLink" moz-do-not-send="true">mailto:Xiaogang.Chen@amd.com</a>&gt;,
        thank you for the review. The two migrations<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; don't overlap on that address; they run back-to-back.
        What overlaps is the<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lifetime of the VRAM page. This was reproduced with
        ASan and XNACK, which<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make concurrent CPU and GPU faults on the same ranges
        frequently. As per the<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logs (ROCM-31012 &lt;<a href="https://amd-hub.atlassian.net/browse/ROCM-31012" id="OWA9c523303-93d4-1701-62d7-9c6529ef7ac0" class="OWAAutoLink moz-txt-link-freetext" data-auth="NotApplicable" moz-do-not-send="true">https://amd-hub.atlassian.net/browse/ROCM-31012</a>&gt;
        &lt;https://<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-hub.atlassian.net/browse/ROCM-31012&gt;):&nbsp; *&nbsp;&nbsp;&nbsp; A
        CPU fault enters /<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_swap_page()/, takes a reference on VRAM page P, and
        /<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_to_ram/() moves the data to system page
        S. The PTE now points<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to&nbsp;&nbsp;&nbsp; S, but /do_swap_page/() still holds P until
        /migrate_to_ram/()<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; returns.&nbsp; *&nbsp;&nbsp;&nbsp; About 66 µs later, a GPU retry fault
        migrates the range back<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to VRAM. src =&nbsp;&nbsp;&nbsp; S with /MIGRATE_PFN_MIGRATE /set is
        correct here, because<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the data really is&nbsp;&nbsp;&nbsp; in system RAM.&nbsp; *&nbsp;&nbsp;&nbsp; KFD reuses
        the /svm_bo/, which P<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keeps alive, and gets P again as the&nbsp;&nbsp;&nbsp; destination.
        /zone_device_page_init/<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (P) runs with ref=1 (traced) and&nbsp;&nbsp;&nbsp; overwrites the
        refcount.&nbsp; *<br>
        &gt;<br>
        &gt; How KFD reuses same P? From the description above CPU fault
        has not finished<br>
        &gt; because&nbsp; svm_migrate_to_ram has not returned, P has not
        been returned to KFD<br>
        &gt; driver, so P still has reference count.<br>
        &gt;<br>
        &gt; Then GPU page fault happen on same range. For each
        migration on a prange there<br>
        &gt; is prange-&gt;migrate_mutex to have migration on the prange
        happen exclusively.<br>
        &gt; Then how can svm_migrate_to_vram enter migration if
        prange-&gt;migrate_mutex is<br>
        &gt; still hold at svm_migrate_to_ram?<br>
        &gt;<br>
        &gt; My basic concern is a vram page can only be involved at one
        migration at a<br>
        &gt; moment. If it is getting migrated in two migrations at same
        time with difference<br>
        &gt; direction there is syn issue. Checking the page ref here to
        avoid migration is<br>
        &gt; not fixing the root cause.<br>
        &gt;<br>
        &gt; Regards<br>
        &gt;<br>
        &gt; Xiaogang<br>
        &gt;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The CPU fault's /put_page/(P) frees P
        mid-migration and clears its<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping. /migrate_vma_finalize/() misses that PTE
        (263 of 264 restored),<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and&nbsp;&nbsp;&nbsp; it's left pointing at S. S is freed, and the
        next /hmm_range_fault /<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hits the&nbsp;&nbsp;&nbsp; BUG_ON in /swapops.h:504/. The trace and
        the panic registers<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match this page and S exactly. With the fix, the
        /refcount /check skipped a<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; busy page 705 times on the repro host with no panic.
        Regards, Apurv<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
--------------------------------------------------------------------------------
        *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a> &lt;<a href="mailto:Xiaogang.Chen@amd.com" id="OWAf492ed8c-7b44-283c-5703-a3fc2a108ae6" class="OWAAutoLink" moz-do-not-send="true">mailto:Xiaogang.Chen@amd.com</a>&gt;
        *Sent:* Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv
        <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a> &lt;<a href="mailto:Apurv.Mishra@amd.com" id="OWA05f03db0-d9be-acf2-7576-1d876e75b5eb" class="OWAAutoLink" moz-do-not-send="true">mailto:Apurv.Mishra@amd.com</a>&gt;;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a> &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" id="OWA39a186f9-04bd-61e8-09ae-9768d9ce21fc" class="OWAAutoLink" moz-do-not-send="true">mailto:amd-gfx@lists.freedesktop.org</a>&gt;
        &lt;amd- <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>&gt; &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" id="OWA81d5eda8-3daf-ac00-432f-846281313df4" class="OWAAutoLink" moz-do-not-send="true">mailto:amd-gfx@lists.freedesktop.org</a>&gt;
        *Cc:* Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a> &lt;<a href="mailto:Alexander.Deucher@amd.com" id="OWAa00f18f3-a9f2-0819-17f0-f38fca5b0ea0" class="OWAAutoLink" moz-do-not-send="true">mailto:Alexander.Deucher@amd.com</a>&gt;;
        Sierra Guiza, Alejandro (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a> &lt;<a href="mailto:Alex.Sierra@amd.com" id="OWA428b0b06-bd8d-46e5-b533-288775ae5729" class="OWAAutoLink" moz-do-not-send="true">mailto:Alex.Sierra@amd.com</a>&gt;;
        Kasiviswanathan, Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
        &lt;<a href="mailto:Harish.Kasiviswanathan@amd.com" id="OWAce6dd02e-5e6b-6cc8-81c1-366734b25081" class="OWAAutoLink" moz-do-not-send="true">mailto:Harish.Kasiviswanathan@amd.com</a>&gt;
        *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that
        is still referenced On 10/23/2026 12:17 PM, Apurv Mishra
        wrote:&nbsp;&nbsp;&nbsp; In svm_migrate_copy_to_vram(), skip VRAM pages with a
        non-zero refcount and&nbsp;&nbsp;&nbsp; leave those pages in system memory for
        this migration. When an svm_bo is&nbsp;&nbsp;&nbsp; reused, a VRAM page can
        still be held by an in-flight CPU fault&nbsp;&nbsp;&nbsp; (do_swap_page -&gt;
        svm_migrate_to_ram). Migrating to VRAM then re-initializes&nbsp;&nbsp;&nbsp;
        the page via zone_device_page_init(), resetting its refcount.
        The fault's&nbsp;&nbsp;&nbsp; late put_page() frees the page mid-migration, so
        migrate_vma_finalize()&nbsp;&nbsp;&nbsp; never restores that PTE. It is left
        pointing at a freed system page and&nbsp;&nbsp;&nbsp; hmm_range_fault() hits
        BUG_ON in pfn_swap_entry_to_page() (swapops.h). If there is cpu
        fault the data is in vram page. If at same time driver is
        migrating data from sys-&gt;vram&nbsp; migrate-&gt;src[i] &amp;
        MIGRATE_PFN_MIGRATE should be false since the data is already at
        device side. Then if you got a&nbsp; MIGRATE_PFN_MIGRAT sys ram page
        at svm_migrate_copy_to_vram after migrate_vma_setup, but cpu
        page fault also happened on same page there is a contradict. So,
        I do not see this scenario can happen or the real cause is
        revealed. Regards Xiaogang&nbsp;&nbsp;&nbsp; Signed-off-by: Apurv Mishra
        <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a> &lt;<a href="mailto:Apurv.Mishra@amd.com" id="OWA58c06092-9369-a88d-ea98-01d0cc8820e2" class="OWAAutoLink" moz-do-not-send="true">mailto:Apurv.Mishra@amd.com</a>&gt;
        &lt;<a href="mailto:Apurv.Mishra@amd.com" id="OWAf419e9cd-d4ce-30df-090f-855865230518" class="OWAAutoLink" moz-do-not-send="true">mailto:Apurv.Mishra@amd.com</a>&gt;
        &lt;<a href="mailto:Apurv.Mishra@amd.com" id="OWA09a0111f-f6e9-d8c8-db8b-ffd31519ab02" class="OWAAutoLink" moz-do-not-send="true">mailto:Apurv.Mishra@amd.com</a>&gt;
        --- drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |&nbsp;&nbsp;&nbsp; 20
        +++++++++++++++----- 1 file changed, 15 insertions(+), 5
        deletions(-)&nbsp;&nbsp;&nbsp; diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/&nbsp;&nbsp;&nbsp; amdkfd/kfd_migrate.c index
        8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/&nbsp;&nbsp;&nbsp;
        gpu/drm/amd/amdkfd/kfd_migrate.c +++
        b/drivers/gpu/drm/amd/amdkfd/&nbsp;&nbsp;&nbsp; kfd_migrate.c @@ -297,16
        +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node&nbsp;&nbsp;&nbsp; *node,
        struct svm_range *prange,
        amdgpu_res_first(prange-&gt;ttm_res,&nbsp;&nbsp;&nbsp; ttm_res_offset, npages
        &lt;&lt; PAGE_SHIFT, &amp;cursor); for (i = j = 0; (i &lt;
        npages)&nbsp;&nbsp;&nbsp; &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) { -
        struct page *spage; + struct page&nbsp;&nbsp;&nbsp; *spage =
        migrate_pfn_to_page(migrate-&gt;src[i]); if (migrate-&gt;src[i]
        &amp;&nbsp;&nbsp;&nbsp; MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j
        &lt;&lt; PAGE_SHIFT); migrate-&nbsp;&nbsp;&nbsp;&nbsp; &gt;dst[i] =
        svm_migrate_addr_to_pfn(adev, dst[i]); -&nbsp;&nbsp;&nbsp;
        svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]); -
        migrate-&gt;dst[i] =&nbsp;&nbsp;&nbsp; migrate_pfn(migrate-&gt;dst[i]); -
        mpages++; + /* + * A reused svm_bo page may&nbsp;&nbsp;&nbsp; still be held by
        a CPU fault. + * Reinitializing it would free it under this&nbsp;&nbsp;&nbsp;
        migration, + * so leave this page in system memory. + */ + if&nbsp;&nbsp;&nbsp;
        (page_ref_count(pfn_to_page(migrate-&gt;dst[i]))) { + dst[i] =
        0; + migrate-&nbsp;&nbsp;&nbsp;&nbsp; &gt;dst[i] = 0; + spage = NULL; + } else { +
        svm_migrate_get_vram_page(prange,&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i]); +
        migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]); +&nbsp;&nbsp;&nbsp;
        mpages++; + } } - spage =
        migrate_pfn_to_page(migrate-&gt;src[i]); if (spage&nbsp;&nbsp;&nbsp; &amp;&amp;
        !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage,
        0,&nbsp;&nbsp;&nbsp; PAGE_SIZE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_BIDIRECTIONAL);<br>
        &gt;</div>
    </blockquote>
    <br>
  </body>
</html>

--------------lId1VL25uJNirKQr09lOeY60--
