Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA1CC433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 09:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DEA21D43
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 09:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fKpuVKJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DEA21D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1217A6EC84;
	Fri,  9 Oct 2020 09:06:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3513C6EC84
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 09:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewK3TdnS43Ov/Dv07+23DNYhhCG8N90g0MlT/iiIBdOk52ODBgO3KZv0SCnVhrR34PLFtrgX5o/CzfN73WHy6+0xoxhunnA8gr8tRzIbSR4PoMIZ67O68qiLEa/WyAePI5GLXSUhsLttEH83rgAVnNTwhkUrraOHduM0X8wziouE0O8bgtewVSp1U/w0Edh09Arc4bnOmyjgiROB+WUltKB1ZZ7Mea34xlcw+SWqddkG9C92Y41EWyGSdAyhFxUsnAZncdK7hhinp+w4WOvu78H10MV9ctEXUF8cTQv5BYJR89nDUMQ6CN4tCQywJ1i0BeDyKyzJhGaaD2IOMYwAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlKcsNYCvCX5coDMqWzr3BAbjh6m7ce9D9YwM+ZwjFE=;
 b=JNA1SDMTfh5XDLMWHNrmkC4YyhACe8XwlCWAFsZkN/+vXoPMMt04b7p2KHKiVlSDIhB/eSBRp75cM/JIhYbBzntZryl4gRyzKnhI9zoxIEPgbjXA0rfXYuu0d4QuKAYBIGz2gW0FLs5Z7Cbv4lm1l/z0mcT3XJalCbCsYG9jzIq84XOYZLodbwbWhoB6r6Q55ZWS3BO329JPuf4ZlhqO/8t518NPeMngGgg/SM6MSDmCD7WMYXTgoReWrsytwshThgGDZ9OBIGBrsDZw1w6Y4or3EcdFc+WiMWHwz8FtgciIm4189Uz7G/NjBXLLaOB5iamg5V73yJrtq35d9zCT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlKcsNYCvCX5coDMqWzr3BAbjh6m7ce9D9YwM+ZwjFE=;
 b=fKpuVKJYzgqbNN0G/nRDWUWW8Zcbu4F4DJxaixj+owPHtmrr6l55JtsrkZ4Y1iggL/daWexTuGwUT4lszoJ3TjKjqcJTc/HRRL13CHFPnZ0r3UbTGsp2wwKDjT6hT6LhIlw0gaw1QyPwc33u4HqiW1vGj2Xysb800aaPph965Bw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3840.namprd12.prod.outlook.com (2603:10b6:208:16f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 09:06:04 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 09:06:04 +0000
Subject: Re: [PATCH] drm/amdgpu: modify kmalloc to kzalloc in
 amdgpu_ctx_init_entity
To: Changfeng <Changfeng.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201009090423.1068-1-Changfeng.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a03ed45c-16e9-b69d-df0d-979e89036f87@amd.com>
Date: Fri, 9 Oct 2020 11:05:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201009090423.1068-1-Changfeng.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:207:3::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0137.eurprd05.prod.outlook.com (2603:10a6:207:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.24 via Frontend Transport; Fri, 9 Oct 2020 09:06:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ac25e29-a7d4-450b-21b6-08d86c328cb7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3840985FE7C10334E0A7A07E83080@MN2PR12MB3840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFnNsTR6DInsDKpzW1pJk4mFcijRVJsC9lpZE9HjciW64Sf3S1sI7G6Qj4oQleAxewhiXhaGnPBP8uT/TikBa7ilXDWVmOp6qWSHsD1OBktFLJwLNki+PMrRzdvOSrsIEtJIWEWGNfe9m16TP/gN55czKgYzd/YEw2EjW2RZ4B1AtBhs64n/Rsaxl2//mJqUXXDi9uBayiLCiOrRlChb2lfZx/VV/l0cKaBxHulaqr9spKKoIrxeJXQcr8qLZurrYqBmu2OkG2SlmQu8DppDFU0J26Icfs58YOQn+ev/Cq6dH7bsCoQ4scyBABdNwGK0aGl421lG29nsBR3w+87V5RreQMhLjdc4OjvcWnDRdOqSGb+Pze8PNDxVuUHZCAaE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(8936002)(8676002)(31696002)(6666004)(86362001)(83380400001)(31686004)(36756003)(66476007)(16526019)(66946007)(66574015)(66556008)(186003)(2906002)(478600001)(52116002)(2616005)(6486002)(5660300002)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xm6zp6fTHHySxv4jOEQ29+AD+lZUZZQSPUV9oJO8lVDKvpwB79o0ajskKilQV/xOiIsgX85u7UkhfkkhKtfB6BickFgfzN3di4vkvAU+lc8KPb1n0d1VemMJPEqav52ukqRFiyOHmn89Q2PebIjhuQsJzctuVrj5cgxC/X3ZUlSMZRyG2ZiXBSb+Dfxm8W3zXGHgC0jtvsQX9q4ElCfzefwmm/1C6Z39JIXU9Im8i1KbLROOLM1HWldnXUweXoDAVH5Bjtv0YR7Vd/Rd6rsW2d1d4cPDwcXr2Eb6DVK2o2sMyK6U0bHGzPyyJCmM/iRa65YyEl80I3KiO/7Vy/s++UWBkqGTa8xslm2jM2G4xeFCBLwO2XO5QbnviF2l9+j/vDpiYV92b4XuQzK3WYtKvR6ZnOZ5hNk+njTV9HWv/rDFUSvhBLTQ0wDT9LsA8CDDjW3Qy7Q+h4vCzxg3ex+tg72XDKSW0ufGfTSC98qnb7d1vj7rubJwyfHCCB4JRADGt14VsFBx3S8MgbEkRT2wS4mYlpL30UxI+U8Okkd6zONyIhHIfD2Numwo5SnlIvzQL3se/g0CDvPHWmZ6kYY80aXP4oFNOMCdxq0YaG+n1muWKL8ImWzv+l4aquQieT6YgTScDfC2SoBiJGLa1dlNNM0c75ck8voGDMf6PcYBVTubxkw9HTPBc4bwzMvfJpAZv1emTL/d0yZQ8f/8srvGiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac25e29-a7d4-450b-21b6-08d86c328cb7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 09:06:04.0380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxVsKpFhCNb/MoGnUrJZOUZRygz7/vcIyqUqUEp1PM6BIk5DqMIRbn7mczrOlMjL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
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

QW0gMDkuMTAuMjAgdW0gMTE6MDQgc2NocmllYiBDaGFuZ2Zlbmc6Cj4gRnJvbTogY2hhbmd6aHUg
PENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KPgo+IEZyb206IENoYW5nZmVuZyA8Q2hhbmdmZW5nLlpo
dUBhbWQuY29tPgo+Cj4gSXQncyBiZXR0ZXIgdG8gdXNlIGt6YWxsb2Mgb3RoZXIgdGhhbiBrbWFs
bG9jIHRvIGF2b2lkIHVuZm9yZXNlZW4KPiBjb25zZXF1ZW5jZXMuCj4KPiBDaGFuZ2UtSWQ6IEkz
YTczZDNmOTQzZjQ0MDllNmJmYmFkYjAyMzdkYjNmNjQ5ZDgzMWU5Cj4gU2lnbmVkLW9mZi1ieTog
Q2hhbmdmZW5nIDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYwo+IGluZGV4IDViZTEyNWYzYjkyYS4uYTAzMzk4Yzg3MzQ0IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+IEBAIC0xMDAsNyArMTAwLDcg
QEAgc3RhdGljIGludCBhbWRncHVfY3R4X2luaXRfZW50aXR5KHN0cnVjdCBhbWRncHVfY3R4ICpj
dHgsIHUzMiBod19pcCwKPiAgIAllbnVtIGRybV9zY2hlZF9wcmlvcml0eSBwcmlvcml0eTsKPiAg
IAlpbnQgcjsKPiAgIAo+IC0JZW50aXR5ID0ga21hbGxvYyhzdHJ1Y3Rfc2l6ZShlbnRpdHksIGZl
bmNlcywgYW1kZ3B1X3NjaGVkX2pvYnMpLAo+ICsJZW50aXR5ID0ga3phbGxvYyhzdHJ1Y3Rfc2l6
ZShlbnRpdHksIGZlbmNlcywgYW1kZ3B1X3NjaGVkX2pvYnMpLAo+ICAgCQkJIEdGUF9LRVJORUwp
Owo+ICAgCWlmICghZW50aXR5KQo+ICAgCQlyZXR1cm4gIC1FTk9NRU07CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
