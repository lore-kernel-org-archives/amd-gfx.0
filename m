Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F9EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF70D22C9C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF70D22C9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD776E2C7;
	Mon, 18 Jan 2021 14:53:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD296E2C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 14:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogLA3pwOd4P7NGklI267XTaLjeP7DfHEwIf4BxtKRfC40oXv1m3zoeJUVgpRGgVc8i5jTXvOL/FMZHcng0alLPf8pUWmORvS2hGdbZGfeBcVILy8nBP0b8Q69iRNT4+eUrxSanToOS4TOWSYkx58II676C8JSY4nnKwrP7Jjg5eOHl/e7+YoOCdQ/8moXu6MMZVE/vLNroiKlO66gVmWcT3RO+zI/SWvbf6sPHJMxkCSl3H8G5mkDNIVmBs5yR26yexZSBL7ucZ1gI6XtrfzD3Ml2Z9NELIiniN2IherU60HAUXVEEJ8d+o45FXFJZ/PRi9ytR9TpChU7QX1UNhgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCfMcOXYzqQftZ+B1I+6tb+MLCGe+YmQCMatSFNFK+U=;
 b=C5zaSvCLYYiBx1VQskC15Iwrk6/LBP/xPuXMP59uXhNin19pNywwFy8zyT6TVcWQA103D1u5anF/kjdAms2egebS72MgKCQGWWArBdV7JCR0Ot5DgQTECL+9MrY861TYZhhBfzCBVy8hbkvf6F513LsdAUmqMtPctI9aTNqxkzEjbtLr6dJpg7RREpuSkcPBX5qlUal4XUY009bC7VUFS+1jtpyHnqfqvwTCHdNjEnoUKDfpdcRc/FrvpZ/RugTl2YFoctD50jYFK0LEVOPHSmbCO/YLJq5SsJs6QhXYd0Rl+y1ZzMzL5Js9vk/diSW6kRAIB5hfB1AGOcoG9BcStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCfMcOXYzqQftZ+B1I+6tb+MLCGe+YmQCMatSFNFK+U=;
 b=zgADdaRTc255aEHjggnLv8fxk0Tx0RYFkDm+LD/wDblfsu7mcdg1BWuQsYZSKLbtesevj834/Tmx8i7kaWwMHfoPQY6yLOs+aypcCDCjS4quYGzMIjQw2zchcWp7Hqj67emUoR/kj70xYi2H5Fvzv0no4UxICIyQt9SQaUbx0gY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Mon, 18 Jan
 2021 14:53:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 14:53:20 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210115182423.32368-1-Felix.Kuehling@amd.com>
 <a4af46c0-f33e-d93a-4eae-bee52892e8bf@gmail.com>
 <b94a787c-f7f2-1141-c7df-c0950f8d1904@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <30326fb3-a772-e297-af3f-bfb970bcf275@amd.com>
