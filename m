Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AAAC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 14:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE362173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dN9KFMs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE362173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED34089D39;
	Mon,  2 Mar 2020 14:17:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B620389D39
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 14:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpiEEQO3aT7KBeuOpVZBZaB/GMgilNd8qEP/wmzwC4Vcw5CXkymzpzEtThhkKjnV7j4H6+3LkHc+JoSxh6brQTGyNMOeDrwja2UCClh/vrVAPf+KWabKJ/+rDrBs1BUInnxlkmh7hVaX3M0UBDujE/4/3nHVvA9FYy/hqB+oMxAU7FifyAgt+3FodZU95IdVsWoWl6pRnN7Y9BxOo3k+usfCtrpS5AeolYOAo4mpDqzzrDM0A3ayLCWPmxT/k+/Eh+1A9kKu8U/KCrtZL8D9yGU2Ee2OnHpAiy9Xr2JylmDKWDWYPK8EigTXEMeUaT+MjecSzt5TBwLWcCn2QMmcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jACpTobjLEKIfU99nh34T6tcM5SE1yZ7Q/PoxnsPzSI=;
 b=eQCT3Ws4wjMdla8uBKXl/dP4CUhQZWL4Kb3GVBcA2UIY1MnlmNiEFWq732oFQE/UBZR+tZ51LTPlpTXWXQ/EAu/XDlPTN8O/gMHwqKfFz0s0+2vYf1EkLhAgXj8l4zQD388+dEHXQfK5EeN9eRqA8d//6sm3PynJvLnIZ/COFhFsFaaJaLuWzfJtwt/JetzBCCq0VwmnBhXxi9dRrm2+9y6H4y0ynvw8O6zqN5lpJzkdI0CINhi255PcRNVRs8d9H6ub0H5mkF4FeJiHCoHNLhLPxwlVPYkEeprMqxiIlb6NyaScfR6QcL7whsqkbfKFWx4Sb0b6Ghs5sybn1oG6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jACpTobjLEKIfU99nh34T6tcM5SE1yZ7Q/PoxnsPzSI=;
 b=dN9KFMs4wEtFE5Nl8AQiVflL8R9O1TOHv2qKRSJF+bvbzYgODJIOliuHoGTch6hsQqVBABXII7o6R9Qkb359ZReCgKJKP1E0pLYWiVmQacdccnCFGrU70cJ5C+jheu8J41bDY/7pMP0qnoJ4RFD7k+Zux/bS18mPZ0imqHgh1M4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1689.namprd12.prod.outlook.com (2603:10b6:4:3::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 14:17:43 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 14:17:43 +0000
Subject: Re: [PATCH v5 1/4] drm/amdgpu: set compute queue priority at mqd_init
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200302125836.56915-1-nirmoy.das@amd.com>
 <10f79f2c-4baf-e004-d75b-68836ea2e5bc@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <e98f6ea5-bb79-3c8a-354a-33e1b7a53e4b@amd.com>
Date: Mon, 2 Mar 2020 15:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <10f79f2c-4baf-e004-d75b-68836ea2e5bc@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:205:1::34) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.76] (93.229.38.130) by
 AM4PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:205:1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Mon, 2 Mar 2020 14:17:42 +0000
