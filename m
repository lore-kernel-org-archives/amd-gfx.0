Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA81C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97376144A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97376144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626F06EA9F;
	Thu, 22 Apr 2021 13:56:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C6C6EA9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 13:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvgyHeV+WTNb5afWemYIHb/2jtu9L0prfy+LSUWw4LeyjnGCX8yQH+h6U3TT/x/xwxQo2lLo3bbw2PGUACwX1856/tyqpAnHwvuMp6rhzvhUFSCrfxx9d6dictam2Aw7rnIkSrCbzAla80Kd+yVtPk7+j8JAbFUfAgqOE9pc6YFhJ2Cu27mhfYyqzy6TbLdzoxbHzy57CWmSblXtIlSBs3tgMstwLqCaizBaYiPF3ypdf1bsY3nac3okT9Y3w9IZ70LWhZU/mRQJcoNUv1tnrXKAUQwEMH0SrKN6FJ7FktAUH0xe33MD1GR98iCjMfg06TwQMEcqzxcQ0mAz0/awPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pDjlp58ydWYdYneDDV9yA1qUsARrfrA9ifAF0At6Xc=;
 b=FJqUIb1BLrMjs0nzfu5VHKcbXdRyxo8vGgHh5rJyShwmeMH9TAU5AvsQ95Z5jxG5aTGXmRl4KVnW3z5cZKgG56oXpDhBiR1HaLzZDbXQUDnPKSVvie7y71VAO/Q50Wep4H0Yq69ZbDidqZnC6S8OtJhKEOodwUqunr/pRTnVlO+0IN+HCiME4ty0x49egGLj1AffU+08ewmFSfec92eEfzcROhLtjp+lxCjfgM9pF4XxC2+/9ZP8LKPZEa7CeHln+pUDVXWHQ0n5n4SLl/UIFAqIRplA3SDF/u2kwZL2rZ2DCDoB2pSgmNzvlb8mj1xDTLVH2Oa0eCGk/+SmWoSnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pDjlp58ydWYdYneDDV9yA1qUsARrfrA9ifAF0At6Xc=;
 b=zxDa4SxN6z4QBv5p6N6EzD5Cn33KwHaPUNwHE/RFYHHPSWvfUjluAblrQC8UxsNZnlD/7tah0zzBLpfzUl4MyPxKOeVbF/BuIIHJfWSQmX3pAkLEJzzKUM6ADYJT1ZMx2/zBy3P16tH+xYA7RCFvO+KwxcwlnGXKvy3/c0FEM5A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Thu, 22 Apr
 2021 13:56:18 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 13:56:18 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu: initialize vm->is_compute_context properly
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210422123545.2389-1-nirmoy.das@amd.com>
 <20210422123545.2389-2-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cf1b7b58-d2f0-e7bb-ea59-ae0525b5653f@amd.com>
