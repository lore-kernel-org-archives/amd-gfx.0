Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F02C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F41920643
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vmjMsAH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F41920643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46796E804;
	Mon, 30 Nov 2020 19:31:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2DA6E804
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 19:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzEKzlubSTwulEDMtkxbC5MGcGiV7F22vfktQ5IXrPE/5gkqyGg86BWeNoIp+TIm4WYzvuLmRQAcR1YP55GBaZHXADHnwGlXqzSd+zHxjT5VrdKcu6rd7UQwY34EI2oLwrIZ274VK9l5toXtMygeHtiGNcXELLZBOJABwOCeqTMjsejDBNXjbKEhA8mJO1w3OItK07+7kqlevxB9B1foWWkvdtWribhvBebqWE/C/CiwpTZqT2eeShBjPwO0VPu/il9fykmtygcxUroHxwwzJNT2ffxQ8rgQPfUHUiT1qJ07WzrcMiV1M/JV3LqZ9nHWe/Zu9VKgF6sya5BQYKy6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyNk18Iyb1AgISRaVWVpRuCVrovolFftvpk4ZSk7x50=;
 b=ZCIDCvYPBUyRzQp0LZXRyt64/3/APsCbTQf63TeXJ3CPCK00Qup0tsJnuGuRpV23n80AHKE1OYRE6gN3N4zGyet+zDpPEHf9MW7Hehyzsk+5bkxahLN5oEGVCs81GaM8TRcMezv7ZmcVgVUjpoIcE9o68E2DyN4GmWJxYHS8bU6I+P8GQ9l6tj6bv7/Y5t9/4gbaqD+hxFQ/sLveklCcdaJLWzwcwKwXdURwBhDgq+WdCU3oKLfmRdjcMsg05ztR/yq61EXuiJSASzgqviIdPyIMl5KZ3eCqfzMwJUeB4D9S0cmRVcVdMt8B521kQKLQ7ve12X8ozTn/hOtsQKY88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyNk18Iyb1AgISRaVWVpRuCVrovolFftvpk4ZSk7x50=;
 b=vmjMsAH2plXvxQ7fX2uNR2Yyjuxbe6njbPq/Y3ybbr/gkFs4OhgMz8EoB5ttlM1e4Fb2dr2RWrBgCSh6W+99xL54oZjB6iNIp0pMMqc2DJNtPpIfUO5Hvjfqqd/fN+QGN4fvKqwGoAQNRrvM8jGdCCLFVSlzFbaC7m3fPiK3wao=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 19:31:32 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%8]) with mapi id 15.20.3611.024; Mon, 30 Nov 2020
 19:31:31 +0000
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
From: Felix Kuehling <felix.kuehling@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20201015033557.3046-1-Jack.Gui@amd.com>
 <ccd27274-44e1-3bfc-24a8-e24750889efe@amd.com>
 <CAP+8YyF59Hnq=NgVbfV__GqMZ8y+HyNYRqoPo3hOBDUj1+CtZA@mail.gmail.com>
 <CY4PR12MB1287D8AA91368C4BCA99E47BF1F60@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MN2PR12MB4488508A68085217363A0F64F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
 <c3854154-1889-4ee6-3f30-c63100b0a248@amd.com>