X-Originating-IP: [93.229.38.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ea129ba-65aa-406d-6d5d-08d7beb47940
X-MS-TrafficTypeDiagnostic: DM5PR12MB1689:|DM5PR12MB1689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16893BF4CB61A103053800D18BE70@DM5PR12MB1689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(5660300002)(2906002)(36756003)(66556008)(316002)(31686004)(52116002)(6666004)(66476007)(66946007)(16576012)(478600001)(8936002)(26005)(186003)(16526019)(8676002)(31696002)(81166006)(4326008)(81156014)(6486002)(110136005)(53546011)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1689;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mk7MG0blRxvh0HHgpaSvuFwo/eesGG15I08VbesIYyydeGa/j/E1XzXYBKMURZVZwVMQD7pBn3o/ojLTkhN+zbI5RwRPYumMOpy6UXVZFz1BDEaYmulZ767mbcMp7Wd17xKA9Np+RzoSg9MqbN3UGEfb7EL4KYwvvPzlcWuFJvVcvTTp2aHov7wYkZ+Ge70xlaIC02wQ2q0lGPlD5XgFJRILsknuq0KyWhDeeyma4n/GPq2N2HY/vg4DR/Ye9fIaktO9WsbcZEIDI3cTdgDfD/HtL8krQ/lrOQ3CIaNfgEyL7V2Mm8i3/rfsZ2Equ0U+RCJeAKkzJOFxSxawx7wcz8MtNxwazca5d0SNp5LqnTaEjdJ1x+WcTddRibgiVgDtC7+L3WP3iRAZFXF5ZaqtENf2YwTpjsNt/4xqxs+Pzx9Rh1dcGI+AUHDUmyf6TSBR
X-MS-Exchange-AntiSpam-MessageData: h2+MSoLGp4+vOMA1nViMjWrqtArbtU75VHaZV7Rj/tJoO1HhG6//sCOOBYK6N5RxgWWja1e8j51WSgK4D9QwEvQjN+CBXYkHKQOpG5cy66TKCdVPEu8c/SIz0r/KhMugr3LDFzBCvGzTYtS0KCCD/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea129ba-65aa-406d-6d5d-08d7beb47940
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 14:17:43.5949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q+s+yf/9AXB37ZfPDTiCGyhcP56gbqE43p8QVKv8gnFSXwQYRvF2ZBawtPctNvQPsGNmtEL/ACk10o05UlcSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1689
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuCgpPbiAzLzIvMjAgMjoxMCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pgo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jp
bmcuaCAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4+IGlu
ZGV4IDI0Y2FmZjA4NWQwMC4uMjAxYzZhYzdiZjlkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKPj4gQEAgLTIyMiw2ICsyMjIsNyBAQCBzdHJ1Y3QgYW1k
Z3B1X3Jpbmcgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBtdXRleMKgwqDCoMKgwqDCoMKgIHByaW9y
aXR5X211dGV4Owo+PiDCoMKgwqDCoMKgIC8qIHByb3RlY3RlZCBieSBwcmlvcml0eV9tdXRleCAq
Lwo+PiDCoMKgwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpb3JpdHk7Cj4+ICvC
oMKgwqAgYm9vbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2Z4X3BpcGVfcHJpb3JpdHk7Cj4KPiBE
aWRuJ3QgeW91IHdhbnRlZCB0byBtYWtlIHRoaXMgYW4gZW51bT8gT3Igd2FzIHRoYXQgYW5vdGhl
ciBmaWVsZC4KClNoYWxsIEkgbW92ZSBnZnhfcGlwZV9wcmlvcml0eSB0byBhbWRncHVfcmluZy5o
wqAgZnJvbSBhbWRncHVfZ2Z4LmgKCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yaW5nLmgKQEAgLTM1LDYgKzM1LDEzIEBACiDCoCNkZWZpbmUgQU1ER1BVX01BWF9WQ0Vf
UklOR1PCoMKgwqDCoMKgwqDCoMKgwqDCoCAzCiDCoCNkZWZpbmUgQU1ER1BVX01BWF9VVkRfRU5D
X1JJTkdTwqDCoMKgwqDCoMKgIDIKCisvKiBnZnggcmluZydzIHBpcGUgcHJpb3JpdHkgKi8KK2Vu
dW0gZ2Z4X3BpcGVfcHJpb3JpdHkgeworwqDCoMKgwqDCoMKgIEFNREdQVV9HRlhfUElQRV9QUklP
X05PUk1BTCA9IDEsCivCoMKgwqDCoMKgwqAgQU1ER1BVX0dGWF9QSVBFX1BSSU9fSElHSCwKK8Kg
wqDCoMKgwqDCoCBBTURHUFVfR0ZYX1BJUEVfUFJJT19NQVgKK307CgpvciBlbHNlCgpAQCAtMjIy
LDcgKzIyOSw4IEBAIHN0cnVjdCBhbWRncHVfcmluZyB7CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
bXV0ZXjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW9yaXR5X211dGV4OwogwqDCoMKgwqDCoMKg
wqAgLyogcHJvdGVjdGVkIGJ5IHByaW9yaXR5X211dGV4ICovCiDCoMKgwqDCoMKgwqDCoCBpbnTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW9yaXR5OwotwqDCoMKg
wqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZnhfcGlw
ZV9wcmlvcml0eTsKKworwqDCoMKgwqDCoMKgIGVudW0gZ2Z4X3BpcGVfcHJpb3JpdHnCoCBwaXBl
X3ByaW9yaXR5OwoKZG9lc24ndCB3b3JrIGJlY2F1c2Ugb2YgY29tcGlsYXRpb24gZXJyb3I6ICIg
ZmllbGQg4oCYcGlwZV9wcmlvcml0eeKAmSBoYXMgCmluY29tcGxldGUgdHlwZSIKClJlZ2FyZHMs
CgpOaXJtb3kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
