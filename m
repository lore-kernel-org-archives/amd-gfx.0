Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F284C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD22B6117A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD22B6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257626EC04;
	Tue, 18 May 2021 15:45:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E336EC04
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCoy20JZX+jotMskgiFypgJEZMre/e4QG2CuD/zHu1NAgx4ShN+j7oOpD9TDUq5VIBGJo2vxZIpaTwC3aoCEFHPynuby6Rqdz9Y7RDqbZZmb6A+MbDVdjiwyG5rgNUQ4bIYpVvPA4yyOjzQ84ZoKo5lTNxdjm+/ZEqXj6eU/uhFUFvCICXJe73mXJvAArHJEY87dokldvrlyA+O9BX/ZLQTJdz5Goo0/lotWR6IRFmFCAMPrMBUcjilvACt4b2S4G5jXnvp3r7UF6lIWIzVZ6e0908QNC+dD8F2Qhgt0YW+PLTKL7QpL4J75W4cAlPNFamZMcv0RYljg05GI477NMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buh7WEaw7/HQ95ey7hhk/g3yAl3Dr0c4RxnY7BgJU2o=;
 b=WveF3G8IjAW14Ic7PsyfCLzhYlAvWb9mA8YpiHc1NBslCwQx8ke2MS1bkTgSoGO7bRibCJmArBrQZgucFMWsfTciSlLJVcpn0sot5QePUXwdS2o2Yvh2I7Oo8lPUlDF8B6onIsL7LwDeFyR+Smyv5VJ6N0Jw+6sZHQqYSQqJbevGTGSdVD6FiOKegxdTPGUikNvT7ldewrgHZJRMTyhkan6vjxS6y110C8RO5oXhVHuWHRs4BDRWOxHZOJUuImfKwfwaGy9GiidGKeFU8jGR2hEkQDMBXA9OQEiP5Tat1DgkxGWtkl0QJYJXCGfdUDvFhSR7IPbJUC9/8+pYoSZkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buh7WEaw7/HQ95ey7hhk/g3yAl3Dr0c4RxnY7BgJU2o=;
 b=ALhUfArEImSG7TddozdRzqRztnAvNArAk5XMwaPV+41+cFzS+65hqvis1Zf2e3/gpEw5WtnxK+d0YhIoH9U3SPISXnifCfYiaMBPS37gKA8JbDwBm7a077yNSh5kkjPLt2g1BW/eIy+H1OeSoVLdVZ+uxcSEFXZ8y8rC2DE/1PA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Tue, 18 May 2021 15:45:20 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 15:45:20 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
 <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
