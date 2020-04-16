Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6309C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD4D206A2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aVgucDH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD4D206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482C76EA31;
	Thu, 16 Apr 2020 19:58:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB516EA31
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 19:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNuk9YE/bG1dxGdA9HKmDePc2Vk67MrZrXUXDIZdgG2qGRngaiwfam5Ar342QiaW47fUrRN751vJjf6AC9W7mcwplceXes+SD9srNwTgqFvVe7u3L7GbDX3BsB48fEKHl0bQKUsXk2wy/FC2CY5071VBfy2rJMJwt3UFkQTNerZQQqBqTjl07ZNjq5k/35GAKmooQqbke9ONx0IA+KthLJkz3YwT70EeJgeiLXYsTKgRRXDuJGH5jOFE7mdpOJl6ovPsDO5jgoZpVJQOpPpIoDFfEInAbqh6IAzr3c3xeSk64JidNgPtG6pGtlRCxTyyMsYIhNX9niawjVOKFYxAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH0Zww7u/N4HpZtaldAOcrrIV589rJ2nLc7UU1EUDAg=;
 b=L2tjaqFhaTaeIMdzOWIJHM6Dlmkso1s4kArZ8XjHA4SUXxk2hzbeYpVvXydMws6PwdEbrWdDzspN2CgJbH/gAbqJzolH0R3yiiI8rBKuabdVquQmIF6tFJXWdLCKsJXXinSivdWWz4bd8zDz44NfPavHYMSQd/G9DkW6n0K+wMmg//0mYlaxXcV/fbHfZYyHA+R6XwsqntDT2c4fUgLmb74DuzKOzILXYb46jJwgT7hGe0VHGcoGD8ulyaOtJFROWe5eTOL246PUPoyJz9P+CsYJBaYUl92/ZzbYsCFsZFhpQB1532ChNHgC0LxbAaGgBRMTzIGqbrle1dJ4gTx8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH0Zww7u/N4HpZtaldAOcrrIV589rJ2nLc7UU1EUDAg=;
 b=aVgucDH1M/YbbaWenYf+U78MnZUCSkuqLWXdw/GsR8HonNRDfn4vYCQNBjJwIsRop+ApbpqUw7bFVVGfwL3bp3p9pdafRiCtD7+EmBmrvxSx0l83sZYbUHA2qTC/EjmLrtlgpkkQerKEi8TmGCMcgQmqcpYJpglrLspx4Ir3UnI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2462.namprd12.prod.outlook.com (2603:10b6:802:28::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Thu, 16 Apr
 2020 19:58:25 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 19:58:25 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Put ASIC revision into HSA capability
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200416193330.417754-1-Joseph.Greathouse@amd.com>
 <20200416193330.417754-2-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0f6d51ba-0247-c6a1-2a99-2b747754074a@amd.com>
Date: Thu, 16 Apr 2020 15:58:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200416193330.417754-2-Joseph.Greathouse@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 19:58:24 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9835918-1e57-4a41-6f0b-08d7e240860d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2462:|SN1PR12MB2462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24629F2CC659D4509BE558CC92D80@SN1PR12MB2462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(52116002)(8936002)(26005)(5660300002)(44832011)(16576012)(316002)(31686004)(81156014)(8676002)(16526019)(956004)(186003)(478600001)(31696002)(86362001)(2616005)(66556008)(66946007)(66476007)(2906002)(36756003)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7OGEfSNPKcnfT1v8j/JT+rtj7ZXj9siKOQ7RjgyqX6Iw3j1LRcGDaAeEObmGCYT27QDyB0apoYafoWl85sDR1ayN56sRbQthk3q3BCUA5FVyp24XiXEU8SFYOdzX56bJmUUn+jizIUBGZBS2bm5+PICF6JlpkzSZzed/kj8VcR5JTIF1xRS+GWYG9ASwLvZHv9hhp366OBka2ek6CiQzJ52Rtlr04PPr3NVz+Q26BujdTPFsmFjmoZ7gvjF+htAof56XekmuUVbk5X1IYIuNNZLCtvJ4sXh9QGD7sTZ2Rx69h4/hOki8UJuwFJEuoZOxU8NjWRZHdvvezLfF6mvfj+hZerCCzp4rfX07e5QbsXb5+f6ZzYSwyChjlrm/xDPeLPH0vkTJQmnbCNRGkJPP1l8psXIMZ4OtKhqn12HIdQFxvYcUfJF9BoTCU25cHiZ
X-MS-Exchange-AntiSpam-MessageData: HuWZFImA4oTTeFZFIraAuFg76iY1nqh1qVpBsM1wFU2r4tL9dojdmbMYmZEFySEPwBnhUogR6yz2pPFuj5h07daO2zBvk1EUFRwToHt7KQs8HeUwzzrDnyQHrHq36qQOZars5cwZGw+eyluHRwcClQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9835918-1e57-4a41-6f0b-08d7e240860d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 19:58:25.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcciBwSmcoTcktmU+PHL1Su8JjHUtjC9IhlsNQWVUfbNUevmEl6nDMzIAtJnSs8eLF/165iyvjNO6PB8PIiSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2462
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmsgeW91IEpvZS4KCllvdSBjYW4gc3F1YXNoIHRoZSB0d28gcGF0Y2hlcyBpbnRvIG9uZS4g
S0ZEIGFuZCBBTURHUFUgYXJlIHJlYWxseSBvbmUKY29tcG9uZW50LCBhbmQgc2VwYXJhdGluZyBj
aGFuZ2VzIGludG8gc2VwYXJhdGUgY29tbWl0cyBpcyBub3QKbmVjZXNzYXJ5LiBJJ2QgYWxzbyBt
YWtlIGFtZGdwdV9hbWRrZmRfZ2V0X2FzaWNfcmV2X2lkIGEgc3RhdGljIGlubGluZQpmdW5jdGlv
biBpbiBhbWRncHVfYW1ka2ZkLmgsIHNpbmNlIGl0J3MganVzdCBhIG9uZS1saW5lci4KCk90aGVy
IHRoYW4gdGhhdCwgdGhpcyBsb29rcyBnb29kIHRvIG1lLgoKUmVnYXJkcywKwqAgRmVsaXgKCkFt
IDIwMjAtMDQtMTYgdW0gMzozMyBwLm0uIHNjaHJpZWIgSm9zZXBoIEdyZWF0aG91c2U6Cj4gSW4g
b3JkZXIgdG8gc3VyZmFjZSB0aGUgQVNJQyByZXZpc2lvbiB0byB1c2VyIGxldmVsLCB3ZSB3YW50
Cj4gdG8gcHV0IGl0IGludG8gdGhlIEhTQSB0b3BvbG9neS4gVGhpcyBjYW4gYmUgYmVjYXVzZSBk
aWZmZXJlbnQKPiBBU0lDIHJldmlzaW9ucyBtYXkgcmVxdWlyZSB1c2VyLWxldmVsIHNvZnR3YXJl
IHRvIGRvIGRpZmZlcmVudAo+IHRoaW5ncyAoZS5nLiBwYXRjaCBjb2RlIGZvciB0aGluZ3MgdGhh
dCBhcmUgY2hhbmdlZCBpbiBsYXRlcgo+IGhhcmR3YXJlIHJldmlzaW9ucykuCj4KPiBUaGUgQVNJ
QyByZXZpc2lvbiBmcm9tIHRoZSBoYXJkd2FyZSBpcyBtYXhpbXVtIG9mIDQgYml0cyBhdCB0aGlz
Cj4gdGltZSwgc28gcHV0IGl0IGludG8gNCBvZiB0aGUgb3BlbiBiaXRzIGluIHRoZSBIU0EgY2Fw
YWJpbGl0eS4KPiBUaGVuIHVzZXItbGV2ZWwgc29mdHdhcmUgY2FuIHVzZSB0aGlzIGNhcGFiaWxp
dHkgaW5mb3JtYXRpb24gdG8KPiBrbm93IC0tIGZvciBlYWNoIEFTSUMgLS0gd2hhdCByZXZpc2lv
bi1iYXNlZCB0aGluZ3MgbXVzdCBiZSBkb25lLgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9zZXBoIEdy
ZWF0aG91c2UgPEpvc2VwaC5HcmVhdGhvdXNlQGFtZC5jb20+Cj4gQ2hhbmdlLUlkOiBJZjQ2YjNh
MTg2NGQwYTdhNjdiOTVmZGRmYzFkY2Q5MzkzMmNhODFkNgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDQgKysrKwo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuaCB8IDUgKysrKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF90b3BvbG9neS5jCj4gaW5kZXggNWRiNDI4MTRkZDUxLi42ZTUyYzk1Y2U4YjAgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYwo+IEBAIC0xMzAz
LDYgKzEzMDMsMTAgQEAgaW50IGtmZF90b3BvbG9neV9hZGRfZGV2aWNlKHN0cnVjdCBrZmRfZGV2
ICpncHUpCj4gIAo+ICAJZGV2LT5ub2RlX3Byb3BzLnZlbmRvcl9pZCA9IGdwdS0+cGRldi0+dmVu
ZG9yOwo+ICAJZGV2LT5ub2RlX3Byb3BzLmRldmljZV9pZCA9IGdwdS0+cGRldi0+ZGV2aWNlOwo+
ICsJZGV2LT5ub2RlX3Byb3BzLmNhcGFiaWxpdHkgfD0KPiArCQkoKGFtZGdwdV9hbWRrZmRfZ2V0
X2FzaWNfcmV2X2lkKGRldi0+Z3B1LT5rZ2QpIDw8Cj4gKwkJCUhTQV9DQVBfQVNJQ19SRVZJU0lP
Tl9TSElGVCkgJgo+ICsJCQlIU0FfQ0FQX0FTSUNfUkVWSVNJT05fTUFTSyk7Cj4gIAlkZXYtPm5v
ZGVfcHJvcHMubG9jYXRpb25faWQgPSBwY2lfZGV2X2lkKGdwdS0+cGRldik7Cj4gIAlkZXYtPm5v
ZGVfcHJvcHMubWF4X2VuZ2luZV9jbGtfZmNvbXB1dGUgPQo+ICAJCWFtZGdwdV9hbWRrZmRfZ2V0
X21heF9lbmdpbmVfY2xvY2tfaW5fbWh6KGRldi0+Z3B1LT5rZ2QpOwo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5oCj4gaW5kZXggNDZlZWVjYWYxYjY4Li4wYzUxYmQz
ZGNkNTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9s
b2d5LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuaAo+
IEBAIC00MSw3ICs0MSw2IEBACj4gICNkZWZpbmUgSFNBX0NBUF9XQVRDSF9QT0lOVFNfVE9UQUxC
SVRTX1NISUZUCTgKPiAgI2RlZmluZSBIU0FfQ0FQX0RPT1JCRUxMX1RZUEVfVE9UQUxCSVRTX01B
U0sJMHgwMDAwMzAwMAo+ICAjZGVmaW5lIEhTQV9DQVBfRE9PUkJFTExfVFlQRV9UT1RBTEJJVFNf
U0hJRlQJMTIKPiAtI2RlZmluZSBIU0FfQ0FQX1JFU0VSVkVECQkJMHhmZmZmYzAwMAo+ICAKPiAg
I2RlZmluZSBIU0FfQ0FQX0RPT1JCRUxMX1RZUEVfUFJFXzFfMAkJMHgwCj4gICNkZWZpbmUgSFNB
X0NBUF9ET09SQkVMTF9UWVBFXzFfMAkJMHgxCj4gQEAgLTUxLDYgKzUwLDEwIEBACj4gICNkZWZp
bmUgSFNBX0NBUF9TUkFNX0VEQ1NVUFBPUlRFRAkJMHgwMDA4MDAwMAo+ICAjZGVmaW5lIEhTQV9D
QVBfTUVNX0VEQ1NVUFBPUlRFRAkJMHgwMDEwMDAwMAo+ICAjZGVmaW5lIEhTQV9DQVBfUkFTRVZF
TlROT1RJRlkJCQkweDAwMjAwMDAwCj4gKyNkZWZpbmUgSFNBX0NBUF9BU0lDX1JFVklTSU9OX01B
U0sJCTB4MDNjMDAwMDAKPiArI2RlZmluZSBIU0FfQ0FQX0FTSUNfUkVWSVNJT05fU0hJRlQJCTIy
Cj4gKwo+ICsjZGVmaW5lIEhTQV9DQVBfUkVTRVJWRUQJCQkweGZjMDc4MDAwCj4gIAo+ICBzdHJ1
Y3Qga2ZkX25vZGVfcHJvcGVydGllcyB7Cj4gIAl1aW50NjRfdCBoaXZlX2lkOwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