Date: Thu, 22 Apr 2021 09:56:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422123545.2389-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 13:56:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c20ffc2-abbb-4c72-46e5-08d90596670e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2578CEE1383C037A248177FA92469@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TmokhGxYQfUNWE7obYvldHSFKXa44oz6hRVTYAI8ECas2sKLqp4mZijwqLh0MMBqfUd2rh4hr/2UijgAVaeR3QaOVvi2zx0bNUMbywihfJXKHXt08iwxsZzLJfpKJd1E9UIief93kJAR+gSAkXfFNXRh8GQoxhuTL9vFXJxMhuXMBGfDvalj+K07txIcwFlb/g1XRmH0Ilo8ysCeDMQ/H/c2esZaJskd/4GmTcI+1tdq9Pz/Q8Y2Is/Lv8xqypWV7lum0zrXh8BMNqQtO+Et1A/Po6AsLdOKQz3i7sKWG+LNVyKg8bL51jt4872ZVJJ9lU7y4slsEuhDUX5Md3tMcuh0VqvCIew1hoCJX842PbVNGue1NBWq1v/FoHRbeyd0wMGFwPl/qjxpj8VeIvUux73bkgs39VYDorsNHYyvZiYtdVfamCkv2t/hpQRhoNp1RWIAUWza6YhaWRd1uYCTaGtCVdbVanU6mMo+gd/3XB04TITwHRwVxHOwOMRnElf0kG1KPTQqjpnN+2zg6Bx1RE4olcNn9wkVbVYGdI3Q3Ii16HQOpzzvSpiEPVlon9ukw/XsIw5iMLGeXDsta1umKajcfC5P0FgiTVqbXW5N/78U2uL91s/SPf90HbEKacj7jSgE6TR4OhHuTHD8lt7gf92gBSE6HMQykxUJ02bh3K66tNhhefhTStVzgCCO0aZd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(16576012)(31696002)(8936002)(478600001)(66476007)(83380400001)(956004)(16526019)(86362001)(5660300002)(8676002)(2906002)(186003)(26005)(2616005)(316002)(4326008)(38100700002)(44832011)(6486002)(31686004)(66556008)(36756003)(66946007)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TVVjMVhxYUhIdVpNdFNYMFhBS2VFM0Y5M2cvWmZHZ285V1JQMThLcHZHWmdw?=
 =?utf-8?B?OG8rczN6NXlBZXFJdTRYak5PcVQ5VXFGME5IQ2RCRUJuU1VyaVIvM3N1bU9y?=
 =?utf-8?B?QkY1Y00rVis5MWtpYXRVUStTTnFkUDh4cHhsMjU1cjNpM3VWMHBsUEMwQ0pl?=
 =?utf-8?B?WU9DRk91UWkwNmJ2Tjl2OHI3VzhMY1dKUXRhaHFEWXBHVll1TUlsQ2UwVHRU?=
 =?utf-8?B?amxmSUR6cGNmL1hmUytwZE50OGR3TEtlQWt1TWFXYWV3eUN6ZmpYNU1GY2ov?=
 =?utf-8?B?KzdDYWU2UGNvcmQvbmxZR1R0cU5ENnhLUGs3SXRFNm5LMEdKWTVSV2RaeFl4?=
 =?utf-8?B?TEFlcUM5RHBKS0k0RlR0SmdqU1F0UE12K0JDZG9qcjU0aHhXMlpZR1RnWlpE?=
 =?utf-8?B?SXFpbFZNNFkvRlRRbUgrcDJJNXI2OTVGcUJ1eUFEOVB2bmk2RUk4bDdYQ243?=
 =?utf-8?B?UnlRbU5iZ2tVNkVMcThJUVdyVEhvR3ZwSVFKaFFkVlJ1NWFUc1JRUnBIV2Zm?=
 =?utf-8?B?Qk5nZUdUallWTjI4aDBXUzNRNjNTM3hiRGdZcUlkWXNNMmtSaFI5Z3ZjU0pW?=
 =?utf-8?B?bFNFTmRKNDlqS2FkcUNhdWJMLzdZZTIzM3ZrK1pYWWczV1N3RU9vZUs4MnBK?=
 =?utf-8?B?TGdiRjYzcnRrTDJqdHVaSFN2bzN2TFlEcDdObHNreEQzckhjY0RFdU9udGcw?=
 =?utf-8?B?Q0NWcmF3UXJha1dBSTVlTGRXSDB4NVhNOG9VMVc4Z0pXNkg2aDcxUmU1akhS?=
 =?utf-8?B?cHIyM3JQUWlkL0pOZXZRMzdFOHZmUkJEVXN4VG1oSlVtQlZuK0NYQnBQZDRI?=
 =?utf-8?B?ZkJYbTNTTGh2RFZlUnpWZ0M3M0ZidHFEem1EcnFoVGpRREF3TXFMZ2NmL1NG?=
 =?utf-8?B?MkxlZUkyVXRpTVJXZDRIVDFNK0FnME13VVpvMXdWVWxOTUZXbjVncEpGQ0Uv?=
 =?utf-8?B?S2dDcDlwbjZTZFlDN1RScHM3ZTR5VUIxUkNGZVh2eVZoQmV4ZVpzVUIwU21j?=
 =?utf-8?B?d280TlptMjdVVVJKTVhoNG1idThFWGlYVmFqa0U4aU5ZNldkUm8zT3FNRUlU?=
 =?utf-8?B?UHJ6SnZtVjBlR2dkVXJ3aHhLSENOUmtDQmpVclYrdXN6TVlpYXI3bkRmM0NR?=
 =?utf-8?B?d21Fc05qemFqOXVWR3U3OGN2OXFvbEJhZEZmam5VZWFROVAyOC9pc2VTY0p3?=
 =?utf-8?B?QUNFcXpIb0Nrd05tYXptNHdNZEI5R2RHbHgxd3ZpV2dZbEtnK2g3aUp6QUFj?=
 =?utf-8?B?M05RUEE3OWhXNktCNHVaSmxpczNsZUwxVTl1Wkl4d2M0UG4xYnIwcVNtcDdU?=
 =?utf-8?B?TnpDNlhuRTdobWgya0VuQWdYWm1VemY0ZVMraDhQWlFPSXBFS3E2KzNsdFc3?=
 =?utf-8?B?UlJ1R0lBZnYrM0hlOWF3ZFlPa1ZydGlVK3d3NFVPTFFFdWtKRi82S1VrUW91?=
 =?utf-8?B?T3p3MmZjMmxZMXpMQUpGdFh3YkorcDRKVGZMQ0hYMGcrbFB6UU9YeStyNHpw?=
 =?utf-8?B?NjNQSjBQNUhaY3laZXlFU0RFVGR0b2IzVFY1VFdIZ2F2NFBWdlF3RW1MYzdt?=
 =?utf-8?B?cC95RU1DQ1JOeGJoVmNLcnlROExRMVc5bTU4N3BSYk15dEI4OStZNWx5OVlE?=
 =?utf-8?B?dDkvbmRxcjM3VjFQVkZ2N3UwRHQ5b2JFanY0blNYaG9kY2RRVGUxVGlOemF2?=
 =?utf-8?B?K1Vkdmp0WlpueXRNNGxYbnU3Q1ZFR0dtQWRJSHdLdzRWSGlscFFVWHFxc1Uz?=
 =?utf-8?Q?OlpqHmMpX9MCp9PIIITu1aCB/Jice7WJCK9x49T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c20ffc2-abbb-4c72-46e5-08d90596670e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 13:56:18.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o0g1SENbmkLPLr04waafpq5dhwTIxBtoqGji1glU4lx9mRqSlVsNI0/ATL46CUEKqxdlFFRBNsH/5F8IJgykQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0yMiB1bSA4OjM1IGEubS4gc2NocmllYiBOaXJtb3kgRGFzOgo+IEZpeCB2bS0+