Message-ID: <5834e105-f92c-4d07-5967-143ec428c56a@amd.com>
Date: Mon, 30 Nov 2020 14:31:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c3854154-1889-4ee6-3f30-c63100b0a248@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 19:31:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 892a5f72-4493-4b19-5a6d-08d895668a8a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4899:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4899B0500FE5B461DE07E3C692F50@BL0PR12MB4899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cc/fiesPYsVgXGwCTaQbucAWoEB9YWtNvCxl013+B2XveZNwJBNhPmVXBUKVMkVvTjaJT/301jR6zKga/4Do9JPHQ/4dBa+Df5jl3zK5MugB0LIycQrpk5hmm1+4l27s/ebTODyFcA/NzyiJMnIgE0X2h0AwXcNXFLuRdXPz8vD61iQIgl85YDXiBlWmGTIVpOyh+C0Rdu4LoFmGGd3PWLtjDyw854o+/iKGLddwsy2C5zBO9Orpm6ne+H5wlBmB4U4JahzsBWPYzBeJr0UWkUNoXRkDlfaLugwoXJzXSfSLM5aR5UVP0iEQFOWJLgrSmJQVwg1joSYseNZ8Adz5NozrTqZtKIlPPcQRAoaWqL5smr5NLAnW3hx2LIXjQrAn9dmo9ZAgO4/VuOWL6zE7CjxmifBDXORnVN1fcVrYdznMYnCL/d/frMrY0ogrnGCx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(66556008)(4001150100001)(31686004)(31696002)(16576012)(6486002)(8936002)(86362001)(5660300002)(316002)(110136005)(54906003)(36756003)(4326008)(44832011)(966005)(52116002)(8676002)(66476007)(83380400001)(66946007)(186003)(478600001)(956004)(53546011)(2616005)(2906002)(26005)(16526019)(43740500002)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXNrUWJndTFJR1EwL0MxLzVVdE5SMFdQYk0yVkprRkNycmlPclVWbEtraU5u?=
 =?utf-8?B?THA0V21KOGRRaVNRMlVYVVpMRGxIVmp5MHNCNlQ4aFh1UktRWjRzK01nQU55?=
 =?utf-8?B?bWFwKzF5bnpZQ0YwajQyaHNHMTJYVGdHSnhqWHJzV2hUTE5lbHN1dnRKelRm?=
 =?utf-8?B?WTc4VDcvNjIxdXpKaTlZTWNCZzIyZU1xRDJ2aTNpK0JJZUhPdXZjNEpyZDZ3?=
 =?utf-8?B?Ny9sR0NVVnJqb09aY0JpcVljVDJzWHJaaHZPSHZ5Rld4MVBBWU5NbWVKS2ZK?=
 =?utf-8?B?a2x2NCtQWUhTUlc2K1FIMTAwWlh5UVNyUFlnTmNGRndaVjVvSWtkcTYzbXVt?=
 =?utf-8?B?cGNtSXZGQVdJdVljdklMVHE4RGtwV1VzRjRKUlNQaXpxRnltcU5aMStXdDho?=
 =?utf-8?B?MFIxZUNWRnZzZWRuOGw3eWdGOTQ1bTh6U0JTeDJyY2QvQnkxcGlVNnRGeWZ0?=
 =?utf-8?B?S1FscmZ0eUxEOThabzlsSWdwNU1KRXlVeVc4QU1paFNmVWJGakxsZExCZkdQ?=
 =?utf-8?B?Mlc3Tkl3YjJiclV5U25uQW9yRDkwaUJlVEx3VVhILzdBd2ZPS0M1eGRCaGpI?=
 =?utf-8?B?UDRrZW1pajlSNWtRRXVoNEU1TXRYenBWSk9qOGFqdzQ4dmQ3NXc0enA2dWZt?=
 =?utf-8?B?bDFZN01ZdFpoK3R5NjBUdUx4eXd1NTFRSWdyK05ScFhUa0tpc1NUM0FtbWV5?=
 =?utf-8?B?SlVaWm8vSWJ5OHdxMVhNNStUN0wrc0pUR1Z5TG5raisybVlUby9wV0FKV2ow?=
 =?utf-8?B?cUVVR203b0tqVGI1dGNudWtOc3NMSEZjUDRFa0twL3JWL0pxUnQrQUM0RGhI?=
 =?utf-8?B?cWxoMGV6aUUwelVMY0tuSUk1Y09aN3NYNjg0WXJqSDRGM0xQYlhPa29XaTZ3?=
 =?utf-8?B?K2VvU25sTWM4cW16aDdVZnk1b2dHSzBCbU9mZmxLWjI5UmlPY0UwTzdhQVFy?=
 =?utf-8?B?MVdnOE41UjBhV2ZVYUYralpqdFR2MTd5bW1keEdtSFBpbjYzVElhNW1yM2h4?=
 =?utf-8?B?UVI4RzZnRnRKVnZaT3FzeVd4eGtlL1pRN3BvY2FkdG9mSldLNVBhVzJOa1E1?=
 =?utf-8?B?WjZoeStTQ09IMTJWeVNRMnlpejNWYThsRVp2K3p2dFhOdlNZejJibFJrZU9n?=
 =?utf-8?B?NzRESmlXWVcwd2k3bGpZeEljK01DY3I0WVBTSVg4RERGcVdDcXNFRUlmODRO?=
 =?utf-8?B?bStIMFpYRkc5dFVVL2xka3lHU3htMW55VGtMOFgrWEh1eTNYd1FhRSsxYjFp?=
 =?utf-8?B?cXBtWVJWcENPYTJHZjdGWld0b1dYVXdheVlwWnRnTVJFMElBMHh6K0JnMHFw?=
 =?utf-8?Q?O+SVh/xWRGYgXotYozXlnofb6f6NRwf+VT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892a5f72-4493-4b19-5a6d-08d895668a8a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 19:31:31.7944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSJ+mfn9RPsPCmxDf5Y1nIDWjCNS/KB29nfyOBhaC++pfUaby76sS1gCw0XIqKF9rTfBqUCgkMHe5evUYiY1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Gui,
 Jack" <Jack.Gui@amd.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW5vdGhlciByZWxhdGVkIHRob3VnaHQ6IEkgdGhpbmsgdGhlIHJlYXNvbiBzb21lIGNoaXBzIGhh
