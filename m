Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA1DC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD087611B0
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD087611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38AB56EC60;
	Tue, 18 May 2021 18:09:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9576EC5F;
 Tue, 18 May 2021 18:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXw7PnMA6JMjVDYRfuWbAxuCTtu4LsR+ctAwRXaDs2VJ1SNuDN+ZUWnCFjgRJkh2tjhw8EX+P3oClHmcdqoKn+f1y+KruE3RoDyFZwYaRPCUS6Ccp4qSFrnhOfn1QPsRVp4Y6x+lGk9Gl2YP8BpGHrNNhuuHSjuI9a20u0CIzUcEDHLcYu2WhR/V/siCa8AyWxwgJjFNEZe9HbZDKaRqofESxIYy0h3FDM07ZSO83OR8dAqAsjrZEoOtFu0/9MFDu2DI3ZlXL4lVFCtuv2FA0S4x5eGgElW+p/upUmm7RfETLV5UVQqmZqW7q7/7mCpvE/lflFzbfgHBas90CSSnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SeqsOr7rtH/FbOzddENAoy6cN5na1+quK27tr6onq0=;
 b=hajNbxaFejukHDEFNq1H9jRa1OlYnu70LChVc2lvRTIYp8BLgfiMDha4Yiq9MVeu1oYt89UM1TzYE7UJJPMFA5nCcfzeEYQuw3nSaffyhiJVup88dAPwPjpC4wDDmcHyH4/lEtQUKYJggYm8kFLFM3XWj8/8WRuGWeenqUYEZj4US3n9gYfprUHs3z0djZVlnebxC8oo5rQO9HUSwy5NSPXVGH6VDNhFJ0ciJP9cCC2quNMGW3ETlpgcZWusUHgVMaF2Q1aAprxvnUR4fLSVfreUvMXo5HB3JgU7y2b5aqium06H7KxIlJ5Ne7jqZZ5yt2Q/FhgD3Zitu4tcgmzyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SeqsOr7rtH/FbOzddENAoy6cN5na1+quK27tr6onq0=;
 b=ZTbuTdyHuP5a8cp1IPA8bzI0y6TEsBVNc2wJ6dxznno1+xf4gYTEivhjKZIDWLVCO4NunJEAR99DFsWnjwJxpk1jfSVuNVpzqj3z/KMCLJgLE8k1cE9q+Rix7rCrCaGtqL/gPQnhZHWU98PdbX+VDayrXRmdQQTnkrdRMexUNDg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 18:09:53 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 18:09:53 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
 <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
 <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0b49fc7b-ca0b-58c4-3f76-c4a5fab97bdc@amd.com>
