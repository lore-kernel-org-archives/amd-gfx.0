Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617C4C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8D36128C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8D36128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E89E6E7D9;
	Tue, 22 Jun 2021 16:50:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA60F6E7D7;
 Tue, 22 Jun 2021 16:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXlrDpSHypmBlreLa0WeXFhcI6bVU+aHZrQI0aRhF5Cj1k5xkB4vWjNYI0L53IfVjgLmpcZ8pUCeke+hJ0O6xQwgvDnsUPE8DsHNJGoJfPEac47n5jd8eo9RJA4mxSo6R+KWrliisuh8SiNhc3BzVvyZOEtTeeneLBEL4VkJRsoRvYpfRaArQEbkvmrnvP9I65CX2j7qXruZRX8z9K/iR9VqZbUw2jFyLFdA+TpnTz/xPCZPDxKOi5a5hBnTylApfu9mTxpHDUPcC66r8rIOPsKduvHQ+vgptbhSB4rWArRYMA9oF/vtTP8j/lL6QH33mC0uUR0kYtyhwd1Z8PZurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QJk1RwjbJysXjmEtyuCw9B4HF0nTNPwhsXJgXcUKe4=;
 b=iSViKFhHsvMH8t+msvg6QZ04M1Z1L88bjBEQIzK58jeTBeKxvhL+9oLflgaCGOaiyk8HGx+hogL1FVZ0UHhdsVGS4kjSiW4hcWv0f8aTe7eoALzLYwJ6xbsLxTcq98vDIqdECOACCW0KGmIM5s24Xnhavn7pqHNyQ/jULxnya9rg4W82uvzYRjojbtcCHn2pC92T19e5vM4BJauPazhRoMI+93Tgij6W70hdmSCdW41s04RttqTyB/Ej0kFB4xr9srbUi0Ypktrwp1Vuo6CP3vMHmt24+meq10kczSiVTEq1viUpG3iW9MqS3/2gVXUBa688HeQFPUukCu9hLtDWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QJk1RwjbJysXjmEtyuCw9B4HF0nTNPwhsXJgXcUKe4=;
 b=1S2XLXyV3rDWOLDGutvQMK96gSyNBqp1ST2exTOM3xBUFl+1YowU7Pxk6qse6vnrjDLfUE+ZBn/IL7vVfW96vwyDkFYEzLxTvvrECrQbSv255pYz1PeuEcslBbmoaO1kmXgU/kwtZYoAgmcMHCmgjWGuWqpZ1Z9YwhNHmr739X8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Tue, 22 Jun
 2021 16:50:13 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 16:50:12 +0000
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <79470314-efab-4e93-b65f-881d5a26222d@amd.com>
Date: Tue, 22 Jun 2021 12:50:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 16:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98a839a2-3390-4438-3487-08d9359dcdbd
X-MS-TrafficTypeDiagnostic: BN9PR12MB5209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52097F315BC3A507C10D1D0292099@BN9PR12MB5209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgbReVCYVUXmFtnI8AuuEzODlnCSBvWk0PKJ7YKpS6r+Op3cDCD7uEyuffR8mdiJI9U+yb9yLiHZAXQqbOmkgDVQjMZN3atoMbRIrmQsFDc7ZEGCBgz+cdJPzmglPQ5IuiDnBh4s/kHMMCaPxxFKUBl3wOIpzM3zWR2W816AYC4NfoSwlZNw2QrPef5bZv5VOg9XFza3Hv7ZBPqaVI4d+KJdmBBOf+LN3xzR5P7aQuwNMBEygI6PFRfEv6+j1Sjn0vkM4CQVBtk2ZpHc1IP4kfFJbZIxgO8EVSFAVF7A/btUyO9yYErFbWoMKf3KaoAHoEqU9qbcgjjkjriuNGz29wxY/dvmHScEvqkUsNdNmFzCMRTWYyJ6OKZvE+6rNkiS3hPnWQQLnd+MBsxbb6EZIJXAFIeY0iLa6opC/xviePKrFFXTxrkw1oojfyWV/02SLENHKXiyLlIaWpXOBhxjCr8vov0mGksh/YyE3pGJJ6b2ApW6FHw+ddWFlBdZ5DFdkd6IxjnR+CBXSY0l9e1rZwMe4dVMFEnXX4qlpD7XyIMc8oFt0Yp0uJctnqFCkGC9iD296Y/3Czfx3RtxMCiOzhqCGikxnPXRF04l80vX0AlPpTva6mlS9F2lqa7iLHyRSiB7AS7BRZVc45g2OtA3n8uSk2MW7F/i+06MQidst5PPc42fbFIHHjrEtuchNKu/XDTrhC3NfQi8CRsieW5Lj9DHLWO/4h22hSF/ZxE/R/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(86362001)(31686004)(38100700002)(5660300002)(66574015)(26005)(66476007)(186003)(66556008)(66946007)(83380400001)(53546011)(16526019)(966005)(316002)(31696002)(2906002)(6486002)(54906003)(110136005)(2616005)(956004)(4326008)(36756003)(44832011)(8676002)(7416002)(478600001)(16576012)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDdBaTJUMDYra1JtMVZZWlRMMkhNUER1dElURTZXaHphNDFQRkhEWk5xRVl0?=
 =?utf-8?B?TCsyVmN6TmFNcGhKdUpPd0lZOHNkdmVpck5nKzFEcTlwSGh5UUlNV25vd3FK?=
 =?utf-8?B?RjA1Q0JZRWFiQ3kxdmcyZjBIeDZ3a3Rza0hVMi9ITkF0MGRTVkhWbExOUHlD?=
 =?utf-8?B?bXh3Zk4rVEZVcUc1M3ozcDdXdFVPdzFBc0RkQjRTZkg2dHpvbXlydGUwZnF3?=
 =?utf-8?B?ZzUxb0dpL0ZySHlZSFAxR2Z3d2dNa01uazkvM3hRaVJvOE5YY3ZacitMSGZF?=
 =?utf-8?B?N3BlZkdJNzdXTGJJN3JwSE9WcXJoSzluaG1SN0xxTG1sT0hQVXhTRkJmdXJu?=
 =?utf-8?B?M1c2S1hWK2lpdVA4Qmplb2krV0xRck1hN2pBSFVNUW5tZk1qN2kyUzNNSVRr?=
 =?utf-8?B?QXN5Sm5VeWw1Skk0cHZDeDJ1ZXNocDVrSjQ3bEJZV3dneFExbmdERnB5WWhF?=
 =?utf-8?B?TWVadTEzbWNxenF1TERZSTNSTGQ3Z0p6MEQxWWVOYUxSUHA1Wi9PZ3Azc2FB?=
 =?utf-8?B?WVYxSTNsUE93YUMzZjVLTjdyV2FaSlV2aEhYZ0lJUkZnQ2RDWUt3dmdkYk1h?=
 =?utf-8?B?ZHJxMHl5dHVXQXpUTmV0UHUvdCtEMEFOSlZlallBVDgxSGE4bGRmeEVMWXIx?=
 =?utf-8?B?UWhwRDkzTzdmYVpLaXZGYkduaGZ3YkJtWTJBSEVRV253U3ZHNnlTdzlVdWdh?=
 =?utf-8?B?TzRRYlRkWDF1b0pLRUs2SCswbWVPMTNjbE9LWm13RVBKaDZad2pPQnZUNmVS?=
 =?utf-8?B?SURnQ2grcmdhWlA4OS92QzllOUtsWkhxMnMrZDhSaU9iRGI4NGhkMW1Iakpl?=
 =?utf-8?B?U0MrM1FiaEpQcVZHM2xKTDNiZU1JWXpnZThlWFgzM3RZVEwvckR0ZmNtdWZR?=
 =?utf-8?B?WGRic0pJUVNWbzFZak1yOXJDbGRpUFpWQzNaOFkwdElnLzIxbzgxY3ZLNlF2?=
 =?utf-8?B?MllseW43cGZiaW9HWHNQU0ZTbDMrb3FuR3h3c01rdlBvZmtCK0l3OXZzcytW?=
 =?utf-8?B?QVY2ckZOMDhvMmkvbHR0c3ZoZVhIZm5Tc2xXTGpLWWE5b0gyTHBFRnhFMi9X?=
 =?utf-8?B?d2tRN1UzUGl5SzVFK0xCeWl2b1BLaEZITE96QURTYTllU0wwMGNBLzNSczlJ?=
 =?utf-8?B?NUtCVXBNaEpNRHA2ZUZrREFidkNiY3JwL3pKT3BBVWJTVlRYRnE1c0Nwbmcw?=
 =?utf-8?B?WU9rT1RybUNKYXNFZ2MwbWF5TExOSjkzUUc1aDVYQWtlS2RibGFtWG9raUUy?=
 =?utf-8?B?MzZqamQrNGdQWU5hcE9KQlN1cjVPcW9oL2Iydk1yQmNlREtPTUxUeUsyUXMy?=
 =?utf-8?B?SHMreXFxS1M2d1ZxNWRlaHBSZXUxbGZlcFAwZ1pTc1VUZFlJeXN5RG9aRjFG?=
 =?utf-8?B?RW1pYncwdEx6d0IzTkpGWVM3Sis2U1lGMWJwc1pjcDllYVExRkthTmJLRE9L?=
 =?utf-8?B?Vk04Q0FFdzNPd2dyaVhUalFOaGxIY3ordk1veDNjVTlWNlV5MzNkN0hrRHVI?=
 =?utf-8?B?NXJBb0JEZWZuNmI2TGlrb2lXWjdPQkI1ZlRScVd0T05iSHdUODJEV25nQk41?=
 =?utf-8?B?c2Y0c0ZaR0R2SUgzMjR4NEM4bGtrREEyRDQ4MmdwOGp1eHlEOFBJR2VwWnNl?=
 =?utf-8?B?RGxBY2NZeGp5UEVsYkkvejNFdnBaNjBYWmE1SFd3ajhZa1dEUFRWYThMVnhN?=
 =?utf-8?B?dlIxandqVUxudlVIYTE2SmtzOVFndnp0S3pNajJmekVDRVJRU2U2TDhRcStp?=
 =?utf-8?Q?6HypWNisYqaKRbIbmFRvnhZPW5UUpnX6JPBFaCm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a839a2-3390-4438-3487-08d9359dcdbd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 16:50:12.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CrZOaypcLzqq5pxXAqaagXPuZ3PJDVIJ4amdYnQ2JJgLRLVIwOYysNqVv0I8SteE9sTZinsalu67GoO3KtmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Oded Gabbay <ogabbay@kernel.org>, Doug Ledford <dledford@redhat.com>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0yMiB1bSAxMToyOSBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBB
bSAyMi4wNi4yMSB1bSAxNzoyMyBzY2hyaWViIEphc29uIEd1bnRob3JwZToKPj4gT24gVHVlLCBK
dW4gMjIsIDIwMjEgYXQgMDI6MjM6MDNQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4+IEFtIDIyLjA2LjIxIHVtIDE0OjAxIHNjaHJpZWIgSmFzb24gR3VudGhvcnBlOgo+Pj4+IE9u
IFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDExOjQyOjI3QU0gKzAzMDAsIE9kZWQgR2FiYmF5IHdyb3Rl
Ogo+Pj4+PiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCA5OjM3IEFNIENocmlzdGlhbiBLw7ZuaWcK
Pj4+Pj4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPj4+Pj4+IEFt
IDIyLjA2LjIxIHVtIDAxOjI5IHNjaHJpZWIgSmFzb24gR3VudGhvcnBlOgo+Pj4+Pj4+IE9uIE1v
biwgSnVuIDIxLCAyMDIxIGF0IDEwOjI0OjE2UE0gKzAzMDAsIE9kZWQgR2FiYmF5IHdyb3RlOgo+
Pj4+Pj4+Cj4+Pj4+Pj4+IEFub3RoZXIgdGhpbmcgSSB3YW50IHRvIGVtcGhhc2l6ZSBpcyB0aGF0
IHdlIGFyZSBkb2luZyBwMnAgb25seQo+Pj4+Pj4+PiB0aHJvdWdoIHRoZSBleHBvcnQvaW1wb3J0
IG9mIHRoZSBGRC4gV2UgZG8gKm5vdCogYWxsb3cgdGhlIHVzZXIgdG8KPj4+Pj4+Pj4gbW1hcCB0
aGUgZG1hLWJ1ZiBhcyB3ZSBkbyBub3Qgc3VwcG9ydCBkaXJlY3QgSU8uIFNvIHRoZXJlIGlzIG5v
Cj4+Pj4+Pj4+IGFjY2Vzcwo+Pj4+Pj4+PiB0byB0aGVzZSBwYWdlcyB0aHJvdWdoIHRoZSB1c2Vy
c3BhY2UuCj4+Pj4+Pj4gQXJndWFibHkgbW1hcGluZyB0aGUgbWVtb3J5IGlzIGEgYmV0dGVyIGNo
b2ljZSwgYW5kIGlzIHRoZQo+Pj4+Pj4+IGRpcmVjdGlvbgo+Pj4+Pj4+IHRoYXQgTG9nYW4ncyBz
ZXJpZXMgZ29lcyBpbi4gSGVyZSB0aGUgdXNlIG9mIERNQUJVRiB3YXMKPj4+Pj4+PiBzcGVjaWZp
Y2FsbHkKPj4+Pj4+PiBkZXNpZ25lZCB0byBhbGxvdyBoaXRsZXNzIHJldm9rYXRpb24gb2YgdGhl
IG1lbW9yeSwgd2hpY2ggdGhpcwo+Pj4+Pj4+IGlzbid0Cj4+Pj4+Pj4gZXZlbiB1c2luZy4KPj4+
Pj4+IFRoZSBtYWpvciBwcm9ibGVtIHdpdGggdGhpcyBhcHByb2FjaCBpcyB0aGF0IERNQS1idWYg
aXMgYWxzbyB1c2VkCj4+Pj4+PiBmb3IKPj4+Pj4+IG1lbW9yeSB3aGljaCBpc24ndCBDUFUgYWNj
ZXNzaWJsZS4KPj4+PiBUaGF0IGlzbid0IGFuIGlzc3VlIGhlcmUgYmVjYXVzZSB0aGUgbWVtb3J5
IGlzIG9ubHkgaW50ZW5kZWQgdG8gYmUKPj4+PiB1c2VkIHdpdGggUDJQIHRyYW5zZmVycyBzbyBp
dCBtdXN0IGJlIENQVSBhY2Nlc3NpYmxlLgo+Pj4gTm8sIGVzcGVjaWFsbHkgUDJQIGlzIG9mdGVu
IGRvbmUgb24gbWVtb3J5IHJlc291cmNlcyB3aGljaCBhcmUgbm90IGV2ZW4KPj4+IHJlbW90ZWx5
IENQVSBhY2Nlc3NpYmxlLgo+PiBUaGF0IGlzIGEgc3BlY2lhbCBBTUQgdGhpbmcsIFAyUCBoZXJl
IGlzIFBDSSBQMlAgYW5kIGFsbCBQQ0kgbWVtb3J5IGlzCj4+IENQVSBhY2Nlc3NpYmxlLgo+Cj4g
Tm8gYWJzb2x1dGVseSBub3QuIE5WaWRpYSBHUFVzIHdvcmsgZXhhY3RseSB0aGUgc2FtZSB3YXku
Cj4KPiBBbmQgeW91IGhhdmUgdG9ucyBvZiBzaW1pbGFyIGNhc2VzIGluIGVtYmVkZGVkIGFuZCBT
b0Mgc3lzdGVtcyB3aGVyZQo+IGludGVybWVkaWF0ZSBtZW1vcnkgYmV0d2VlbiBkZXZpY2VzIGlz
bid0IGRpcmVjdGx5IGFkZHJlc3NhYmxlIHdpdGgKPiB0aGUgQ1BVLgo+Cj4+Pj4+Pj4gU28geW91
IGFyZSB0YWtpbmcgdGhlIGhpdCBvZiB2ZXJ5IGxpbWl0ZWQgaGFyZHdhcmUgc3VwcG9ydCBhbmQK
Pj4+Pj4+PiByZWR1Y2VkCj4+Pj4+Pj4gcGVyZm9ybWFuY2UganVzdCB0byBzcXVlZXplIGludG8g
RE1BQlVGLi4KPj4+PiBZb3Ugc3RpbGwgaGF2ZSB0aGUgaXNzdWUgdGhhdCB0aGlzIHBhdGNoIGlz
IGRvaW5nIGFsbCBvZiB0aGlzIFAyUAo+Pj4+IHN0dWZmIHdyb25nIC0gZm9sbG93aW5nIHRoZSBh
bHJlYWR5IE5BSydkIEFNRCBhcHByb2FjaC4KPj4+IFdlbGwgdGhhdCBzdHVmZiB3YXMgTkFLZWQg
YmVjYXVzZSB3ZSBzdGlsbCB1c2Ugc2dfdGFibGVzLCBub3QKPj4+IGJlY2F1c2Ugd2UKPj4+IGRv
bid0IHdhbnQgdG8gYWxsb2NhdGUgc3RydWN0IHBhZ2VzLgo+PiBzZyBsaXN0cyBpbiBnZW5lcmFs
Lgo+PiDCoAo+Pj4gVGhlIHBsYW4gaXMgdG8gcHVzaCB0aGlzIGZvcndhcmQgc2luY2UgREVWSUNF
X1BSSVZBVEUgY2xlYXJseSBjYW4ndAo+Pj4gaGFuZGxlCj4+PiBhbGwgb2Ygb3VyIHVzZSBjYXNl
cyBhbmQgaXMgbm90IHJlYWxseSBhIGdvb2QgZml0IHRvIGJlIGhvbmVzdC4KPj4+Cj4+PiBJT01N
VSBpcyBub3cgd29ya2luZyBhcyB3ZWxsLCBzbyBhcyBmYXIgYXMgSSBjYW4gc2VlIHdlIGFyZSBh
bGwgZ29vZAo+Pj4gaGVyZS4KPj4gSG93PyBJcyB0aGF0IG1vcmUgQU1EIHNwZWNpYWwgc3R1ZmY/
Cj4KPiBObywganVzdCB1c2luZyB0aGUgZG1hX21hcF9yZXNvdXJjZSgpIGludGVyZmFjZS4KPgo+
IFdlIGhhdmUgdGhhdCB3b3JraW5nIG9uIHRvbnMgb2YgSU9NTVUgZW5hYmxlZCBzeXN0ZW1zLgo+
Cj4+IFRoaXMgcGF0Y2ggc2VyaWVzIG5ldmVyIGNhbGxzIHRvIHRoZSBpb21tdSBkcml2ZXIsIEFG
QUlDVC4KPj4KPj4+Pj4gSSdsbCBnbyBhbmQgcmVhZCBMb2dhbidzIHBhdGNoLXNldCB0byBzZWUg
aWYgdGhhdCB3aWxsIHdvcmsgZm9yIHVzIGluCj4+Pj4+IHRoZSBmdXR1cmUuIFBsZWFzZSByZW1l
bWJlciwgYXMgRGFuaWVsIHNhaWQsIHdlIGRvbid0IGhhdmUgc3RydWN0Cj4+Pj4+IHBhZ2UKPj4+
Pj4gYmFja2luZyBvdXIgZGV2aWNlIG1lbW9yeSwgc28gaWYgdGhhdCBpcyBhIHJlcXVpcmVtZW50
IHRvIGNvbm5lY3QgdG8KPj4+Pj4gTG9nYW4ncyB3b3JrLCB0aGVuIEkgZG9uJ3QgdGhpbmsgd2Ug
d2lsbCB3YW50IHRvIGRvIGl0IGF0IHRoaXMgcG9pbnQuCj4+Pj4gSXQgaXMgdHJpdmlhbCB0byBn
ZXQgdGhlIHN0cnVjdCBwYWdlIGZvciBhIFBDSSBCQVIuCj4+PiBZZWFoLCBidXQgaXQgZG9lc24n
dCBtYWtlIG11Y2ggc2Vuc2UuIFdoeSBzaG91bGQgd2UgY3JlYXRlIGEgc3RydWN0Cj4+PiBwYWdl
IGZvcgo+Pj4gc29tZXRoaW5nIHRoYXQgaXNuJ3QgZXZlbiBtZW1vcnkgaW4gYSBsb3Qgb2YgY2Fz
ZXM/Cj4+IEJlY2F1c2UgdGhlIGlvbW11IGFuZCBvdGhlciBwbGFjZXMgbmVlZCB0aGlzIGhhbmRs
ZSB0byBzZXR1cCB0aGVpcgo+PiBzdHVmZi4gTm9ib2R5IGhhcyB5ZXQgYmVlbiBicmF2ZSBlbm91
Z2ggdG8gdHJ5IHRvIGNoYW5nZSB0aG9zZSBmbG93cwo+PiB0byBiZSBhYmxlIHRvIHVzZSBhIHBo
eXNpY2FsIENQVSBhZGRyZXNzLgo+Cj4gV2VsbCB0aGF0IGlzIGNlcnRhaW5seSBub3QgdHJ1ZS4g
SSdtIGp1c3Qgbm90IHN1cmUgaWYgdGhhdCB3b3JrcyB3aXRoCj4gYWxsIElPTU1VIGRyaXZlcnMg
dGhvdWdodC4KPgo+IFdvdWxkIG5lZWQgdG8gcGluZyBGZWxpeCB3aGVuIHRoZSBzdXBwb3J0IGZv
ciB0aGlzIHdhcyBtZXJnZWQuCgpXZSBoYXZlIGJlZW4gd29ya2luZyBvbiBJT01NVSBzdXBwb3J0
IGZvciBhbGwgb3VyIG11bHRpLUdQVSBtZW1vcnkKbWFwcGluZ3MgaW4gS0ZELiBUaGUgUENJZSBQ
MlAgc2lkZSBvZiB0aGlzIGlzIGN1cnJlbnRseSBvbmx5IG1lcmdlZCBvbgpvdXIgaW50ZXJuYWwg
YnJhbmNoLiBCZWZvcmUgd2UgY2FuIGFjdHVhbGx5IHVzZSB0aGlzLCB3ZSBuZWVkCkNPTkZJR19E
TUFCVUZfTU9WRV9OT1RJRlkgZW5hYmxlZCAod2hpY2ggaXMgc3RpbGwgZG9jdW1lbnRlZCBhcwpl
eHBlcmltZW50YWwgYW5kIGRpc2FibGVkIGJ5IGRlZmF1bHQpLiBPdGhlcndpc2Ugd2UnbGwgZW5k
IHVwIHBpbm5pbmcKYWxsIG91ciBWUkFNLgoKSSB0aGluayB3ZSdsbCB0cnkgdG8gcHV0IHRvZ2V0
aGVyIGFuIHVwc3RyZWFtIHBhdGNoIHNlcmllcyBvZiBhbGwgb3VyClBDSWUgUDJQIHN1cHBvcnQg
aW4gYSBmZXcgd2Vla3Mgb3Igc28uIFRoaXMgd2lsbCBpbmNsdWRlIElPTU1VIG1hcHBpbmdzLApj
aGVja2luZyB0aGF0IFBDSWUgUDJQIGlzIGFjdHVhbGx5IHBvc3NpYmxlIGJldHdlZW4gdHdvIGRl
dmljZXMsIGFuZCBLRkQKdG9wb2xvZ3kgdXBkYXRlcyB0byBjb3JyZWN0bHkgcmVwb3J0IHRob3Nl
IGNhcGFiaWxpdGllcyB0byB1c2VyIG1vZGUuCgpJdCB3aWxsIG5vdCB1c2Ugc3RydWN0IHBhZ2Vz
IGZvciBleHBvcnRlZCBWUkFNIGJ1ZmZlcnMuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBSZWdh
cmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+PiBUaGlzIGlzIHdoeSB3ZSBoYXZlIGEgc3BlY2lhbCBz
dHJ1Y3QgcGFnZSB0eXBlIGp1c3QgZm9yIFBDSSBCQVIKPj4gbWVtb3J5Lgo+Pgo+PiBKYXNvbgo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