ZCBmYWlsaW5nIFZNCmZhdWx0IHRlc3RzIHdpdGggbm9yZXRyeT0wIHdhcyBkdWUgdG8gYSBkZXBl
bmRlbmN5IG9uIElIIHJlcm91dGluZyBvZgpyZXRyeSBmYXVsdHMuIFRoaXMgZGVwZW5kZW5jeSBo
YXMgYmVlbiBmaXhlZCBieSBDaHJpc3RpYW4gcmVjZW50bHk6Cgpjb21taXQgODQ5YzYyMjQ4ZWU4
NGMxZTMwNGE5Y2UyZjY3M2M3OWUyM2YyOWJmOQpBdXRob3I6IENocmlzdGlhbiBLP25pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpEYXRlOiAgIFNhdCBPY3QgMzEgMTg6Mzk6NTQgMjAyMCAr
MDEwMAoKICAgIGRybS9hbWRncHU6IGVuYWJsZWQgc29mdHdhcmUgSUggcmluZyBmb3IgVmVnYQoK
ICAgIFNlZW1zIGxpa2Ugd2Ugd29uJ3QgZ2V0IHRoZSBoYXJkd2FyZSBJSDEvMiByaW5ncyBvbiBW
ZWdhMjAgd29ya2luZy4KCiAgICBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gSz9uaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KICAgIFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4KCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBf
aWguYyB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKY29tbWl0
IDE5ODIzNzc0NGQ4NWM0YTIzOTE0ZGU1NmQ3OGZiYTBhY2Y1YTI4MDMKQXV0aG9yOiBDaHJpc3Rp
YW4gSz9uaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KRGF0ZTogICBUdWUgTm92IDMgMTQ6
MjI6NTAgMjAyMCArMDEwMAoKICAgIGRybS9hbWRncHU6IGVuYWJsZWQgc29mdHdhcmUgSUggcmlu
ZyBmb3IgTmF2aQoKICAgIEZlbGl4IHBvaW50ZWQgb3V0IHRoYXQgd2UgbmVlZCB0aGlzIGZvciBO
YXZpIGFzIHdlbGwuCgogICAgU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEs/bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+CiAgICBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+CgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2lo
LmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKClNvIGl0IHNo
b3VsZCBub3cgYmUgc2FmZSB0byBlbmFibGUgcmV0cnkgZmF1bHRzIG9uIG1vc3QgY2hpcHMuIE9u
bHkgb24KR0ZYdjkgdGhlcmUgY2FuIGJlIGEgcGVyZm9ybWFuY2UgYWR2YW50YWdlIHRvIGRpc2Fi
bGluZyByZXRyeS4KClJlZ2FyZHMsCsKgIEZlbGl4CgpBbSAyMDIwLTExLTMwIHVtIDEyOjM1IHAu
bS4gc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBMaWtlIEkgc3RhdGVkIGVsc2V3aGVyZSwgSSB3
b3VsZCByZWNvbW1lbmQgbm9yZXRyeT0wIGZvciBOYXZpIGFuZCBsYXRlcgo+IEdQVXMgYmVjYXVz
ZSB0aGVyZSBpcyBubyBwZXJmb3JtYW5jZSBhZHZhbnRhZ2UgZnJvbSBkaXNhYmxpbmcgcmV0cnkg
b24KPiB0aG9zZSBHUFVzLgo+Cj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPgo+IEFtIDIwMjAt
MTEtMzAgdW0gMTI6MjIgcC5tLiBzY2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoKPj4gW0FNRCBQ
dWJsaWMgVXNlXQo+Pgo+Pgo+PiBXZSBuZWVkIHRvIGZpZ3VyZSBvdXQgd2hhdCB0aGUgcm9vdCBj
YXVzZSBpcyB0aGVuLsKgIElmIHdlIGNhbid0IGZpZ3VyZQo+PiBpdCBvdXQgc29vbiwgd2Ugc2hv
dWxkIHJldmVydCB0aGUgY2hhbmdlIGZvciBuYXZpMXggYW5kIGNvbnRpbnVlIHRvCj4+IGRlYnVn
IGl0IHVudGlsIHdlIGNhbiBmaW5kIHRoZSByb290IGNhdXNlIGFuZCB3ZSBjYW4gc2FmZWx5IHJl
LWVuYWJsZSBpdC4KPj4KPj4gQWxleAo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gKkZyb206KiBDaGVu
LCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+Cj4+ICpTZW50OiogU3VuZGF5LCBOb3ZlbWJl
ciAyOSwgMjAyMCAyOjIyIEFNCj4+ICpUbzoqIEJhcyBOaWV1d2VuaHVpemVuIDxiYXNAYmFzbmll
dXdlbmh1aXplbi5ubD47IEt1ZWhsaW5nLCBGZWxpeAo+PiA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4KPj4gKkNjOiogR3VpLCBKYWNrIDxKYWNrLkd1aUBhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFv
Llpob3UxQGFtZC5jb20+Owo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdCA8YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc+OyBIdWFuZywgUmF5Cj4+IDxSYXkuSHVhbmdAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47Cj4+IFpoYW5nLCBIYXdr
aW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4+ICpTdWJqZWN0OiogUkU6IFtQQVRDSCB2M10g
ZHJtL2FtZC9hbWRncHU6IHNldCB0aGUgZGVmYXVsdCB2YWx1ZSBvZgo+PiBub3JldHJ5IHRvIDEg
Zm9yIHNvbWUgZEdQVXMKPj4gwqAKPj4gW0FNRCBQdWJsaWMgVXNlXQo+Pgo+PiBIaSBCYXMgTmll
dXdlbmh1aXplbiwKPj4KPj4gSSBkb24ndCB0aGluayBkaXJlY3QgcmV2ZXJ0IGlzIG9uZSByaWdo
dCBhcHByb2FjaCwgdGhvdWdoIGl0J3MgYWJsZSB0bwo+PiBmaXggeW91ciBwcm9ibGVtLsKgIG5v
cmV0cnk9MCB3aWxsIGNhdXNlIG90aGVyIHRlc3QgZmFpbHVyZSBvbiBzZXZlcmFsCj4+IEFTSUNz
Lgo+Pgo+PiBSZWdhcmRzLAo+PiBHdWNodW4KPj4KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4gT24gQmVoYWxmIE9mIEJhcwo+PiBOaWV1d2VuaHVpemVuCj4+IFNlbnQ6IFN1bmRheSwgTm92
ZW1iZXIgMjksIDIwMjAgODozOCBBTQo+PiBUbzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgo+PiBDYzogR3VpLCBKYWNrIDxKYWNrLkd1aUBhbWQuY29tPjsgQ2hlbiwg
R3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsKPj4gWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFt
ZC5jb20+OyBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47Cj4+IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nCj4+IDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+Cj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGRybS9hbWQvYW1k
Z3B1OiBzZXQgdGhlIGRlZmF1bHQgdmFsdWUgb2YKPj4gbm9yZXRyeSB0byAxIGZvciBzb21lIGRH
UFVzCj4+Cj4+IENhbiB3ZSByZXZlcnQgdGhpcyBwYXRjaCB0byBmaXgKPj4gaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTM3NCA/Cj4+Cj4+IE9uIFRodSwg
T2N0IDE1LCAyMDIwIGF0IDQ6MzAgUE0gRmVsaXggS3VlaGxpbmcKPj4gPGZlbGl4Lmt1ZWhsaW5n
QGFtZC5jb20+IHdyb3RlOgo+Pj4gQW0gMjAyMC0xMC0xNCB1bSAxMTozNSBwLm0uIHNjaHJpZWIg
Q2hlbmdtaW5nIEd1aToKPj4+PiBub3JldHJ5ID0gMCBjYXVzZSBzb21lIGRHUFUncyBrZmQgcGFn
ZSBmYXVsdCB0ZXN0cyBmYWlsLCBzbyBzZXQKPj4+PiBub3JldHJ5IHRvIDEgZm9yIHRoZXNlIHNw
ZWNpYWwgQVNJQ3M6Cj4+Pj4gdmVnYTIwL25hdmkxMC9uYXZpMTQvQVJDVFVSVVMKPj4+Pgo+Pj4+
IHYyOiBtZXJnZSByYXZlbiBhbmQgZGVmYXVsdCBjYXNlIGR1ZSB0byB0aGUgc2FtZSBzZXR0aW5n
Cj4+Pj4gdjM6IHJlbW92ZSBBUkNUVVJVUwo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbmdt
aW5nIEd1aSA8SmFjay5HdWlAYW1kLmNvbT4KPj4+PiBDaGFuZ2UtSWQ6IEkzYmU3MGY0NjNhNDli
MGNkNWM1NjQ1NjQzMWQ2YzJjYjk4YjEzODcyCj4+PiBBY2tlZC1ieTogRmVsaXggS3VobGluZyA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+Cj4+Pgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDIzCj4+Pj4gKysrKysrKysrKysrKysr
LS0tLS0tLS0KPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ21jLmMKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuYwo+Pj4+IGluZGV4IDM2NjA0ZDc1MWQ2Mi4uZjI2ZWI0ZTU0YjEyIDEwMDY0NAo+Pj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+Pj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+Pj4+IEBAIC00MjUsMjAgKzQy
NSwyNyBAQCB2b2lkIGFtZGdwdV9nbWNfbm9yZXRyeV9zZXQoc3RydWN0Cj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4+Pj4gwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZ21jICpnbWMgPSAmYWRl
di0+Z21jOwo+Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKgIHN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7
Cj4+Pj4gLcKgwqDCoMKgIGNhc2UgQ0hJUF9SQVZFTjoKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIFJhdmVuIGN1cnJlbnRseSBoYXMgaXNzdWVzIHdpdGggbm9yZXRyeQo+Pj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJlZ2FyZGxlc3Mgb2Ygd2hhdCB3ZSBkZWNpZGUg
Zm9yIG90aGVyCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYXNpY3MsIHdlIHNo
b3VsZCBsZWF2ZSByYXZlbiB3aXRoCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
bm9yZXRyeSA9IDAgdW50aWwgd2Ugcm9vdCBjYXVzZSB0aGUKPj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBpc3N1ZXMuCj4+Pj4gK8KgwqDCoMKgIGNhc2UgQ0hJUF9WRUdBMjA6Cj4+
Pj4gK8KgwqDCoMKgIGNhc2UgQ0hJUF9OQVZJMTA6Cj4+Pj4gK8KgwqDCoMKgIGNhc2UgQ0hJUF9O
QVZJMTQ6Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIG5vcmV0cnkgPSAwIHdpbGwgY2F1c2Uga2ZkIHBhZ2UgZmF1bHQg
dGVzdHMgZmFpbAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGZvciBzb21lIEFT
SUNzLCBzbyBzZXQgZGVmYXVsdCB0byAxIGZvciB0aGVzZSBBU0lDcy4KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChhbWRncHVfbm9yZXRyeSA9PSAtMSkKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnbWMtPm5vcmV0cnkgPSAwOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdtYy0+bm9yZXRyeSA9IDE7Cj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ21jLT5ub3JldHJ5ID0gYW1kZ3B1X25vcmV0cnk7Cj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+PiArwqDCoMKgwqAgY2FzZSBDSElQ
X1JBVkVOOgo+Pj4+IMKgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogZGVmYXVsdCB0aGlzIHRvIDAgZm9yIG5vdywgYnV0IHdlIG1heSB3YW50Cj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSYXZlbiBjdXJyZW50bHkgaGFzIGlzc3Vl
cyB3aXRoIG5vcmV0cnkKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZWdhcmRs
ZXNzIG9mIHdoYXQgd2UgZGVjaWRlIGZvciBvdGhlcgo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqIGFzaWNzLCB3ZSBzaG91bGQgbGVhdmUgcmF2ZW4gd2l0aAo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIG5vcmV0cnkgPSAwIHVudGlsIHdlIHJvb3QgY2F1c2UgdGhl
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaXNzdWVzLgo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
ZGVmYXVsdCB0aGlzIHRvIDAgZm9yIG5vdywgYnV0IHdlIG1heSB3YW50Cj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdG8gY2hhbmdlIHRoaXMgaW4gdGhlIGZ1dHVyZSBmb3Ig
Y2VydGFpbgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEdQVXMgYXMgaXQg
Y2FuIGluY3JlYXNlIHBlcmZvcm1hbmNlIGluCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogY2VydGFpbiBjYXNlcy4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbGlzdC8gPGh0dHBzOi8vbGlzdD4KPj4+
IHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0
YT0wNCU3QzAxJTdDZ3UKPj4+IGNodW4uY2hlbiU0MGFtZC5jb20lN0M2ZDYyNmUyYTNiYWU0ODc3
MDI0ZjA4ZDg5M2ZmMTVkYiU3QzNkZDg5NjFmZTQ4ODQKPj4+IGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzQyMjA3MTA4NTgwMDQ3NiU3Q1Vua25vd24lN0NUV0ZwYkdac2IKPj4+IDNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCUKPj4+IDdDMTAwMCZhbXA7c2RhdGE9VkZxZWdHd1BDajEwcTNZNUJkWnNWcTJh
JTJCNFRiMzU4bVlWRGFOa0E5ekxVJTNEJmFtcDsKPj4+IHJlc2VydmVkPTAKPj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
