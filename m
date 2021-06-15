Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB637C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F5F61627
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F5F61627
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DB96E3AC;
	Tue, 15 Jun 2021 15:32:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC726E3AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 15:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6HrSt15Cy4h8j9jBRilAkTHk1fdmdm9yU4Gi2BgkRQ/Llpf/UEUx1fUoQZ0jEaWCBd7qTItdqTH626vNKUkSzmqbFnxiQk2J/J42coHJdQtMD7VMSrsrZTCiX1xeN+HnYlJbL4Wy8MTdCWewVIilnmTnalwjsSTPHpz3HFlUX/eZ6FmI1l63H9fjPQSdYCgn0uexmORYMDrLwJEAGNxijnr3+6TiRWs5mckYIzXuExWLKrKGPbPx65mOX5vEKHJbyT17bWoNdLvHLdeS064cLzJp6Ln7+v6QgKgaARbN0OWup841QQLMoAW9UTGmAVmMLc2Xb9PRfsvbcfn3Y0iXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBwPXetEXKQM6OJElR8Kv2w9i8t9XwbZlvRmlqnziTM=;
 b=AWDkK04wKZZvgKovdm9rDHrZsPiIA21E0eIe3t0hab/mCqjn1ychtDUYvb8BtrPlmxfEDkNTBxk8ZeyWZjhFU/2Xbu2awOBrmu9xxnJ6z+ovrxwrqLeEUP+e/hHlD1Z7Y8v1gH4SqcMuYrZpTbtGjYOmedany4G9iHhnMaijJZlb+gO042bozdA95N1/+HTZSnyE3597Y/ov8ZYjGPPd+WyeLHzJP2XWwvaYLN2BLnKgjs13jLFySc1ri4ZVEH+yjyZZdkyWoqAPNmobGzVSzyU0Zq6yzh+FJ9PLyHVv1HDHohAdM6qEa/R7QLKszkGnwO3VgGrJunbzwgn48kk6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBwPXetEXKQM6OJElR8Kv2w9i8t9XwbZlvRmlqnziTM=;
 b=DlGbwZFkYlqOti5FHzuVBHGZ2Aa4bTEepg3DlN6ntqql5MYGqxsz6mbR0Ee39LvEcGqutsC19TjK7kiO826RniVKfq82lRrSKNu9HbeHo08zo58injJuXmmfNE30SeDEykTzPBPt4+AmQ7VgwsDj6Hx2TECvOf9QL3gWtVbV7i0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 15:32:49 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:32:49 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix a race between queue destroy and process
 termination
