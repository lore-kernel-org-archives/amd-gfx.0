Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CEC48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 18:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD31613CC
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 18:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD31613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439A36E16D;
	Tue, 15 Jun 2021 18:22:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2204F6E16D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 18:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdLR3N8DA4T/XJLVTAwA736FXz3pg9GrbSNzLamUivfR4YarW44fZ7+8E5id0G3V/t+4LqXB0MiemJCWiMsbXjvBaohKvQzmB584/DxbsYkDgXSe3jLtyDrH3pBSy8JG3wco0kU4hVvod8aIA1B6gYkXNZFHy4VTnZmJ9nwykBXhv3QfE4tJE73O0Nrx50O+RbKuBgFSCTvQwLRLirOH+AbWZSdIhXBOjT17BEJSgNtOSf4MVg+FSQ8mZz3XZy2p/kO5ZeEnavBETW69NCYhF6ZfqPdp3QvPj8pUKQ6zF+BYMixTc29ME85wao5Ht7QwjN8lgHnyQl/j+p+QEJh2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5JG5NH4AwwJorbzI/+s++AgIO1hhlMfIhjZGXhQQpw=;
 b=QfdOG0WoBX2gRVFOvSmMOR9/0hmJUaKr9ZTMAv8/DG2FSXUkjpWSQa4B10YhhtWr9+o6/dxHA0w/ytIuFtE0upgoEIjBX/TApGfV0qSt7i4nOMjmATl/M3TMhM/38jxCMEY/xV9ia/YDXqn/T83yWMix9VgahdsoeZexCYo892fWbgiAXsWcfCQMRRpPxjQYEd3rWJe5ZHdEo5eWj2VpFW1pqf3kMNkETeyjfFVlAYlMO6z4mRqDMFQhhihp7ZhwJfSFbB71HUBlkXF9lNmedM6BhAStdbQMY6HXcsdpjBQKsvH3v4vSy3JsG3G0ZU6I5RwwMm9oUk23BZdWOpA9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5JG5NH4AwwJorbzI/+s++AgIO1hhlMfIhjZGXhQQpw=;
 b=rA5bIDr/K4VdF/uyFIUhtPClFR3Xht6s6awVjBFv8+dMidn8igXqIi+4nYXV57s4luLp0Owgjpb4bfIj0JFrGL9+EvfrfkgOBiPcXvEZVgqEGeROwXbyipjaDRnYIqlyFdlLqJFiTbTms30EGONxHMoBJPVFRFhW/mxcNgXirE8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 18:22:22 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 18:22:22 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix circular lock in nocpsch path
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20210615175049.18382-1-Amber.Lin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a933d395-621b-52ab-da31-9e8de8525772@amd.com>
Date: Tue, 15 Jun 2021 14:22:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210615175049.18382-1-Amber.Lin@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 18:22:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9524e2-6bb7-47e9-3fc1-08d9302a846c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5129202B5C7D63B4FB6994A192309@BN9PR12MB5129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQptOedYTRUa58pYu2PPYpn+uSFLUWmyjztikMF/ZEIamDIBv8JhQY8JkFqRlS7GNlQYLlixbMgJ9lW1x5I74WfxuCM3Dpx7Twc7PEZbTJSgZMjssRhg/Id79eerZYtSjjmGxdP/YN7tVOObBSJ5yBRibPeo1FUgOQbb37b+UimnUNwOeNKXew4gQlIuKkLhjBS62Y/TDk63KlxUp0IBPi7e66gmRqGcQVpfXEeWtV+lwYHKK6goJW+iQUo7piSTMmavJ3ywEdX/Tr9A6M1x+YVLlbXYEEuUZRoRn7MOdkmN6k8+JKgTD9e+2ecmiTNpV3xvpvWwbQ5SA6SsS2XTV/yNeRbjUjbSNr5kJDEZGtjbawOijAbzgK/F+zFD22mi708zXekOVWfDVzgd86kImlLhew5nigX9TFR3yLHyRZAzv6GV81nsNcJrmaGt51NmzXi5u1/M6SmPa8dItYDKjWGprC9HIB8we5W67g3r7SMUKOaq+lw56jpp9LbJAk1QQSlg/D43BDN7WGDxuHz8ZskSLw8zeVy0iqUxVPerFD5UNZrgJ4JCe46rHV/m30K7OvFAeedpJENviPmji0z6Ga13FlIl+Tv5ihmgKs5gbL9el59oxHBv0rGMBScUpVFva7rJAdx8W4DQ9A1voG6zS2Db81DAUVkDnJfTkxKkDDyst3NI6NCmtPvMC0CrL0LH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(2906002)(31686004)(186003)(16526019)(478600001)(6486002)(8936002)(8676002)(86362001)(26005)(2616005)(66556008)(38100700002)(36756003)(956004)(44832011)(31696002)(83380400001)(66476007)(6636002)(316002)(5660300002)(66946007)(16576012)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNIOGI0WEJEY3JHT0RQdFFRbjByUnBadDRwaW1tbU9xSjNJTnpBamZRQTdH?=
 =?utf-8?B?V3NJS2RBSWlhS1pXbmM0aG9HMEtxUjh3RnptT0ZSbWxobFlQRmV6WVpVSGVR?=
 =?utf-8?B?SEJrTjRmSk16K09lZDd1VXFVNXBuWVFIVWpoREk5KzVzWWNML2tRd3ZmMC9N?=
 =?utf-8?B?eElNd0NjaS9BQkZsdWRDa2tPN1BYaGl2VGtHMDlTUVA1cTRqUVJ6TjNZT3N2?=
 =?utf-8?B?SFRldXg1SjhoUFgzYmR5aTZTNnZXOXdzV1l4U1U0N0wzQzl0MnZMUmExTUcz?=
 =?utf-8?B?QldnUlMwOVBVN3Ruendqbmp4K1lxaWJkR29Wa2lDb2NISDJhZlNNRmxkNTFu?=
 =?utf-8?B?bXlsajZlYVQzblVCamNRZW1EditoWDIxUVRjbERpNDRkejJNTTJIdThlNk9F?=
 =?utf-8?B?SEJMdHNqRmpVWEFxdDJHMEJ2RFUvR0FWTXViUXdaV0x3OTl3N012T2VWa0wz?=
 =?utf-8?B?S0ZqS3p4cERQQTBiNUNXNUxMbG9odjJndmNYNnEyUjRqVDd3THNCdTBIT1l6?=
 =?utf-8?B?V0xla1ZxRU5RVlljQW96NzZucWd0SVB6M3huMHI1NnJFMzBEa3p2SjZmWHFX?=
 =?utf-8?B?U0xTaCtaMWQ5RkdjZUt5TjllaGRoQU15QjYvbGZ5ejR4ZWpRVjAzcjJKOC9W?=
 =?utf-8?B?ejBLZng4dnorZUdzSnRkSGVENnR3OHBtQjRSSUF5QUQwcE5oTUxFaU1vQzJC?=
 =?utf-8?B?dnk3NHZiY1hwSVNtSXdTSTFlMHg0MEdpem4rcE1pd3JTRHEvcEtLdEpvQ1B2?=
 =?utf-8?B?c0I4ajJIYmhkZVFQeDdZS3NNdHVCRy9nbXdtb3l1cllFY3FhZjhyL0JzSHZ6?=
 =?utf-8?B?MXMzNTdhOFkrWUt1OXE0aGFFREdkdURVNi9SSnRPUGlUQnpSdEI5QTF0ZVha?=
 =?utf-8?B?TWU1eUtjS2wvK3NnK2NZekw2blVvT0pZRFhsQ1NzUDA5ZHNSL3ZmTkJaL21C?=
 =?utf-8?B?WWErRzJTWWw3bG53cDNWSStDVDlVQ3FTZ0duYXhma1ltR1VuR0h5b2s4Kzhy?=
 =?utf-8?B?RkUrWVdaQXU5RjQ1cnVMQlZBdHNZM2dOMDVUN3g4WDNPU1VnOE9Lckt0SDdO?=
 =?utf-8?B?STJsRWxwZE1uaG9Idk5DeVM3bGJ3M05GMG8wdk8wblJadzZFejAyQ0gySlVP?=
 =?utf-8?B?QTBrWExjK1Nxa2Y4djdQMVgrTnJWT3JoR1JvVDYrbzVOTmc0TW9HcVFxMkQz?=
 =?utf-8?B?bzM2V3A3VG1Xc2NucE9BNjFXUkxRaXR5aUNaamlNN2RCQzlNN1VYME95NUlr?=
 =?utf-8?B?SFA0UUlDa0hLdmN0NGZDQS9pbHJyV1ZrWTd4UXdDVXkvcS9qV3hWSFNtWk9v?=
 =?utf-8?B?SjEyOHdGcDZVRUg4Z3l5YmZMekRzWlZabVpSU1VNbnoyMTh6SGM4TmpsZzQv?=
 =?utf-8?B?ckt1U3E5dUdhZlUwNXgvSko3TERBOXF0WXZLZFdDNVM0U0MrMURjd1Fqd2Z4?=
 =?utf-8?B?TzZpVGRwTURqbTZFSXQ4M1pwdGpYVDZpY3d4ZktBMEFxYlVFNWFCL3ZiUTRs?=
 =?utf-8?B?ZlJjbFhXZ242NjgrYTBYSTlPTGk4Q0lYNXJlcm41MzN1ei9mQmIwenZZU3hk?=
 =?utf-8?B?TEJLdlJBMWxTaTJabUpPR3lwaVBIdGVlak03WGZhZm5DcVhXV3JlREZlUGlz?=
 =?utf-8?B?TEJtWG5sa05uTWRRRlQzRkVlTStTTkRSSlRiL0RqTUdZVDZOSXN3U2tNQ1Iw?=
 =?utf-8?B?UlhKcTRzSUY0T2thN1RjWERJZmd5K1VZV202VmhaN0tmM0c3Wk41bmxZY2t5?=
 =?utf-8?Q?cFgN3K0Gw5OldZSQlZct5dwoaggsyRmJ5wNWEFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9524e2-6bb7-47e9-3fc1-08d9302a846c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 18:22:22.0013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG8ZsW3aaBKiCGIAJJFV899TH7v6AO/fD2rrrm3iNiSWSr9HIJlUkfHxulrOVqVU6a5e4Xi2IajqQai01iCfzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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