Date: Tue, 18 May 2021 11:45:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 18 May 2021 15:45:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a6fb69e-c8de-4caf-9f21-08d91a13f126
X-MS-TrafficTypeDiagnostic: DM6PR12MB4577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4577796A121C25B5B8BC3F5DE42C9@DM6PR12MB4577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46P5qy4hyhs3zYP2Hi0H3oNfg3R2I20hiBlLiwEnJCjwAgkfE2wHBBgrBz0C59ypKm59TlU36626wXTAOp/g08Ti3waCZHDyS8aanJYQEHOltbDpet5BzOkDfLt0cQKqcvHtg4ylUu/2EddWa6lZ7X52jQWilLnnzvQLs15SgkCrQF69KA0/ufx4S1QQQjq6PPrOeWzY/0mwhP2I//kNzYz2/+TrlzaKVk+ZfjA86tlMef6jxWstnG9SkfDT3X+4hGTy/eD0UrZSjrOz5zKNqn1KztEas3T4TpMgeEQDz6wrJZJ8keI/ob0sg9JDI9b3/UMqk7/XW4RDkdd9WoZA3NHwZZzp4jGfoETXlgdkbd8UYy2Nw0Ssm+69NxVfhdipUj58sodWGiFwyYUn7j8guu+mgcKZSMBHH7uMGQqtxKeceaH+zfRJVIdTBGfeaJwulmALGIRd3Cxj915TlSLo3D6VOlSKX8Zesmgd/VT7ZH8VQPa5QivuHeAu7LD6TQ7BmCyl2sxHO4dIrV6IgX1oEHPu2qeIGXHw5IcXHVsdf6CFCbbpm8jOefFP9XtmFJEcNOmJAeyjDrxZ8SGNxxVdUI8Us+cA5VKKbAzxaA2IQAc0TVmTbX2YFHucyNRcc20xKdn2Xkxj4HSE0t8lVhBdL0ZLk/HWZDBLkxJEIsd90ivCKAUVUDmR6N+fE2vOMruwAKq6YpxxWRU5Loc1jhDBKyOU7gbnaD2sgGsbWz4kO+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(956004)(2616005)(26005)(53546011)(186003)(16526019)(36756003)(6486002)(38100700002)(5660300002)(83380400001)(31686004)(2906002)(38350700002)(66574015)(8936002)(66946007)(316002)(8676002)(16576012)(36916002)(52116002)(110136005)(66476007)(66556008)(31696002)(478600001)(3714002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEY1YmxHcDgyQmhIV2I5T2l0L2JqeEcrUzFybjlUYldrMTNtLzZMQ1J0Ly9h?=
 =?utf-8?B?TTFNQkJ6QnlwcjlaV0Nvbk1nUUpQQUhEdXE1WlhwZnZHMmtNUVgwT2hPazlW?=
 =?utf-8?B?R2ExaGNvTXhEVUxURU1XemYvNytlTlZ2dmg1RFVoSjh6RElzSTlzVHI3Sk5K?=
 =?utf-8?B?V2xUOVpWYlh0cDJiVnVNcG5OdVBPVnBrMjBLdGFjTEFTMWJLWEpQczI1RnB1?=
 =?utf-8?B?ZEtWK0RyRkpVbkI5NGZFSU1PaVVCandBeHJPUEtXTkRDUG9QeGplWGNmVHNX?=
 =?utf-8?B?U0dmdWZTUlhNQmVaa2ZiVSt2dFNGcy90WjBWOW44bkNaTjdKOWd0eVh4NXVS?=
 =?utf-8?B?N2Q5Y1FNSnZIa3pEZ2p6Q1QrbVlzaEJ6NzBXQitXcFFIWi9ObzFuUnNFZk05?=
 =?utf-8?B?MUl1aHdlR003NElKUkd1UzNJaGxWRktXRE1JWVdMSWU2dTBWMzRmelc5bkxV?=
 =?utf-8?B?dDk3dm9EWFFJLzZ4WUdLS2srMHNZM0d0N3RtRjV6OUJkNXNzaFQrcllCNnVW?=
 =?utf-8?B?bjZuZWVHK3RjaFZYWUNMZ3lvRUhPa3dQRlZhZzFvNEFkVDE0WDdwNFZHWlpU?=
 =?utf-8?B?VHQyZkh2OGx6TXhaT29ucjRhWnVaWjY3THNuNTQ0MU05TlA3VHNYYlRvS3NW?=
 =?utf-8?B?TUhNRkxhRVFGSzRoc2FWUHYzUmlYRHNTamEwR1dDQ1V6YzJoQktzTCtGWkVO?=
 =?utf-8?B?UVdON2xRMkg2K1hwS3dsRmFpbzJDY2crbDNEVnhYL0NSdTBsNksyZzJLQmJz?=
 =?utf-8?B?SWljbWVYMUtxak9tK2ZXUExFUFE5MU1VbktWMnNiRFNLenQ4dThlOXEvWjFW?=
 =?utf-8?B?eFphTTdzSGQ0TFFsL21zRWNEejRZdmxHQk9QZkREOUVBMTdkT2VDaEptSVVk?=
 =?utf-8?B?OTRFRGdiYWMyMjgxaFJwbmErRFVldlhDaEVFTVAzbElFYkJtdUdqUTEvUEpD?=
 =?utf-8?B?UmtzcmlvSmJlNkdPckh6TW5QRVE1UFNweENmS2x0MkNSL1UvZFNQZHZqTXl3?=
 =?utf-8?B?ZzBlTy9qN3NtUm9NRGtobnhTbGFVY1Q4WEdVU2MveUlTVi9VTWdPZmh2K1B5?=
 =?utf-8?B?Ty9YNFZGcVlsMXpIU0NtQ2UzTEk4L1pYcEVMUnQrWjdkTjhoR3NpcE01VDVq?=
 =?utf-8?B?Yi9GTDBZQW1nSWJHMlhhbTZ4M2lFdUs5ejBBamlRK08zOEU4V0JTNFM0clRx?=
 =?utf-8?B?WUdvTjVYMGdUSEtBRlNEbm90YlNrZGNyYjA0MDRXSFpZcGZwcVkvd2lCYUZH?=
 =?utf-8?B?R1d1TE9DRDhQT2VjZlJta25nK3ZFWThqTHJIYjRyeWZCYktpQktuV2F4d2Vr?=
 =?utf-8?B?cmIxSk1sRVVDY2JKc1NvUmxZbjA4TS9wMnRzRWxBNEVlVkp3OElKNktlOGJT?=
 =?utf-8?B?UnhPdlkvYzRYRWJQVHdOQWd6UXVWZ1NCSkdsOUFhWk41WjU5d1FkZ0czeUYr?=
 =?utf-8?B?WGViRlR0L2dYRlpHSEhEV0dmbzE2MEJNWTI3KzY0NmRTaDlSNjFUVGc2MkNu?=
 =?utf-8?B?WlI5cEFwbkpVNkdqek92L1hBVldtSERXSmZwQlRoVFY4QWt5Yzg0SW9OdkJZ?=
 =?utf-8?B?bkdiYTNZOXg4b0I1V2JFWW9JWERiRnZlOHVLb1cySVFDYTdFVHh4Y0U2ekVS?=
 =?utf-8?B?MklEMzM3d0NmWm5iSjBiTXRUNElQaWZibDBMQ0h0VzB6bTJWREhxK3BjWUFB?=
 =?utf-8?B?MjN5TDk0ZGE1ZSt0M3VvblFkYXFyYm4xYm5RamFGRmcyYnpPZlZrdGlGaTlR?=
 =?utf-8?Q?uiEh1xQloE4Zh9omUvZVzDYKpwe3S1PE7xC1Cvg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6fb69e-c8de-4caf-9f21-08d91a13f126
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 15:45:20.3645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpApcWhg8Ut0ysQ7C2K/NoNyyITfHShMzZP3nmKvOQxvvOmIZGms3PODqJFI/hgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
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