To: xinhui pan <xinhui.pan@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210615080233.14596-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8717418e-8036-944d-b688-586655fe9081@amd.com>
Date: Tue, 15 Jun 2021 11:32:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210615080233.14596-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 15 Jun 2021 15:32:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f8dabc6-4545-4f33-78ca-08d93012d4d7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5098F8F0F77B79E3CD1243F992309@BN9PR12MB5098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEniH9yDzw5Bbs2akU4yORNd2p0jxSmwzbTeOWZ6JRMyFzmdLaMHKWVCURD1oZ7Jn4iv/1UkbUKxRA8nQoyui1NRfwiM3oDz38H0bGkIItuKOjrGt6rYzeFW0eY/KF+sPFHJerMOSEyi2Gkc81yo26ZmNgHOtieUnd5jtEMC3b1hoePq01bBDlTuXZzUTHBYNfaMZjoZ1G3aYEFaE0MUoGX0eCPituLLDWqdTrfq8+z1ZpSczceO5jRAHambjDW3XMj5Zhy7lyAxnIYJ7xoeYZ3IBgRJ5+FK5jmWT+CcaWzUQmDFUyrlp5TtdOn7nUq9dcGsDkr2WRVdBt0hapcdBFohqrzIAaS69QiOUHI7SQZ8/C7dQe9CH2+IevK8jDmFHuxrPRksjYZJp5TjJFALPnkzXJipnw/HzYyydA3vMGlCRGN/L7DCZ4bRhqb0fzWaOImjiBkJ9cIJJch37KyuS39B6UFVptmXpB8y0ANv5aNx6MNM93zQ+P2vv8FHyi4sDBuZv10blljhIIUt5zkuNAFdXeeXsKNjDHDacbHhEpQQITCOXaM+E8Ala8UOUD9xxl/nnQriqdFY8GZywelrPHK2m+8lQ03JMPg+McA2tTMA+T2Zl+CaFUxn+HYEWjr0CsQbWB1GSlTpJrZj6SBvW4LGW2dWfUGNagnAjx2j6b1R+/xwtJE6qROf0upYrFt7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(44832011)(956004)(8936002)(16576012)(110136005)(83380400001)(2906002)(2616005)(36756003)(8676002)(86362001)(66476007)(66946007)(66556008)(38100700002)(31696002)(186003)(498600001)(5660300002)(6486002)(26005)(31686004)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZacEI3OS9zTnlWenR4S3E4alZVcGpwcXVwQjE4Wmw5a25CcUhjckZsUUw2?=
 =?utf-8?B?Wjh5QVRKb0ZJRUVQR1Q4UnowTXQ1ekVsMWJXYnkzajdwYU1ubm01UFNVYnp0?=
 =?utf-8?B?YWpsTWZDMzRKa0NVTkdGNWt5VGoxcWk4UGs2SVBIVk1QSTFINzZqeTVSK1RR?=
 =?utf-8?B?MG1Bd3RwL0E1T0k0dDJJRVhiZytFZjBzTTBtY2tMVlg0eHEzNE5kM29Kbjdk?=
 =?utf-8?B?N3NuYWZCMGo3a21MY0pjYUdITTh3TE9Ecm0yWVkyWXU1SzVPUjlUK0pVTUtU?=
 =?utf-8?B?SEFJVlluMFcrWDJWeDYrS2NFU05XOTNtRXFSS1pwTUJOWUdKWVVKMmxUZEY1?=
 =?utf-8?B?anJoZ0xZeU9iUEtLZ25aLzNNZWNjYTE4NWkrR3crY0FGcjZOcTVkWi9QeEZL?=
 =?utf-8?B?dUpuR2o1Z0lnaFp0TEg1WFpsaTl0SGdFZXBZdk01Nm50dHJka2krVXJtU2g2?=
 =?utf-8?B?bFRLellENWIwQjRMcThHbFBLeU1lS3pPZkJ1WVNNeEhBZkJUOFRXWEdDVlV0?=
 =?utf-8?B?N2N2em9oUm1adUY5SjZFckpCSm9NaWMyS0ZjVStlRTFqKy9WUGc4NXFhT1VC?=
 =?utf-8?B?Z0JsT1phcmZZZmVBV0pFN2lUamp5Q2QwRzBwUHRKRGczY1BsekI1ZHJyam5H?=
 =?utf-8?B?aUdCaVN1bGhrcEFnUEs5TlJHRTUxMlB3dUVmYmRuc0ZFS3ZSTHFhVVNNcnFk?=
 =?utf-8?B?WWpOZkpyZTlXSVV5bUJrbmMzRFJoQXJnbWcranN4b1ZEeUdMcmhyZnN2Tjc5?=
 =?utf-8?B?V3ZUcitCK201c3RPUld5akNFSmFHUUU0Y1ZZUjFEY3FrVmlobE93WmtTVDZB?=
 =?utf-8?B?UVNGZWsyQUswNUhodStpNURGYTdRaWtxU2hrRXJwNFU4RUZLaVFTdSt6SmhJ?=
 =?utf-8?B?Wk9mQU5BU0VsM1VsaktjZ2tjd2lGempQYnJMeDdVcHYybk9YZ2Fya3JyQkIr?=
 =?utf-8?B?OXJCSkFJeUNla2NxNGE3WkEwNDdMdDdGOGtLaEpTU1RQTGFKb0RwbzVMTzI1?=
 =?utf-8?B?UktRUzBEVHhuSmRFRWlBY0ljWFVQVVJiaFczWWZGTUVvcHRXazh4UlpCcEFZ?=
 =?utf-8?B?Q0pPcHdkRWpLV21oYW1mYWlpemVySTlPTk8wU0M2dHMyNHVFa0VzWVJFaGk3?=
 =?utf-8?B?eWY4UUp5TEUwVFdPZ2F2Z3RnVHc5bUdKS25ETGlheVE3TWZNZ2krSFI3elhK?=
 =?utf-8?B?TnNrM2VlUUtFU05TWjVWekxYc21QZVhmNU45c2NWTHlURXlWTzEyTjNGbFVC?=
 =?utf-8?B?eDFQZzdMbTR3aUZTdkxoQXBNQ2hqaHRNZGV5VForY2laNXVaWTJPSXFMSzls?=
 =?utf-8?B?TFBjcVZDOFdpUHlqeTdMSWZSczhyeUU1UjJlTDcxSmZqSHB4VUZTN1QzZjlr?=
 =?utf-8?B?cWlZNXRqa1ZxS1VRRDZvdTVpN0JRK3JRQmIzbTJSeWVyWkNSYy9ZU3lNUE15?=
 =?utf-8?B?N1kyaWRaVWFkMUJxL1BaZ2RyLzh1SUVyT3ZVdkEyZ1UxL3FQYWU5d1RVWGJE?=
 =?utf-8?B?S0ZXZ3BMaGFFL3c3RytJeEo3bUl4NWtVUFdJWnhjSkIrQTJNRTRrZVhNdXhx?=
 =?utf-8?B?b2RaeXJSemJkY2VCZWFhY3hCSC81YWdDZ3kyNEE2NzNsaVV6cDdCa04rQlU4?=
 =?utf-8?B?aTI2N0JrVGp5NytJaE9zY3FOTFA2YnYrSkVhWUtkVTZ0WnNOTG5pc3YrT3Bn?=
 =?utf-8?B?a2UyTUJJUDFiVk9uYVkxbTdlYnFQbnhJVmdGWmpUdmM3c0hwUWJuMXlIV1JB?=
 =?utf-8?Q?DW+OrGUfK6Ok+kGFHwzzoGgmP2RxV0aeInTQXmY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8dabc6-4545-4f33-78ca-08d93012d4d7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:32:48.9286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HKq9sLaLv+nAZK2RBiM3Nc8YttGO2EqH6rTcjcpI6xgcCpWdIaFus0UwUFLzmlIX5aj26cnIbyoC6/b7zda4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WytBbWJlciwgbW92aW5nIGFtZC1nZnggdG8gQkNDXQoKQW1iZXIgd29ya2VkIG9uIGEgcmVsYXRl