WytYaW5odWldCgoKQW0gMjAyMS0wNi0xNSB1bSAxOjUwIHAubS4gc2NocmllYiBBbWJlciBMaW46
Cj4gQ2FsbGluZyBmcmVlX21xZCBpbnNpZGUgb2YgZGVzdHJveV9xdWV1ZV9ub2Nwc2NoX2xvY2tl
ZCBjYW4gY2F1c2UgYQo+IGNpcmN1bGFyIGxvY2suIGRlc3Ryb3lfcXVldWVfbm9jcHNjaF9sb2Nr
ZWQgaXMgY2FsbGVkIHVuZGVyIGEgRFFNIGxvY2ssCj4gd2hpY2ggaXMgdGFrZW4gaW4gTU1VIG5v
dGlmaWVycywgcG90ZW50aWFsbHkgaW4gRlMgcmVjbGFpbSBjb250ZXh0Lgo+IFRha2luZyBhbm90
aGVyIGxvY2ssIHdoaWNoIGlzIEJPIHJlc2VydmF0aW9uIGxvY2sgZnJvbSBmcmVlX21xZCwgd2hp
bGUKPiBjYXVzaW5nIGFuIEZTIHJlY2xhaW0gaW5zaWRlIHRoZSBEUU0gbG9jayBjcmVhdGVzIGEg
cHJvYmxlbWF0aWMgY2lyY3VsYXIKPiBsb2NrIGRlcGVuZGVuY3kuIFRoZXJlZm9yZSBtb3ZlIGZy
ZWVfbXFkIG91dCBvZgo+IGRlc3Ryb3lfcXVldWVfbm9jcHNjaF9sb2NrZWQgYW5kIGNhbGwgaXQg
YWZ0ZXIgdW5sb2NraW5nIERRTS4KPgo+IFNpZ25lZC1vZmYtYnk6IEFtYmVyIExpbiA8QW1iZXIu
TGluQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPgoKTGV0J3Mgc3VibWl0IHRoaXMgcGF0Y2ggYXMgaXMuIEknbSBtYWtpbmcgc29t
ZSBjb21tZW50cyBpbmxpbmUgZm9yCnRoaW5ncyB0aGF0IFhpbmh1aSBjYW4gYWRkcmVzcyBpbiBo
aXMgcmFjZSBjb25kaXRpb24gcGF0Y2guCgoKPiAtLS0KPiAgLi4uL2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jICB8IDE4ICsrKysrKysrKysrKystLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5j
Cj4gaW5kZXggNzJiZWE1Mjc4YWRkLi5jMDY5ZmEyNTliMzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+IEBA
IC00ODYsOSArNDg2LDYgQEAgc3RhdGljIGludCBkZXN0cm95X3F1ZXVlX25vY3BzY2hfbG9ja2Vk
KHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAo+ICAJaWYgKHJldHZhbCA9PSAtRVRJ
TUUpCj4gIAkJcXBkLT5yZXNldF93YXZlZnJvbnRzID0gdHJ1ZTsKPiAgCj4gLQo+IC0JbXFkX21n
ci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5tcWRfbWVtX29iaik7Cj4gLQo+ICAJbGlz
dF9kZWwoJnEtPmxpc3QpOwo+ICAJaWYgKGxpc3RfZW1wdHkoJnFwZC0+cXVldWVzX2xpc3QpKSB7
Cj4gIAkJaWYgKHFwZC0+cmVzZXRfd2F2ZWZyb250cykgewo+IEBAIC01MjMsNiArNTIwLDggQEAg
c3RhdGljIGludCBkZXN0cm95X3F1ZXVlX25vY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5h
Z2VyICpkcW0sCj4gIAlpbnQgcmV0dmFsOwo+ICAJdWludDY0X3Qgc2RtYV92YWwgPSAwOwo+ICAJ
c3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkID0gcXBkX3RvX3BkZChxcGQpOwo+ICsJc3Ry
dWN0IG1xZF9tYW5hZ2VyICptcWRfbWdyID0KPiArCQlkcW0tPm1xZF9tZ3JzW2dldF9tcWRfdHlw
ZV9mcm9tX3F1ZXVlX3R5cGUocS0+cHJvcGVydGllcy50eXBlKV07Cj4gIAo+ICAJLyogR2V0IHRo
ZSBTRE1BIHF1ZXVlIHN0YXRzICovCj4gIAlpZiAoKHEtPnByb3BlcnRpZXMudHlwZSA9PSBLRkRf
UVVFVUVfVFlQRV9TRE1BKSB8fAo+IEBAIC01NDAsNiArNTM5LDggQEAgc3RhdGljIGludCBkZXN0
cm95X3F1ZXVlX25vY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4gIAkJ
cGRkLT5zZG1hX3Bhc3RfYWN0aXZpdHlfY291bnRlciArPSBzZG1hX3ZhbDsKPiAgCWRxbV91bmxv
Y2soZHFtKTsKPiAgCj4gKwltcWRfbWdyLT5mcmVlX21xZChtcWRfbWdyLCBxLT5tcWQsIHEtPm1x
ZF9tZW1fb2JqKTsKPiArCj4gIAlyZXR1cm4gcmV0dmFsOwo+ICB9Cj4gIAo+IEBAIC0xNjI5LDcg
KzE2MzAsNyBAQCBzdGF0aWMgYm9vbCBzZXRfY2FjaGVfbWVtb3J5X3BvbGljeShzdHJ1Y3QgZGV2
aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwKPiAgc3RhdGljIGludCBwcm9jZXNzX3Rlcm1pbmF0aW9u
X25vY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4gIAkJc3RydWN0IHFj
bV9wcm9jZXNzX2RldmljZSAqcXBkKQo+ICB7Cj4gLQlzdHJ1Y3QgcXVldWUgKnEsICpuZXh0Owo+
ICsJc3RydWN0IHF1ZXVlICpxOwo+ICAJc3RydWN0IGRldmljZV9wcm9jZXNzX25vZGUgKmN1ciwg
Km5leHRfZHBuOwo+ICAJaW50IHJldHZhbCA9IDA7Cj4gIAlib29sIGZvdW5kID0gZmFsc2U7Cj4g
QEAgLTE2MzcsMTIgKzE2MzgsMTkgQEAgc3RhdGljIGludCBwcm9jZXNzX3Rlcm1pbmF0aW9uX25v
Y3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4gIAlkcW1fbG9jayhkcW0p
Owo+ICAKPiAgCS8qIENsZWFyIGFsbCB1c2VyIG1vZGUgcXVldWVzICovCj4gLQlsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmUocSwgbmV4dCwgJnFwZC0+cXVldWVzX2xpc3QsIGxpc3QpIHsKPiArCXdo
aWxlICghbGlzdF9lbXB0eSgmcXBkLT5xdWV1ZXNfbGlzdCkpIHsKPiArCQlzdHJ1Y3QgbXFkX21h
bmFnZXIgKm1xZF9tZ3I7Cj4gIAkJaW50IHJldDsKPiAgCj4gKwkJcSA9IGxpc3RfZmlyc3RfZW50
cnkoJnFwZC0+cXVldWVzX2xpc3QsIHN0cnVjdCBxdWV1ZSwgbGlzdCk7Cj4gKwkJbXFkX21nciA9
IGRxbS0+bXFkX21ncnNbZ2V0X21xZF90eXBlX2Zyb21fcXVldWVfdHlwZSgKPiArCQkJCXEtPnBy
b3BlcnRpZXMudHlwZSldOwo+ICAJCXJldCA9IGRlc3Ryb3lfcXVldWVfbm9jcHNjaF9sb2NrZWQo
ZHFtLCBxcGQsIHEpOwo+ICAJCWlmIChyZXQpCj4gIAkJCXJldHZhbCA9IHJldDsKPiArCQlkcW1f
dW5sb2NrKGRxbSk7Cj4gKwkJbXFkX21nci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5t
cWRfbWVtX29iaik7Cj4gKwkJZHFtX2xvY2soZHFtKTsKClRoaXMgaXMgdGhlIGNvcnJlY3Qgd2F5
IHRvIGNsZWFuIHVwIHRoZSBsaXN0IHdoZW4gZHJvcHBpbmcgdGhlIGRxbS1sb2NrCmluIHRoZSBt
aWRkbGUuIFhpbmh1aSwgeW91IGNhbiB1c2UgdGhlIHNhbWUgbWV0aG9kIGluCnByb2Nlc3NfdGVy
bWluYXRpb25fY3BzY2guCgpJIGJlbGlldmUgdGhlIHN3YXBwaW5nIG9mIHRoZSBxLT5tcWQgd2l0
aCBhIHRlbXBvcmFyeSB2YXJpYWJsZSBpcyBub3QKbmVlZGVkLiBXaGVuIGZyZWVfbXFkIGlzIGNh
bGxlZCwgdGhlIHF1ZXVlIGlzIG5vIGxvbmdlciBvbiB0aGUKcXBkLT5xdWV1ZXNfbGlzdCwgc28g
ZGVzdHJveV9xdWV1ZSBjYW5ub3QgcmFjZSB3aXRoIGl0LiBJZiB3ZSBlbnN1cmUKdGhhdCBxdWV1
ZXMgYXJlIGFsd2F5cyByZW1vdmVkIGZyb20gdGhlIGxpc3QgYmVmb3JlIGNhbGxpbmcgZnJlZV9t
cWQsCmFuZCB0aGF0IGxpc3QtcmVtb3ZhbCBoYXBwZW5zIHVuZGVyIHRoZSBkcW1fbG9jaywgdGhl
biB0aGVyZSBzaG91bGQgYmUKbm8gcmlzayBvZiBhIHJhY2UgY29uZGl0aW9uIHRoYXQgY2F1c2Vz
IGEgZG91YmxlLWZyZWUuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4gIAl9Cj4gIAo+ICAJLyogVW5y
ZWdpc3RlciBwcm9jZXNzICovCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