Ck9uIDIwMjEtMDUtMTggMTE6MjMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAx
OC4wNS4yMSB1bSAxNzoxMSBzY2hyaWViIEphbWVzIFpodToKPj4gQWRkIGNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYyBiZWZvcmUgc2V0IHBvd2VyIGdhdGluZyBzdGF0ZQo+PiB0byBhdm9pZCByYWNl
IGNvbmRpdGlvbiBpc3N1ZSB3aGVuIHBvd2VyIGdhdGluZy4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
SmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgfCAxOSArKysrKysrKysrKysrKysrKystCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIAo+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPj4gaW5kZXggMGMxYmVlZi4uNmM1YzA4
MyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4+IEBAIC0yMzAs
MTAgKzIzMCwyNyBAQCBzdGF0aWMgaW50IHZjbl92MV8wX2h3X2luaXQodm9pZCAqaGFuZGxlKQo+
PiDCoCBzdGF0aWMgaW50IHZjbl92MV8wX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQo+PiDCoCB7Cj4+
IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKiloYW5kbGU7Cj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nOwo+PiAr
wqDCoMKgIGludCBpOwo+PiArCj4+ICvCoMKgwqAgcmluZyA9ICZhZGV2LT52Y24uaW5zdC0+cmlu
Z19kZWM7Cj4+ICvCoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4gKwo+PiArwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX2VuY19yaW5nczsgKytpKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCByaW5nID0gJmFkZXYtPnZjbi5pbnN0LT5yaW5nX2VuY1tpXTsKPj4gK8Kg
wqDCoMKgwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+ICvCoMKgwqAgfQo+PiAr
Cj4+ICvCoMKgwqAgcmluZyA9ICZhZGV2LT5qcGVnLmluc3QtPnJpbmdfZGVjOwo+PiArwqDCoMKg
IHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4KPiBUaGlua2luZyBtb3JlIGFib3V0IHRoYXQg
dGhpcyBpcyBhIHJlYWxseSBiaWcgTkFLLiBUaGUgc2NoZWR1bGVyIAo+IHRocmVhZHMgbXVzdCB0
byBzdGF5IHJlYWR5IGR1cmluZyBhIHJlc2V0Lgo+Cj4gVGhpcyBpcyBjb250cm9sbGVkIGJ5IHRo
ZSB1cHBlciBsYXllciBhbmQgc2hvdWxkbid0IGJlIG1lc3NlZCB3aXRoIGluIAo+IHRoZSBoYXJk
d2FyZSBzcGVjaWZpYyBiYWNrZW5kIGF0IGFsbC4KCj4gW0paXSBJIHBvcnRlZCB0aGlzIGZyb20g
Y3VycmVudCB2Y24zIGh3X2ZpbmkuIEp1c3Qgd2FudCB0byBtYWtlIHN1cmUgCj4gdGhhdCBubyBt
b3JlIG5ldyBqb2JzIHdpbGwgYmUgc2NoZWR1bGVkIGFmdGVyIHN1c3BlbmQgcHJvY2VzcyBzdGFy
dHMuCkl0IG1heSBhIHJlZHVuZGFuY3ksIHNpbmNlIHNjaGVkdWxlciBtYXliZSBhbHJlYWR5IHN1
c3BlbmQuIEkgY2FuIHJlbW92ZSAKdGhvc2UgaWYgeW91IGFyZSBzdXJlIG5vIHNpZGUgZWZmZWN0
LAoKPiBJJ3ZlIHJlbW92ZWQgYWxsIG9mIHRob3NlIGEgY291cGxlIG9mIHllYXJzIGFnby4KPgo+
IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+ICsKPj4gK8KgwqDCoCBjYW5jZWxfZGVsYXllZF93
b3JrX3N5bmMoJmFkZXYtPnZjbi5pZGxlX3dvcmspOwo+PiDCoCDCoMKgwqDCoMKgIGlmICgoYWRl
di0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKSB8fAo+PiAtwqDCoMKgwqDCoMKg
wqAgUlJFRzMyX1NPQzE1KFZDTiwgMCwgbW1VVkRfU1RBVFVTKSkKPj4gK8KgwqDCoMKgwqDCoMKg
IChhZGV2LT52Y24uY3VyX3N0YXRlICE9IEFNRF9QR19TVEFURV9HQVRFICYmCj4+ICvCoMKgwqDC
oMKgwqDCoMKgIFJSRUczMl9TT0MxNShWQ04sIDAsIG1tVVZEX1NUQVRVUykpKSB7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCB2Y25fdjFfMF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX1BH
X1NUQVRFX0dBVEUpOwo+PiArwqDCoMKgIH0KPj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4g
wqAgfQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