Date: Mon, 18 Jan 2021 15:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b94a787c-f7f2-1141-c7df-c0950f8d1904@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0701CA0019.eurprd07.prod.outlook.com
 (2603:10a6:200:42::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0701CA0019.eurprd07.prod.outlook.com (2603:10a6:200:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.4 via Frontend
 Transport; Mon, 18 Jan 2021 14:53:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c94d377-5a3c-4bc8-af78-08d8bbc0cbd8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45366BA176740281E378700283A40@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDXyQWEQtatAvs2Hgke81lcK+X595B5LWHFEHr7L85N1vt2cp/OnyLbOsGN5GWHK/wZf7jhAYlkWn9V85xOgBYeu4q19wPKn3xVQu7wkNVPeGBxYi0U3ccuCgeyOE7NE89aX+ShihycneDXy7X3rWKpaWT8V4l7rx26vgXvZ223Cowq5ZSn19sf+uRseO1avzIH0IyqIW8ug2RNYtjUEZQEz/WM0xdyERosrHhd8mGIJDCQQGYapqG7vcvufRUktpyoaAWwc0C2pMPwXgYptQGGHyyee/lUQ1o46D+RQkwASSRnHChfipIfGKODRwWOxNOHglYmyP/HFkmfTpzWVFaR+dr5DCQTx57MkEi57gPwodZBGb5O7R38nNb0+9ImOSYwpaL0l8h+gq0DvJrPH4jPS7TgR0oOhcubC07LQTB2MatBLxXzR6PITcVukEHgpjDVdRMOhCA1ik8r9beJEwsurDCj+cmyk7TgvwiEq/NU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(66556008)(31696002)(36756003)(186003)(6666004)(16526019)(31686004)(66476007)(2616005)(66946007)(52116002)(6486002)(316002)(8676002)(86362001)(8936002)(2906002)(478600001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTRDZG93dXpza2VJSzFJY3dDd21EUURUbkJ3SHRzdDdnUGs1Ym1pelhSMnBN?=
 =?utf-8?B?bnJnWHpFbEo2TWpnVThvNmIrTlR5S01lbzhsYjhRVjkrcGpMMlNaeGsrTHFJ?=
 =?utf-8?B?OUhQOVJSOE5zakJPQzZGZHY2OG0yT3MzRTJSZEZTdm1idzVrNlVEZTZyNVZV?=
 =?utf-8?B?WE5pb1NMN1JQQm41OXEzY1FEU3IxR2J2MTdueU9VazJ2MDlvYUtHWVppVmZ6?=
 =?utf-8?B?UUxVdnd0K0R5cFU2cFU4cUxiRDhtWmRPazlObVU1ams1c0RQNjRxOWNrK0ww?=
 =?utf-8?B?a2lKZXkrbjRmZ0dxczFqck91aHJXSHZkZXczS2tIaGxUeUp0WGsrYUUveVoy?=
 =?utf-8?B?OVcwNDBUaFhvbjZUUzBRQTlZa3NUTFk4ZWY2cDFjRkhQN2dncFBXeHdERkZF?=
 =?utf-8?B?YXp3OXR2a1cvclhBOGJxR2hwMVZlenlURkVsK1A5VzJPcTJCTnNUVC9vUENU?=
 =?utf-8?B?WGJhUm80VFNOYUo0UU55Rkk1QlNSbVdkQnJUdUpieEN6akVuZkFYQnAweWpx?=
 =?utf-8?B?c3FRc1dUUGlqRStNalJWY2VXenA2aVdrQjJNejE5b0pXdDZiZ29WdE1Kd3E3?=
 =?utf-8?B?MGtvVHM2Rm5iQWJRYURCUW00RGY0QXJldDVTL1RYbENZOFFZa01EMmdPbHNo?=
 =?utf-8?B?anNxTmFXNWJyaUZrV2J6SUMxcExGL3ZOMkFGZjUvN2Jick9EL2krQ3JmNXZQ?=
 =?utf-8?B?RmJudUMveDlyT3FSZlc4VTRFUS9QcE5VVXF0SjhHUFEzSWJIRDdoZkx1KzFl?=
 =?utf-8?B?OEJDR3Q5UHdtd1NQQmcraDk2NzgxSk5ZNkR6elVFVXpGOE5TbFNRWURaNklR?=
 =?utf-8?B?R1NtSmxYTklxeEg4QnR1N0dxQkpaemRDN3A1NWlUc0lnakQzYmFaNDJRbE1D?=
 =?utf-8?B?ZlhDWkQ5Y1dmTEFVZ08zM3NPendWVDlMTFVwOHl2Nks3cS9Pd3NjeitlRHc1?=
 =?utf-8?B?RnpROWsweE50cHVhcC9KQk1sbUlCdk1jOEFyeTBOL09rZm94cVJDekpLTEln?=
 =?utf-8?B?U0dxY0NveDYzUTVzQ1dZaEJIOU15c1Vuc0drc3FtVzdWaE5pcjdBV3IwbFVz?=
 =?utf-8?B?TEdyN2dXZzFEZDkrMnVGaGZYSHNOejRZd2FsMUIvTHBDQUsrelVwc2Q3ZlEy?=
 =?utf-8?B?WFJiYXFSVEdJRkZ3Vm00S2UvcXdiNkhIQVlITG5zQ1pjLytOWklLZ25tS0c5?=
 =?utf-8?B?Vzl5anVLTEhmbWFvaG9yOC8vYVV5SkI2Z29hU1ZtUU5VL21JNjk4VENubXlr?=
 =?utf-8?B?N0hhYUtPblB0aCtnZ2lZcGc4clJKY1R0cDRtVVpPa3RyQS9GK3p3RUZoMy9x?=
 =?utf-8?B?WmI2dDN4M2VUUkpUMTFkdkRvZTlXTWxkdnZFU0tPTDd3WU1MOHphbzdyYjZm?=
 =?utf-8?B?b2E1enhwTnhUNlhsUTNGbC80Uis1TUV1bUFSRi80amFiRDJUbEU2YUR6MWpG?=
 =?utf-8?B?TUlqdlJxSWdSa0d3QmtrTkJrMkdYaEV6UlZ4bnpiUzRwbkg3NDBnUlYwOHBj?=
 =?utf-8?Q?Z59gZfqrav99plX8AbYjrl6f6fi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c94d377-5a3c-4bc8-af78-08d8bbc0cbd8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 14:53:20.3254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3jADhGjRfnHod29FjD/q3ICoRCAfg6BvyTbl84DGXFclO1ZeWgJXrHwoLnoFFjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDEuMjEgdW0gMTU6Mzcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIxLTAx
LTE4IHVtIDI6NTMgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEFtIDE1LjAxLjIx
IHVtIDE5OjI0IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+PiBST0NtIHVzZXIgbW9kZSBkZXBl
bmRzIG9uIHVzZXJwdHIgc3VwcG9ydC4gV2l0aG91dCBpdCwgS0ZEIGlzIGJhc2ljYWxseQo+Pj4g
dXNlbGVzcy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L0tjb25maWcgfCAxICsKPj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZwo+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4+PiBpbmRleCBlOGZiMTBjNDFm
MTYuLjI4MDBiMmJiMjUyMiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL0tjb25maWcKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcK
Pj4+IEBAIC04LDUgKzgsNiBAQCBjb25maWcgSFNBX0FNRAo+Pj4gIMKgwqDCoMKgwqAgZGVwZW5k
cyBvbiBEUk1fQU1ER1BVICYmIChYODZfNjQgfHwgQVJNNjQgfHwgUFBDNjQpCj4+PiAgwqDCoMKg
wqDCoCBpbXBseSBBTURfSU9NTVVfVjIgaWYgWDg2XzY0Cj4+PiAgwqDCoMKgwqDCoCBzZWxlY3Qg
TU1VX05PVElGSUVSCj4+PiArwqDCoMKgIHNlbGVjdCBEUk1fQU1ER1BVX1VTRVJQVFIKPj4gSSB0
aGluayB3ZSBzaG91bGQgcmF0aGVyIG1ha2UgdGhhdCBhIGRlcGVuZHMgb24uIE90aGVyd2lzZSB3
ZSBzZWxlY3QgYQo+PiB2aXNpYmxlIGNvbmZpZyBvcHRpb24uCj4gSSB3YXMgY29uc2lkZXJpbmcg
dGhhdC4gVGhlIHByb2JsZW0gd2l0aCB0aGF0IGlzLCB0aGF0IHRoZSBIU0FfQU1ECj4gb3B0aW9u
IHdvbid0IGV2ZW4gc2hvdyB1cCBpbiBtZW51Y29uZmlnIHVubGVzcyBEUk1fQU1ER1BVX1VTRVJQ
VFIgaXMKPiBzZWxlY3RlZC4gSSdkIHJhdGhlciBhbHdheXMgc2hvdyB0aGUgSFNBX0FNRCBvcHRp
b24gYW5kIHNlbGVjdCB3aGF0IGl0Cj4gbmVlZHMuCj4KPiBJcyB0aGVyZSBhIGdvb2QgcmVhc29u
IHdoeSBBTURHUFVfVVNFUlBUUiBpcyBhICJ2aXNpYmxlIiBjb25maWcgb3B0aW9uPwo+IFdoYXQg
d291bGQgYmUgYSByZWFzb24gZm9yIGEgdXNlciB0byBkZWxpYmVyYXRlbHkgZGlzYWJsZSB0aGlz
PwoKVGhlIHByb2JsZW0gaXMgdGhlIE1NVSBub3RpZmllciBkZXBlbmRlbmN5LCBub3QgZXZlcnli
b2R5IHdhbnRzIGl0cy4KCkknbSBqdXN0IG5vdCBzdXJlIGlmIGl0J3MgbGVnYWwgdG8gZm9yY2Vm
dWxseSBzZWxlY3QgYSB2aXNpYmxlIGNvbmZpZyAKb3B0aW9uLiBFLmcuIHdoYXQgaGFwcGVucyBp
ZiBhbiB1c2VyIHVuc2VsZWN0cyBEUk1fQU1ER1BVX1VTRVJQVFIgYWZ0ZXIgCml0IHdhcyBzZWxl
Y3RlZCBoZXJlPwoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gIMKgIEZlbGl4
Cj4KPgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiAgwqDCoMKgwqDCoCBoZWxwCj4+PiAgwqDCoMKgwqDC
oMKgwqAgRW5hYmxlIHRoaXMgaWYgeW91IHdhbnQgdG8gdXNlIEhTQSBmZWF0dXJlcyBvbiBBTUQg
R1BVIGRldmljZXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