ZCBwcm9ibGVtIG9uIGFuIE5QSSBicmFuY2ggcmVjZW50bHkgaW4gdGhlCm5vY3BzY2ggdmVyc2lv
biBvZiB0aGlzIGNvZGUuIFdlIHNob3VsZCBwb3J0IHRoYXQgZml4IHRvCmFtZC1zdGFnaW5nLWRy
bS1uZXh0LiBUaGVuIGxldHMgY29tZSB1cCB3aXRoIGEgY29tbW9uIHNvbHV0aW9uIGZvciB0aGXC
oApjcHNjaCBjb2RlIHBhdGggYXMgd2VsbC4KClNlZSBvbmUgY29tbWVudCBpbmxpbmUuCgoKQW0g
MjAyMS0wNi0xNSB1bSA0OjAyIGEubS4gc2NocmllYiB4aW5odWkgcGFuOgo+IFdlIGNhbGwgZnJl
ZV9tcWQgd2l0aG91dCBkcW0gbG9jayBob2xkLCB0aGF0IGNhdXNlcyBkb3VibGUgZnJlZSBvZgo+
IG1xZF9tZW1fb2JqLiBGaXggaXQgYnkgdXNpbmcgYSB0bXAgcG9pbnRlci4KPiBXZSBuZWVkIHdh
bGsgdGhyb3VnaCB0aGUgcXVldWVzX2xpc3Qgd2l0aCBkcW0gbG9jayBob2xkLiBPdGhlcndpc2Ug
aGl0Cj4gbGlzdCBjb3JydXB0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGlu
aHVpLnBhbkBhbWQuY29tPgo+IC0tLQo+ICAuLi4vZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9x
dWV1ZV9tYW5hZ2VyLmMgICB8IDE3ICsrKysrKysrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiBpbmRleCBl
NjM2NmI0MDg0MjAuLjU3NWM4OTVmYzI0MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gQEAgLTE0ODQsNiAr
MTQ4NCw3IEBAIHN0YXRpYyBpbnQgZGVzdHJveV9xdWV1ZV9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1
ZXVlX21hbmFnZXIgKmRxbSwKPiAgCXN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21ncjsKPiAgCXVp
bnQ2NF90IHNkbWFfdmFsID0gMDsKPiAgCXN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCA9
IHFwZF90b19wZGQocXBkKTsKPiArCXZvaWQgKnB0ciA9IE5VTEw7Cj4gIAo+ICAJLyogR2V0IHRo
ZSBTRE1BIHF1ZXVlIHN0YXRzICovCj4gIAlpZiAoKHEtPnByb3BlcnRpZXMudHlwZSA9PSBLRkRf
UVVFVUVfVFlQRV9TRE1BKSB8fAo+IEBAIC0xNTQzLDEwICsxNTQ0LDEyIEBAIHN0YXRpYyBpbnQg
ZGVzdHJveV9xdWV1ZV9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwKPiAg
CXByX2RlYnVnKCJUb3RhbCBvZiAlZCBxdWV1ZXMgYXJlIGFjY291bnRhYmxlIHNvIGZhclxuIiwK
PiAgCQkJZHFtLT50b3RhbF9xdWV1ZV9jb3VudCk7Cj4gIAo+ICsJc3dhcChwdHIsIHEtPm1xZF9t
ZW1fb2JqKTsKPiAgCWRxbV91bmxvY2soZHFtKTsKPiAgCj4gIAkvKiBEbyBmcmVlX21xZCBhZnRl
ciBkcW1fdW5sb2NrKGRxbSkgdG8gYXZvaWQgY2lyY3VsYXIgbG9ja2luZyAqLwo+IC0JbXFkX21n
ci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5tcWRfbWVtX29iaik7Cj4gKwlpZiAocHRy
KQo+ICsJCW1xZF9tZ3ItPmZyZWVfbXFkKG1xZF9tZ3IsIHEtPm1xZCwgcHRyKTsKPiAgCj4gIAly
ZXR1cm4gcmV0dmFsOwo+ICAKPiBAQCAtMTcwOSw2ICsxNzEyLDcgQEAgc3RhdGljIGludCBwcm9j
ZXNzX3Rlcm1pbmF0aW9uX2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAo+
ICAJZW51bSBrZmRfdW5tYXBfcXVldWVzX2ZpbHRlciBmaWx0ZXIgPQo+ICAJCUtGRF9VTk1BUF9R
VUVVRVNfRklMVEVSX0RZTkFNSUNfUVVFVUVTOwo+ICAJYm9vbCBmb3VuZCA9IGZhbHNlOwo+ICsJ
dm9pZCAqcHRyID0gTlVMTDsKPiAgCj4gIAlyZXR2YWwgPSAwOwo+ICAKPiBAQCAtMTczNyw4ICsx
NzQxLDYgQEAgc3RhdGljIGludCBwcm9jZXNzX3Rlcm1pbmF0aW9uX2Nwc2NoKHN0cnVjdCBkZXZp
Y2VfcXVldWVfbWFuYWdlciAqZHFtLAo+ICAJCQkJcXBkLT5tYXBwZWRfZ3dzX3F1ZXVlID0gZmFs
c2U7Cj4gIAkJCX0KPiAgCQl9Cj4gLQo+IC0JCWRxbS0+dG90YWxfcXVldWVfY291bnQtLTsKPiAg
CX0KPiAgCj4gIAkvKiBVbnJlZ2lzdGVyIHByb2Nlc3MgKi8KPiBAQCAtMTc3MCwxMyArMTc3Miwy
MCBAQCBzdGF0aWMgaW50IHByb2Nlc3NfdGVybWluYXRpb25fY3BzY2goc3RydWN0IGRldmljZV9x
dWV1ZV9tYW5hZ2VyICpkcW0sCj4gIAkvKiBMYXN0bHksIGZyZWUgbXFkIHJlc291cmNlcy4KPiAg
CSAqIERvIGZyZWVfbXFkKCkgYWZ0ZXIgZHFtX3VubG9jayB0byBhdm9pZCBjaXJjdWxhciBsb2Nr
aW5nLgo+ICAJICovCj4gKwlkcW1fbG9jayhkcW0pOwo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKHEsIG5leHQsICZxcGQtPnF1ZXVlc19saXN0LCBsaXN0KSB7Cj4gIAkJbXFkX21nciA9IGRx
bS0+bXFkX21ncnNbZ2V0X21xZF90eXBlX2Zyb21fcXVldWVfdHlwZSgKPiAgCQkJCXEtPnByb3Bl
cnRpZXMudHlwZSldOwo+ICAJCWxpc3RfZGVsKCZxLT5saXN0KTsKPiAgCQlxcGQtPnF1ZXVlX2Nv
dW50LS07Cj4gLQkJbXFkX21nci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5tcWRfbWVt
X29iaik7Cj4gKwkJZHFtLT50b3RhbF9xdWV1ZV9jb3VudC0tOwo+ICsJCXN3YXAocHRyLCBxLT5t
cWRfbWVtX29iaik7Cj4gKwkJZHFtX3VubG9jayhkcW0pOwoKVGhpcyBzdGlsbCByaXNrcyBsaXN0
IGNvcnJ1cHRpb24gYmVjYXVzZSB0aGUgbGlzdCBjYW4gYmUgbW9kaWZpZWQgd2hpbGUKdGhlIGxv
Y2sgaXMgZHJvcHBlZC4gSG93ZXZlciB5b3UgY2FuIG1ha2UgaXQgc2FmZSBieSBjaGFuZ2luZyB0
aGUgbG9vcAp0byBzb21ldGhpbmcgbGlrZQoKCWRxbV9sb2NrKGRxbSk7Cgl3aGlsZSAoIWxpc3Rf
ZW1wdHkoLi4uKSkgewoJCXEgPSBsaXN0X2ZpcnN0X2VudHJ5KC4uLik7CgkJZHFtX3VubG9jayhk
cW0pOwoJCS4uLgoJCW1xZF9tZ3ItPmZyZWVfbXFkKC4uLik7CgkJLi4uCgkJZHFtX2xvY2soZHFt
KTsKCX0KCWRxbV91bmxvY2soKTsKClJlZ2FyZHMsCsKgIEZlbGl4CgoKPiArCQlpZiAocHRyKQo+
ICsJCQltcWRfbWdyLT5mcmVlX21xZChtcWRfbWdyLCBxLT5tcWQsIHB0cik7Cj4gKwkJZHFtX2xv
Y2soZHFtKTsKPiAgCX0KPiArCWRxbV91bmxvY2soZHFtKTsKPiAgCj4gIAlyZXR1cm4gcmV0dmFs
Owo+ICB9Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