Date: Tue, 18 May 2021 14:09:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024]
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024]
 (2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 18 May 2021 18:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da4cd1e-53a9-484e-2621-08d91a28229f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4591C85C49EF966BD8418810EA2C9@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qq3spl8T4lfO9KMYd3w058H8cDea87zHTmUhKY2UzUB9LICwncBPGpQxAYcfiklO+pu6EYBqAebDD1O5URMbftpFD//8kY8v8sVY9BhpQpqr6gv6aMIEs40srR7mjDFqHCY5n+Ysc2pr6iLu0dL8pxnujBBhBKyuPcPXA8N/BzCGioZnsZWQ/aGs2u097W2Djt1H4g40t0jXdJw2qEJJYm72iOR5+k82WY08kEXkMa9wjM+xd0IlEO2Y4kqjgkYdPoNxp671EhIGLNRjEOqTbJtyCe0Xmw+pHDr3Oti3aNzk9rUF51d8bJViGVq6XwyBINnqqn5bhSxFWa8PuGIbBF0rUR2EDONuJCr6HOzI88dDi4LAt/Kg9CT1dbSZK4sht8RJ/wA8yaUrhtu+dCEX+jLQGYA+Xb2qYchoWGLf3ppSmbuRNGkTyRqTF4cWZ1zNHvgUovvzNIz0pRHx7t4AKM+Hl7bRCPcydZbhBu425L85QCbjDeNvnP4gs6sUv/HcYT2FG/wIy5bYfvQppgi1aDQ6Vx1JU63EBgM+fPcoMBD6UyFAjDscwbXormhwykSAZhcocZh9YzH19lExUthMcQRhbzT3qqxrPY12vatqU+2fMwtMz7U4CFFmPbNeGyKCCouj3l3c/nyecTN8hH7GK5HkspidbBQDiJnV7opkEpRNRBh27hzq4E2jjCP/OLOE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66574015)(83380400001)(16526019)(478600001)(53546011)(86362001)(2906002)(5660300002)(66556008)(38100700002)(6486002)(66476007)(36756003)(52116002)(316002)(31696002)(6666004)(8936002)(8676002)(4326008)(6636002)(31686004)(2616005)(66946007)(44832011)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajF5bHpqbjJmQXQxTzJJcnUyVUdRS2xwTk5TWGxzakdGTWlMbEQwVnhjMG8r?=
 =?utf-8?B?TW5VV3FUc0VnWjNDQ2lvZWJyQUtFclE1MnBYTnJEbTIrYTlZMVhrOEhOeVNN?=
 =?utf-8?B?RkdXSldpaVk0cDgyUUJGWTMxNlA5enB0VzZhei81VzJsWWdUNnlCaDdVWnMx?=
 =?utf-8?B?SXRuLzlEbzRuWEcyY1hXMS96cnV4VGs2SFJEaVp2Y3ovdXhoYVo4SHY1Mncx?=
 =?utf-8?B?N0ZTWVE2dlFWeE5hakN1VUtnWW5BbEUrd1pVNSs2dzlOajI2eVRQNS83RXJS?=
 =?utf-8?B?anpzMmtNVmtBcjZrZHliOVk4bHdtVm9rSVo2NkxVMW1KK05YK3NzQjNqUWMw?=
 =?utf-8?B?MzZJY3ZSMlppWldMUkx1ZXlXSUFBdE1zekhpL25WWjU0a01JL1FLKzBiaUpv?=
 =?utf-8?B?ZzJweFViWmpFS3dkZjZvbFc4NndIZUFUU3pmTGI1bVBUb2ptQ0Y5bEx0b3pF?=
 =?utf-8?B?aGlGUVpsUFQyM2FIcUdkcUNGREdCMTZhRE1pMW9YWStVMnBNTXhDbVVjN0p4?=
 =?utf-8?B?NE9JdFNYQXdxVWlGWllJczBQM25YSStxOW15TTBzODkxRS9IN1hnNEQ4SXdj?=
 =?utf-8?B?by9KTy9LaHVsMld6UzRNUnlqYytkeFR3Q21mQk5JcDZKeXJmRG9VWUNieExZ?=
 =?utf-8?B?OEJPWngxaVllUFBtdi8xUU1ST1VrMDdKcWZYalh6cndhc0d4V0FLRzQxMWYx?=
 =?utf-8?B?NGJNM05kZURDUEcwTlNCTElrV1U1SDNZZUU0YWFZT0VRMHh1UngvM2RVc0pj?=
 =?utf-8?B?cjY4S2xuVTVWN0c0Q09VU2Q1RFBweWZaMUM5eGVvd05xREJsVGFaRnQ0cE9n?=
 =?utf-8?B?aE9KWXdhQXB1cjdIL2xBS05QbTl2b1RWamVEc0UzMXBObGh6c1BackJsemRt?=
 =?utf-8?B?MmpXYklhL0pVbUdJMUdra1MxNGg2MWJqa3NjNHZpd2tsd0V4UkpoUzBpMkRv?=
 =?utf-8?B?OWpoblNCL2RDRThuQXFhd3JSbm11UFJERkpCVFNraTdudkpTY0dvVEFadmlW?=
 =?utf-8?B?TENRVmpxYkprVDJKRjRkSDFxa1QvM2kwSTNFK0kxcTNqN3I4a3h6TEY2WEIr?=
 =?utf-8?B?ZjlnNWxDL2RJOUxxWC9zam9XekFjR1hrUEFZd3k0Z1hocHl6Vng0cWpnMkNB?=
 =?utf-8?B?UVAzZFZ0NldmNlhXeU1OM05xZjJ4V3gyY0RUYjNDRUZha045UFFydWg4dTBD?=
 =?utf-8?B?MDBCb0tReWNCeW1UeWNDcWttRi9PVVB2MXU4enBQOEFEL21ZbDk5c1ZnZVZn?=
 =?utf-8?B?dVB1ai8rVlpSaUtlenZqUGt1dmQvdHlZcWxUdEp3a0swK3Zkbjd5WmZnYm5V?=
 =?utf-8?B?MHhiMHFRVFRwZGp3MGVCK1RFUmF2MkFFczNLaitWeWt4SWN3S0h4a1hFVmpB?=
 =?utf-8?B?d0pjRFVPSUZZM2dUWTBCMWFyNXlQa00wS1YzcHVncEVNL1RXNEdnaVFGRkZ3?=
 =?utf-8?B?dVVjd0FsR2p2b2x1cCs5WVpBOHZXNDNHemZDdW9ieisyWmhTaEhyZmZsdzF6?=
 =?utf-8?B?RjZOekFjTjgzRzcxd3FlbVlCN2E2bXd3dXhmQ0dOWFBjRWl6emNPMFZYdHdY?=
 =?utf-8?B?aHdncGYxSE9ZOGM5QlNHM1VzSVdhUHhzY2Jpa2lmRlZJRUk2bXVhSWFzWTdE?=
 =?utf-8?B?WTFOdi9KTTN2TUlsUFNVQnBIMXlPdW91QzdlOElwbDZ1elpzMk5WYUZkZ0pu?=
 =?utf-8?B?QVBBdlJPVXZFc0RidGptd3ZyQVZyQlpaYmloaXlySldjMlJWcmRWM3VyTjBy?=
 =?utf-8?B?cTNEVEE2UWRWNTQ5T2NEeStqRlJ0a1hJcmd4K3g2cG1PV3dxMUY1bzlZZUhj?=
 =?utf-8?B?TlI2TFBodGdSQkFrVnF0WFFnU2lJVUxvMTJnUHdFWk85RVpZOWNEU2tZN1U1?=
 =?utf-8?B?SFkzMXBLUkVqU2MyUG1CSVJXZWNQUnZmME1YTXFINURIeHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da4cd1e-53a9-484e-2621-08d91a28229f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 18:09:53.5273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnEmyTCzc/WLLjhI40/AAuscjXF3ZRPY16P5uCAW4qr4S6SFzWSLwvrNH/bKsKwJbPd2v7alGO5WwElEF3rpYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE4IDI6MDIgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAx
OC4wNS4yMSB1bSAxOTo0MyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+PiBPbiAyMDIxLTA1
LTE4IDEyOjMzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxOC4wNS4yMSB1
bSAxODoxNyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Cj4+Pj4KPj4+PiBPbiAyMDIx
LTA1LTE4IDExOjE1IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+IEFtIDE4LjA1
LjIxIHVtIDE3OjAzIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4+Pgo+Pj4+Pj4gT24g
MjAyMS0wNS0xOCAxMDowNyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4+IElu
IGEgc2VwYXJhdGUgZGlzY3Vzc2lvbiB3aXRoIERhbmllbCB3ZSBvbmNlIG1vcmUgaXRlcmF0ZWQg
b3ZlciAKPj4+Pj4+PiB0aGUgZG1hX3Jlc3YgcmVxdWlyZW1lbnRzIGFuZCBJIGNhbWUgdG8gdGhl
IGNvbmNsdXNpb24gdGhhdCB0aGlzIAo+Pj4+Pj4+IGFwcHJvYWNoIGhlcmUgd29uJ3Qgd29yayBy
ZWxpYWJsZS4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoZSBwcm9ibGVtIGlzIGFzIGZvbGxvd2luZzoKPj4+
Pj4+PiAxLiBkZXZpY2UgQSBzY2hlZHVsZXMgc29tZSByZW5kZXJpbmcgd2l0aCBpbnRvIGEgYnVm
ZmVyIGFuZCAKPj4+Pj4+PiBleHBvcnRzIGl0IGFzIERNQS1idWYuCj4+Pj4+Pj4gMi4gZGV2aWNl
IEIgaW1wb3J0cyB0aGUgRE1BLWJ1ZiBhbmQgd2FudHMgdG8gY29uc3VtZSB0aGUgCj4+Pj4+Pj4g
cmVuZGVyaW5nLCBmb3IgdGhlIHRoZSBmZW5jZSBvZiBkZXZpY2UgQSBpcyByZXBsYWNlZCB3aXRo
IGEgbmV3IAo+Pj4+Pj4+IG9wZXJhdGlvbi4KPj4+Pj4+PiAzLiBkZXZpY2UgQiBpcyBob3QgcGx1
Z2dlZCBhbmQgdGhlIG5ldyBvcGVyYXRpb24gY2FuY2VsZWQvbmV3ZXIgCj4+Pj4+Pj4gc2NoZWR1
bGVkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhlIHByb2JsZW0gaXMgbm93IHRoYXQgd2UgY2FuJ3QgZG8g
dGhpcyBzaW5jZSB0aGUgb3BlcmF0aW9uIG9mIAo+Pj4+Pj4+IGRldmljZSBBIGlzIHN0aWxsIHJ1
bm5pbmcgYW5kIGJ5IHNpZ25hbGluZyBvdXIgZmVuY2VzIHdlIHJ1biBpbnRvIAo+Pj4+Pj4+IHRo
ZSBwcm9ibGVtIG9mIHBvdGVudGlhbCBtZW1vcnkgY29ycnVwdGlvbi4KPj4+Pgo+Pj4+IEJ5IHNp
Z25hbGluZyBzX2ZlbmNlLT5maW5pc2hlZCBvZiB0aGUgY2FuY2VsZWQgb3BlcmF0aW9uIGZyb20g
dGhlCj4+Pj4gcmVtb3ZlZCBkZXZpY2UgQiB3ZSBpbiBmYWN0IGNhdXNlIG1lbW9yeSBjb3JydXB0
aW9uIGZvciB0aGUgdW5jb21wbGV0ZWQKPj4+PiBqb2Igc3RpbGwgcnVubmluZyBvbiBkZXZpY2Ug
QSA/IEJlY2F1c2UgdGhlcmUgaXMgc29tZW9uZSB3YWl0aW5nIHRvCj4+Pj4gcmVhZCB3cml0ZSBm
cm9tIHRoZSBpbXBvcnRlZCBidWZmZXIgb24gZGV2aWNlIEIgYW5kIGhlIG9ubHkgd2FpdHMgZm9y
Cj4+Pj4gdGhlIHNfZmVuY2UtPmZpbmlzaGVkIG9mIGRldmljZSBCIHdlIHNpZ25hbGVkCj4+Pj4g
aW4gZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMgPwo+Pj4KPj4+IEV4YWN0bHkgdGhhdCwgeWVz
Lgo+Pj4KPj4+IEluIG90aGVyIHdvcmRzIHdoZW4geW91IGhhdmUgYSBkZXBlbmRlbmN5IGNoYWlu
IGxpa2UgQS0+Qi0+QyB0aGVuIAo+Pj4gbWVtb3J5IG1hbmFnZW1lbnQgb25seSB3YWl0cyBmb3Ig
QyBiZWZvcmUgZnJlZWluZyB1cCB0aGUgbWVtb3J5IGZvciAKPj4+IGV4YW1wbGUuCj4+Pgo+Pj4g
V2hlbiBDIG5vdyBzaWduYWxlZCBiZWNhdXNlIHRoZSBkZXZpY2UgaXMgaG90LXBsdWdnZWQgYmVm
b3JlIEEgb3IgQiAKPj4+IGFyZSBmaW5pc2hlZCB0aGV5IGFyZSBlc3NlbnRpYWxseSBhY2Nlc3Np
bmcgZnJlZWQgdXAgbWVtb3J5Lgo+Pgo+PiBCdXQgZGlkbid0IEMgaW1wb3J0ZWQgdGhlIEJPIGZv
cm0gQiBvciBBIGluIHRoaXMgY2FzZSA/IFdoeSB3b3VsZCBoZSBiZQo+PiB0aGUgb25lIHJlbGVh
c2luZyB0aGF0IG1lbW9yeSA/IEhlIHdvdWxkIGJlIGp1c3QgZHJvcHBpbmcgaGlzIHJlZmVyZW5j
ZQo+PiB0byB0aGUgQk8sIG5vID8KPiAKPiBXZWxsIGZyZWVpbmcgdGhlIG1lbW9yeSB3YXMganVz
dCBhbiBleGFtcGxlLiBUaGUgQk8gY291bGQgYWxzbyBtb3ZlIGJhY2sgCj4gdG8gVlJBTSBiZWNh
dXNlIG9mIHRoZSBkcm9wcGVkIHJlZmVyZW5jZS4KPiAKPj4gQWxzbyBpbiB0aGUgZ2VuZXJhbCBj
YXNlLAo+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmktPmRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2Jz
IHdoaWNoIGlzCj4+IHRoZSBvbmUgd2hvIHNpZ25hbHMgdGhlICdDJyBmZW5jZSB3aXRoIGVycm9y
IGNvZGUgYXJlIGFzIGZhcgo+PiBhcyBJIGxvb2tlZCBjYWxsZWQgZnJvbSB3aGVuIHRoZSB1c2Vy
IG9mIHRoYXQgQk8gaXMgc3RvcHBpbmcKPj4gdGhlIHVzYWdlIGFueXdheSAoZS5nLiBkcm1fZHJp
dmVyLnBvc3RjbG9zZSBjYWxsYmFjayBmb3Igd2hlbiB1c2UKPj4gcHJvY2VzcyBjbG9zZXMgaGlz
IGRldmljZSBmaWxlKSB3aG8gd291bGQgdGhlbiBhY2Nlc3MgYW5kIGNvcnJ1cHQKPj4gdGhlIGV4
cG9ydGVkIG1lbW9yeSBvbiBkZXZpY2UgQSB3aGVyZSB0aGUgam9iIGhhc24ndCBjb21wbGV0ZWQg
eWV0ID8KPiAKPiBLZXkgcG9pbnQgaXMgdGhhdCBtZW1vcnkgbWFuYWdlbWVudCBvbmx5IHdhaXRz
IGZvciB0aGUgbGFzdCBhZGRlZCBmZW5jZSwgCj4gdGhhdCBpcyB0aGUgZGVzaWduIG9mIHRoZSBk
bWFfcmVzdiBvYmplY3QuIEhvdyB0aGF0IGhhcHBlbnMgaXMgaXJyZWxldmFudC4KPiAKPiBCZWNh
dXNlIG9mIHRoaXMgd2UgYXQgbGVhc3QgbmVlZCB0byB3YWl0IGZvciBhbGwgZGVwZW5kZW5jaWVz
IG9mIHRoZSBqb2IgCj4gYmVmb3JlIHNpZ25hbGluZyB0aGUgZmVuY2UsIGV2ZW4gaWYgd2UgY2Fu
Y2VsIHRoZSBqb2IgZm9yIHNvbWUgcmVhc29uLgo+IAo+IENocmlzdGlhbi4KCldvdWxkIHRoaXMg
YmUgdGhlIHJpZ2h0IHdheSB0byBkbyBpdCA/CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyAKYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jCmluZGV4IDJlOTNlODgxYjY1Zi4uMTBmNzg0ODc0YjYzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKQEAgLTIyMywxMCArMjIzLDE0IEBAIHN0
YXRpYyB2b2lkIGRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzKHN0cnVjdCAKZHJtX3NjaGVkX2Vu
dGl0eSAqZW50aXR5KQogIHsKICAgICAgICAgc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYjsKICAg
ICAgICAgaW50IHI7CisgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqZjsKCiAgICAgICAgIHdoaWxl
ICgoam9iID0gCnRvX2RybV9zY2hlZF9qb2Ioc3BzY19xdWV1ZV9wb3AoJmVudGl0eS0+am9iX3F1
ZXVlKSkpKSB7CiAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9zY2hlZF9mZW5jZSAqc19mZW5j
ZSA9IGpvYi0+c19mZW5jZTsKCisgICAgICAgICAgICAgICB3aGlsZSAoZiA9IHNjaGVkLT5vcHMt
PmRlcGVuZGVuY3koc2NoZWRfam9iLCBlbnRpdHkpKQorICAgICAgICAgICAgICAgICAgICAgICBk
bWFfZmVuY2Vfd2FpdChmKTsKKwogICAgICAgICAgICAgICAgIGRybV9zY2hlZF9mZW5jZV9zY2hl
ZHVsZWQoc19mZW5jZSk7CiAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3NldF9lcnJvcigmc19m
ZW5jZS0+ZmluaXNoZWQsIC1FU1JDSCk7CgpBbmRyZXkKCgoKPiAKPj4KPj4gQW5kcmV5Cj4+Cj4+
Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pgo+Pj4+IEFuZHJleQo+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4K
Pj4+Pj4+IEkgYW0gbm90IHN1cmUgdGhpcyBwcm9ibGVtIHlvdSBkZXNjcmliZSBhYm92ZSBpcyBy
ZWxhdGVkIHRvIHRoaXMgCj4+Pj4+PiBwYXRjaC4KPj4+Pj4KPj4+Pj4gV2VsbCBpdCBpcyBraW5k
IG9mIHJlbGF0ZWQuCj4+Pj4+Cj4+Pj4+PiBIZXJlIHdlIHB1cmVseSBleHBhbmQgdGhlIGNyaXRl
cmlhIGZvciB3aGVuIHNjaGVkX2VudGl0eSBpcwo+Pj4+Pj4gY29uc2lkZXJlZCBpZGxlIGluIG9y
ZGVyIHRvIHByZXZlbnQgYSBoYW5nIG9uIGRldmljZSByZW1vdmUuCj4+Pj4+Cj4+Pj4+IEFuZCBl
eGFjdGx5IHRoYXQgaXMgcHJvYmxlbWF0aWMuIFNlZSB0aGUgam9icyBvbiB0aGUgZW50aXR5IG5l
ZWQgdG8gCj4+Pj4+IGNsZWFubHkgd2FpdCBmb3IgdGhlaXIgZGVwZW5kZW5jaWVzIGJlZm9yZSB0
aGV5IGNhbiBiZSBjb21wbGV0ZWQuCj4+Pj4+Cj4+Pj4+IGRybV9zY2hlZF9lbnRpdHlfa2lsbF9q
b2JzKCkgaXMgYWxzbyBub3QgaGFuZGxpbmcgdGhhdCBjb3JyZWN0bHkgYXQgCj4+Pj4+IHRoZSBt
b21lbnQsIHdlIG9ubHkgd2FpdCBmb3IgdGhlIGxhc3Qgc2NoZWR1bGVkIGZlbmNlIGJ1dCBub3Qg
Zm9yIAo+Pj4+PiB0aGUgZGVwZW5kZW5jaWVzIG9mIHRoZSBqb2IuCj4+Pj4+Cj4+Pj4+PiBXZXJl
IHlvdSBhZGRyZXNzaW5nIHRoZSBwYXRjaCBmcm9tIHllc3RlcmRheSBpbiB3aGljaCB5b3UgY29t
bWVudGVkCj4+Pj4+PiB0aGF0IHlvdSBmb3VuZCBhIHByb2JsZW0gd2l0aCBob3cgd2UgZmluaXNo
IGZlbmNlcyA/IEl0IHdhcwo+Pj4+Pj4gJ1tQQVRDSCB2NyAxMi8xNl0gZHJtL2FtZGdwdTogRml4
IGhhbmcgb24gZGV2aWNlIHJlbW92YWwuJwo+Pj4+Pj4KPj4+Pj4+IEFsc28sIGluIHRoZSBwYXRj
aCBzZXJpZXMgYXMgaXQgaXMgbm93IHdlIG9ubHkgc2lnbmFsIEhXIGZlbmNlcyAKPj4+Pj4+IGZv
ciB0aGUKPj4+Pj4+IGV4dHJhY3RlZCBkZXZpY2UgQiwgd2UgYXJlIG5vdCB0b3VjaGluZyBhbnkg
b3RoZXIgZmVuY2VzLiBJbiBmYWN0IAo+Pj4+Pj4gYXMgeW91Cj4+Pj4+PiBtYXkgcmVtZW1iZXIs
IEkgZHJvcHBlZCBhbGwgbmV3IGxvZ2ljIHRvIGZvcmNpbmcgZmVuY2UgY29tcGxldGlvbiBpbgo+
Pj4+Pj4gdGhpcyBwYXRjaCBzZXJpZXMgYW5kIG9ubHkgY2FsbCBhbWRncHVfZmVuY2VfZHJpdmVy
X2ZvcmNlX2NvbXBsZXRpb24KPj4+Pj4+IGZvciB0aGUgSFcgZmVuY2VzIG9mIHRoZSBleHRyYWN0
ZWQgZGV2aWNlIGFzIGl0J3MgZG9uZSB0b2RheSBhbnl3YXkuCj4+Pj4+Cj4+Pj4+IFNpZ25hbGlu
ZyBoYXJkd2FyZSBmZW5jZXMgaXMgdW5wcm9ibGVtYXRpYyBzaW5jZSB0aGV5IGFyZSBlbWl0dGVk
IAo+Pj4+PiB3aGVuIHRoZSBzb2Z0d2FyZSBzY2hlZHVsaW5nIGlzIGFscmVhZHkgY29tcGxldGVk
Lgo+Pj4+Pgo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gQW5kcmV5Cj4+Pj4+
Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gTm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGF0IGNhc2UuIE9uZSBw
b3NzaWJpbGl0eSB3b3VsZCBiZSB0byAKPj4+Pj4+PiB3YWl0IGZvciBhbGwgZGVwZW5kZW5jaWVz
IG9mIHVuc2NoZWR1bGVkIGpvYnMgYmVmb3JlIHNpZ25hbGluZyAKPj4+Pj4+PiB0aGVpciBmZW5j
ZXMgYXMgY2FuY2VsZWQuCj4+Pj4+Pj4KPj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4KPj4+Pj4+
PiBBbSAxMi4wNS4yMSB1bSAxNjoyNiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4+
PiBQcm9ibGVtOiBJZiBzY2hlZHVsZXIgaXMgYWxyZWFkeSBzdG9wcGVkIGJ5IHRoZSB0aW1lIHNj
aGVkX2VudGl0eQo+Pj4+Pj4+PiBpcyByZWxlYXNlZCBhbmQgZW50aXR5J3Mgam9iX3F1ZXVlIG5v
dCBlbXB0eSBJIGVuY291bnRyZWQKPj4+Pj4+Pj4gYSBoYW5nIGluIGRybV9zY2hlZF9lbnRpdHlf
Zmx1c2guIFRoaXMgaXMgYmVjYXVzZSAKPj4+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9pc19pZGxl
Cj4+Pj4+Pj4+IG5ldmVyIGJlY29tZXMgZmFsc2UuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEZpeDogSW4g
ZHJtX3NjaGVkX2ZpbmkgZGV0YWNoIGFsbCBzY2hlZF9lbnRpdGllcyBmcm9tIHRoZQo+Pj4+Pj4+
PiBzY2hlZHVsZXIncyBydW4gcXVldWVzLiBUaGlzIHdpbGwgc2F0aXNmeSBkcm1fc2NoZWRfZW50
aXR5X2lzX2lkbGUuCj4+Pj4+Pj4+IEFsc28gd2FrZXVwIGFsbCB0aG9zZSBwcm9jZXNzZXMgc3R1
Y2sgaW4gc2NoZWRfZW50aXR5IGZsdXNoaW5nCj4+Pj4+Pj4+IGFzIHRoZSBzY2hlZHVsZXIgbWFp
biB0aHJlYWQgd2hpY2ggd2FrZXMgdGhlbSB1cCBpcyBzdG9wcGVkIGJ5IG5vdy4KPj4+Pj4+Pj4K
Pj4+Pj4+Pj4gdjI6Cj4+Pj4+Pj4+IFJldmVyc2Ugb3JkZXIgb2YgZHJtX3NjaGVkX3JxX3JlbW92
ZV9lbnRpdHkgYW5kIG1hcmtpbmcKPj4+Pj4+Pj4gc19lbnRpdHkgYXMgc3RvcHBlZCB0byBwcmV2
ZW50IHJlaW5zZXJpb24gYmFjayB0byBycSBkdWUKPj4+Pj4+Pj4gdG8gcmFjZS4KPj4+Pj4+Pj4K
Pj4+Pj4+Pj4gdjM6Cj4+Pj4+Pj4+IERyb3AgZHJtX3NjaGVkX3JxX3JlbW92ZV9lbnRpdHksIG9u
bHkgbW9kaWZ5IGVudGl0eS0+c3RvcHBlZAo+Pj4+Pj4+PiBhbmQgY2hlY2sgZm9yIGl0IGluIGRy
bV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KPj4+Pj4+Pj4gUmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+
Pj4+Pj4gLS0tCj4+Pj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50
aXR5LmMgfMKgIDMgKystCj4+Pj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfbWFpbi5jwqDCoCB8IDI0IAo+Pj4+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysKPj4+
Pj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX2VudGl0eS5jIAo+Pj4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfZW50aXR5LmMKPj4+Pj4+Pj4gaW5kZXggMDI0OWM3NDUwMTg4Li4yZTkzZTg4MWI2NWYgMTAw
NjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMKPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHku
Ywo+Pj4+Pj4+PiBAQCAtMTE2LDcgKzExNiw4IEBAIHN0YXRpYyBib29sIGRybV9zY2hlZF9lbnRp
dHlfaXNfaWRsZShzdHJ1Y3QgCj4+Pj4+Pj4+IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4+
Pj4+Pj4gwqDCoMKgwqDCoCBybWIoKTsgLyogZm9yIGxpc3RfZW1wdHkgdG8gd29yayB3aXRob3V0
IGxvY2sgKi8KPj4+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAobGlzdF9lbXB0eSgmZW50aXR5LT5saXN0
KSB8fAo+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5q
b2JfcXVldWUpID09IDApCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcHNjX3F1ZXVlX2NvdW50
KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCB8fAo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZW50
aXR5LT5zdG9wcGVkKQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+
Pj4+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgCj4+Pj4+Pj4+IGIvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4+Pj4gaW5kZXggOGQxMjExZTg3MTAx
Li5hMmE5NTM2OTNiNDUgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+IEBAIC04OTgsOSArODk4LDMzIEBAIEVYUE9SVF9TWU1C
T0woZHJtX3NjaGVkX2luaXQpOwo+Pj4+Pj4+PiDCoMKgICovCj4+Pj4+Pj4+IMKgIHZvaWQgZHJt
X3NjaGVkX2Zpbmkoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPj4+Pj4+Pj4gwqAg
ewo+Pj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICpzX2VudGl0eTsKPj4+
Pj4+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiDCoMKgwqDCoMKgIGlmIChz
Y2hlZC0+dGhyZWFkKQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAga3RocmVhZF9zdG9wKHNj
aGVkLT50aHJlYWQpOwo+Pj4+Pj4+PiArwqDCoMKgIGZvciAoaSA9IERSTV9TQ0hFRF9QUklPUklU
WV9DT1VOVCAtIDE7IGkgPj0gCj4+Pj4+Pj4+IERSTV9TQ0hFRF9QUklPUklUWV9NSU47IGktLSkg
ewo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9ycSAqcnEgPSAmc2No
ZWQtPnNjaGVkX3JxW2ldOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
IXJxKQo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+Pj4+Pj4g
Kwo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZycS0+bG9jayk7Cj4+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHNfZW50aXR5LCAmcnEtPmVudGl0
aWVzLCBsaXN0KQo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogUHJldmVudHMgcmVpbnNlcnRpb24gYW5kIG1hcmtz
IGpvYl9xdWV1ZSBhcyBpZGxlLAo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
aXQgd2lsbCByZW1vdmVkIGZyb20gcnEgaW4gZHJtX3NjaGVkX2VudGl0eV9maW5pCj4+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBldmVudHVhbGx5Cj4+Pj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc19l
bnRpdHktPnN0b3BwZWQgPSB0cnVlOwo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxv
Y2soJnJxLT5sb2NrKTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+Pj4gKwo+
Pj4+Pj4+PiArwqDCoMKgIC8qIFdha2V1cCBldmVyeW9uZSBzdHVjayBpbiBkcm1fc2NoZWRfZW50
aXR5X2ZsdXNoIGZvciB0aGlzIAo+Pj4+Pj4+PiBzY2hlZHVsZXIgKi8KPj4+Pj4+Pj4gK8KgwqDC
oCB3YWtlX3VwX2FsbCgmc2NoZWQtPmpvYl9zY2hlZHVsZWQpOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4+
IMKgwqDCoMKgwqAgLyogQ29uZmlybSBubyB3b3JrIGxlZnQgYmVoaW5kIGFjY2Vzc2luZyBkZXZp
Y2Ugc3RydWN0dXJlcyAqLwo+Pj4+Pj4+PiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnNjaGVk
LT53b3JrX3Rkcik7Cj4+Pj4+Pj4KPj4+Pj4KPj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