aXNfY29tcHV0ZV9jb250ZXh0IGluaXRpYWxpemF0aW9uIGluIGFtZGdwdV92bV9pbml0KCkuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNiArKystLS0KPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggZjk1YmNkYTg0NjNmLi42ZjBhNjAx
MWNiM2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0y
ODE1LDkgKzI4MTUsOSBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAJCWdvdG8gZXJyb3JfZnJlZV9pbW1lZGlh
dGU7Cj4gIAo+ICAJdm0tPnB0ZV9zdXBwb3J0X2F0cyA9IGZhbHNlOwo+IC0Jdm0tPmlzX2NvbXB1
dGVfY29udGV4dCA9IGZhbHNlOwo+ICsJdm0tPmlzX2NvbXB1dGVfY29udGV4dCA9IHZtX2NvbnRl
eHQgPT0gQU1ER1BVX1ZNX0NPTlRFWFRfQ09NUFVURTsKPiAgCj4gLQlpZiAodm1fY29udGV4dCA9
PSBBTURHUFVfVk1fQ09OVEVYVF9DT01QVVRFKSB7Cj4gKwlpZiAodm0tPmlzX2NvbXB1dGVfY29u
dGV4dCkgewoKQSB3ZWFrIGFnbyBvciBzbywgSSBzdWJtaXR0ZWQgYSBwYXRjaCB0aGF0IHJlbW92
ZWQgdGhlIGxhc3QgY2FsbCB0bwphbWRncHVfdm1faW5pdCB3aXRoIHZtX2NvbnRleHQgPT0gQU1E
R1BVX1ZNX0NPTlRFWFRfQ09NUFVURS4gV2UgY291bGQKcHJvYmFibHkgY2xlYW4gdGhpcyB1cCBu
b3cgYW5kIHJlbW92ZSB0aGUgdm1fY29udGV4dCBwYXJhbWV0ZXIgYW5kIHRoZQpBTURHUFVfVk1f
Q09OVEVYVCogZGVmaW5pdGlvbnMuIFRoZSBvbmx5IHdheSB0byBnZXQgYSBjb21wdXRlIFZNIG5v
dyBpcwp0aHJvdWdoIGFtZGdwdV92bV9tYWtlX2NvbXB1dGUuCgpSZWdhcmRzLArCoCBGZWxpeAoK
Cj4gIAkJdm0tPnVzZV9jcHVfZm9yX3VwZGF0ZSA9ICEhKGFkZXYtPnZtX21hbmFnZXIudm1fdXBk
YXRlX21vZGUgJgo+ICAJCQkJCQlBTURHUFVfVk1fVVNFX0NQVV9GT1JfQ09NUFVURSk7Cj4gIAo+
IEBAIC0yODQ0LDcgKzI4NDQsNyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAJdm0tPmV2aWN0aW5nID0gZmFs
c2U7Cj4gIAo+ICAJYW1kZ3B1X3ZtX2JvX3BhcmFtKGFkZXYsIHZtLCBhZGV2LT52bV9tYW5hZ2Vy
LnJvb3RfbGV2ZWwsIGZhbHNlLCAmYnApOwo+IC0JaWYgKHZtX2NvbnRleHQgPT0gQU1ER1BVX1ZN
X0NPTlRFWFRfQ09NUFVURSkKPiArCWlmICh2bS0+aXNfY29tcHV0ZV9jb250ZXh0KQo+ICAJCWJw
LmZsYWdzICY9IH5BTURHUFVfR0VNX0NSRUFURV9TSEFET1c7Cj4gIAlyID0gYW1kZ3B1X2JvX2Ny
ZWF0ZShhZGV2LCAmYnAsICZyb290KTsKPiAgCWlmIChyKQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
