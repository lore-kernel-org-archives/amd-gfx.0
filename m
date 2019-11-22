Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9169C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 18:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6442067D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 18:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6442067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1426F549;
	Fri, 22 Nov 2019 18:15:26 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6E56F547
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 18:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcPizRzSVQjAO7zS+ByQabP9hVAxfW0WMsq2Ob5F5eJFYNxa/fylpBwkH69wBFxGoj/Z9RIfiX8GXMoRzA5iVKLb+pi0dbEHYXI9dVVosZxy8JVX8xo4XFHcsN8HIS1s/KC57Afhc2cjsWlScjkG1/57c2L30U8RP7beCDDteXlCv7NEWJnxhZPL7hOuTpdnFlEMmwpDHG1a7saPGlwLZo0KUCA5fh5remyOq2Y9XRYf6B/c4BjI1CjfP7qfmBVFHTIhSK+R6Parr/U+7EKktDpfAKKe6KsWH+TUFbmrsd3CwN2P4nbLgDBtdJFWsL3n+CfjSgBeK4c3fM/4fBmYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlIGwRsr/Dvyokf4gMGypwF0xsQJKo9y8jxPuzuzMeQ=;
 b=VJylVaLthaVk0xy2iL/MITN3QsOuNWx0xZJ1e8xcHX2KXYBP9r1ifZBuMQWALHlMDPSrNj+Hgy0MF6WG+VmKnt1lAaELhiHAXdArqDWoKBdP02GJDlJ7b0PiXyMo/vKwCsG3mmg3xumWkZMU1wLPhKfvSumiCHwurDFDilPqNKKKoWmgU9kluhD/4eYzEXhdl6DG0UCxbnc5Wq2Z/pJCrQkQvY+KoEXu/USkna2NTVP3mHke32j3wnXjrIWNq3vlsKZf6kdnlI9gs6I9kO8EGXmSG+DYdI2Z6n1EHvxV0Ssgmtfb9Q9kU0YGybbi14TttkW1A6WOSsbrxW4w8LXwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2683.namprd12.prod.outlook.com (20.176.114.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 22 Nov 2019 18:15:22 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2451.031; Fri, 22 Nov 2019
 18:15:22 +0000
Subject: Re: [PATCH] drm/amdkfd: Remove duplicate functions update_mqd_hiq()
To: "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191121212524.3946-1-Yong.Zhao@amd.com>
 <DM6PR12MB3466B2CDD1F0158C673AD87B9E490@DM6PR12MB3466.namprd12.prod.outlook.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <d9ce3098-7648-f0fc-741c-14b82fe57cc0@amd.com>
Date: Fri, 22 Nov 2019 13:15:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM6PR12MB3466B2CDD1F0158C673AD87B9E490@DM6PR12MB3466.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa1bd33b-b9b1-4e8b-2732-08d76f77f036
X-MS-TrafficTypeDiagnostic: DM6PR12MB2683:|DM6PR12MB2683:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB268360E810FE35A23C7A7C53F0490@DM6PR12MB2683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(13464003)(199004)(189003)(14444005)(110136005)(58126008)(86362001)(6436002)(6246003)(4001150100001)(2501003)(2616005)(44832011)(6116002)(6306002)(229853002)(6512007)(6486002)(186003)(26005)(446003)(3846002)(11346002)(31686004)(31696002)(15650500001)(36756003)(14454004)(230700001)(8936002)(66556008)(81156014)(81166006)(66946007)(66476007)(8676002)(2906002)(25786009)(99286004)(386003)(6506007)(47776003)(53546011)(316002)(305945005)(45080400002)(52116002)(23676004)(2486003)(66066001)(65956001)(65806001)(478600001)(50466002)(76176011)(7736002)(5660300002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2683;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enRxbk4zYk0wUitMU2pqY3dqNXBlbHVpc0htVVRPeDV5bnFTV3RUL0NkM05P?=
 =?utf-8?B?MHgyN3F0N2p6UkoxMU5RV2Jaa3RoYWpUOWNscDNzbEtMdS9lK1hOOEhneUx5?=
 =?utf-8?B?QXVObUIxQU5zRGgzYmdDdlpKU1VsS0VFMXdqY0pMK1g0TnJZeDg0VWtIQlht?=
 =?utf-8?B?NmlQQktNMGxVZUtDaFdIaGo4dXBoMDFmSkZxd1YxZjJpVmgzVTZVL2JSc3Vv?=
 =?utf-8?B?RDRPNTRzVGVKLzAwbTA3REZMRWtINXkyNlp3YisvL2ZHVDdJRjJpVlQ1M0d6?=
 =?utf-8?B?SWRIaXhWTFhnNUpkaUFLa2E0REdFRzZhbTJCVTZORUhSRC9rNTJNemNIL0RV?=
 =?utf-8?B?Tk9sdDBFeWROV05WSjdCMkhPeVZvZkV1TDJHaTNrQnhROU5OK3YvcFZKd0l2?=
 =?utf-8?B?Q3pld1doWjdJcndrbHU4U0lISTkxVXpGa3BrUnJZeGpnMDBzM1JHWjhHYVBj?=
 =?utf-8?B?QjN6N3R0R01DRGV3bU9KVUFzU0lTL2Y0QlM3b3dKc2VBYVp2NkpiekU0c2kz?=
 =?utf-8?B?WDVTU0p5ZGVraHpKSnZLZWJjcmdnaE1iRXQwcXZ2cVdGa3Y1SlhWcm45czVj?=
 =?utf-8?B?TjltV3JDWTJKRHhyckd1YmhrSGpDSkdCYWVkQWlBc2h0VDFwSkxhdGo4RGxW?=
 =?utf-8?B?U21KU2ZyN28wSHVCUW1qaTZjOGU0TTRrR292QlFvdmQ5OGxaK3dhM0VGRXE4?=
 =?utf-8?B?amZaTVZXcHBldmZRdy94QllJTkZLL3JyaVNjZVFnZy9rUzBpbURjMm9ScnlH?=
 =?utf-8?B?eVp5c29GNkJGaWFPTG0yZ1V4ekdabC9vd0RGalpiakJja245NW9zRUpoQkxL?=
 =?utf-8?B?MncwSWRMcXNnN2RmZ2pTS1pVaDluMXhmQ2c2VURqSWx1QnFrOEtCRWw3NEFG?=
 =?utf-8?B?QVR5WFhZNlp0SFFGWiswWE4rcFBWV2kzb3NQWEZpa3Q0UmVlcFFQSklucUtj?=
 =?utf-8?B?ZWxjSlVQZnJJTW5McVFjcDEzVHVTQ1o5M2dxOE9UZ0NIQVA0aHhDeExERVVu?=
 =?utf-8?B?aWhtd3VqbE1Na1pXc3ZIdUNlQ2l0b21Pa2ExVUZjaFFHNDA3OXRHQmtVdXUr?=
 =?utf-8?B?a3hhSTlYL3dubjVxVTlIRlBJVTEyazV6Qm9zWEhkWVY4bm15bXVIT0xOa3JD?=
 =?utf-8?B?blgyMXBVVXJsOFVldjVNWTRHOERXeVdERXVwV0c0K0ZqMGdkR0tJYlFxdmlE?=
 =?utf-8?B?cjNuV2hDcEJVWHFSYmxLbWZaQjk3akx3c0lESTlSSlZRemxNcTI1ejREY3V2?=
 =?utf-8?B?UG9hUDBabktOVTJuakdsRG4yUTBSb1dwM2QrZHVMVHZXNzBpT2k4eXR2L3Qr?=
 =?utf-8?B?bVUxUnMxUXh5SlVWUmRxUXBZZW5ZbTlOLzlTb09xenhCTDRPMlM3K0VGWkVD?=
 =?utf-8?B?VGc2R2pHaG1kb1F0QUZXU3ptaHV5bUtQdW4yZmpTTEZmSDZlRis2SEE3am5Y?=
 =?utf-8?B?WktkMUprU0x6VWFqbUx4V1lpcTJ6MXJqY2orNDBNcnFzWEtIVHcybzMzNkFt?=
 =?utf-8?B?MElJSnh4a3VhNFRmZVVyZ0dINXJBME5ONWtuend3M0xPczRWR3N1dUo4VDBn?=
 =?utf-8?B?YkNsR3lXVDY1WlBOZEJZZzlCYi9nUUN6K1o5UkJqdWk4STZvMTZqRlBjZTdp?=
 =?utf-8?B?YTQxS2tqWkFZSjN5UG1NQThMNy9aZWJ5Zi9lUFlodks2SHJJaHUxVUpERjh0?=
 =?utf-8?B?eXZ1eU01endQdTlCTzI2M3FVSDJXcXR5UDcxc25vb0xqU01ySnkrNjY5a3hM?=
 =?utf-8?B?RzN4Zm91aVBxSmlCUHM1VTUrc3Q5R2p1U1hneXJxUTNZNkRNb2hYeTF3dzVz?=
 =?utf-8?B?Zm04TDBhNyswS3JPV2lLbXRVVStKZTcwTzUrT1d2QmxYeEZ3ME9IUDBVOTl3?=
 =?utf-8?B?MDQvbGtiYURwSnd1NGNsT1FpOURrazVNUU9wN3dWTUl6UkJhMGE4bkU3YXA0?=
 =?utf-8?B?eGZINElUdXNWTjdIRmhlZmtnMEFWOHVUd3ZvVmFGUTBZUHNIY2hPUFRRb0Uv?=
 =?utf-8?B?djY2ZHhpWVducGNGNUZ4V3V2M2l0SmpuenpnUVNWQ0FTbjZUNVN0QkkyK05U?=
 =?utf-8?B?Mm5ubGtoRnJ6Y1FDNWRRVDNmdnJ5OEp2NWtHbmdzRnFCN2hqZjluRWFId1U4?=
 =?utf-8?B?WFVWbkpLM1hDNC9jU2k5ZUt3bFBLRXI3Qnk2WlAzQ3BBSmgva25ER25PK3ZR?=
 =?utf-8?B?R0E3cVcvd0txZGRUaE5oYXY5OHF4Z0g5RTFQa2lBV28xdzVhNC9oeUlUTVZx?=
 =?utf-8?B?blZ0MGlZc1gxdUtmYjBQbUZpQXhqTlNoNGhBdzdVdnUxNjRscUlKMVMxaGk4?=
 =?utf-8?B?aXNSNmJMbE9NVUpDQmVUcFlENGtna3hCeUNnMS8xMDRWU1NsT1dXRlVmWnlH?=
 =?utf-8?B?Z2Nmem1ndmV4M0w3WnJpaXZNSjlhRWJpTUNrYkcxMVc0a05lL05WWmhPZjFX?=
 =?utf-8?B?emhrU1pKaWI4VUdJcDEvYnJQam94c3FmTEg0LzZPcUt1RHdsWjg2bDRHeDdr?=
 =?utf-8?B?T2VseWNvWUNPNFd4SWNuYlZQeTZwajkxQ1Z2SGtsMitHN1Z4d1VoaC80aHQw?=
 =?utf-8?B?QUJ4dUtGaTdKbmRvcW5PN1RnTGNoS24zeENBVDArN2dkdHU4U3ViR3lqSFky?=
 =?utf-8?B?eEJyeW56NFJNMjFaTTUxcDdwMDNKV1JQVFQ3cGliL1ozS2ZHK2hVY21acXVn?=
 =?utf-8?Q?Xp2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1bd33b-b9b1-4e8b-2732-08d76f77f036
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 18:15:22.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgqWjDS2Iy4kPtZgfwOSZdv0NDeigrBa2K3R7Z7w8MNTfQt13y/P/EPmC+xL9RbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2683
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlIGwRsr/Dvyokf4gMGypwF0xsQJKo9y8jxPuzuzMeQ=;
 b=NDo0H4OL12DMbBEpZgz51+U3fP1ayF8csHtpDsEE2AkAv8CmzYti1tWVmnPHOod2yXcCzZd3XNZcs+2prDRVxtK94qnDqJOUJ4iqYAf/HhcH2T7oxsGDoFT281KULYA0JSF7+2oREGQsC4Y1jW6TOMqVf/4ZyxxiE/YC4thXEL0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191122181520.7b0C6uVGtyfF6YYvW6LkGxamIlAUWexYYoiLuVqQXsk@z>

UHVzaGVkLiBUaGFua3MhCgpZb25nCgpPbiAyMDE5LTExLTIxIDExOjIxIHAubS4sIExpdSwgWmhh
biB3cm90ZToKPiBMb29rcyBnb29kIHRvIG1lLgo+Cj4gUmV2aWV3ZWQtYnk6IFpoYW4gTGl1IDx6
aGFuLmxpdUBhbWQuY29tPgo+Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206
IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFs
ZiBPZgo+PiBZb25nIFpoYW8KPj4gU2VudDogMjAxOS9Ob3ZlbWJlci8yMSwgVGh1cnNkYXkgNDoy
NSBQTQo+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IFpoYW8sIFlv
bmcgPFlvbmcuWmhhb0BhbWQuY29tPgo+PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRrZmQ6IFJl
bW92ZSBkdXBsaWNhdGUgZnVuY3Rpb25zCj4+IHVwZGF0ZV9tcWRfaGlxKCkKPj4KPj4gVGhlIGZ1
bmN0aW9ucyBhcmUgdGhlIHNhbWUgYXMgdXBkYXRlX21xZCgpLgo+Pgo+PiBDaGFuZ2UtSWQ6IElj
OGQ4ZjIzY2RkZTZiNzgwNmFiNzY2ZGRmM2Q3MWZhNjY4Y2NhNWZiCj4+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyB8IDE2ICsrLS0tLS0tLS0tLS0tLS0K
Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMgIHwgMTYg
KystLS0tLS0tLS0tLS0tLQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfdmkuYyAgfCAgNCAtLS0tCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDMyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCj4+IGluZGV4IDhkMjEzMjViNWNiYi4uNzgzMmVj
NmU0ODBiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFk
X21hbmFnZXJfdjEwLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21x
ZF9tYW5hZ2VyX3YxMC5jCj4+IEBAIC0yODIsMTggKzI4Miw2IEBAIHN0YXRpYyB2b2lkIGluaXRf
bXFkX2hpcShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLAo+PiB2b2lkICoqbXFkLAo+PiAgIAkJCTEg
PDwgQ1BfSFFEX1BRX0NPTlRST0xfX0tNRF9RVUVVRV9fU0hJRlQ7Cj4+ICAgfQo+Pgo+PiAtc3Rh
dGljIHZvaWQgdXBkYXRlX21xZF9oaXEoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgdm9pZCAqbXFk
LAo+PiAtCQkJc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnEpCj4+IC17Cj4+IC0Jc3RydWN0IHYx
MF9jb21wdXRlX21xZCAqbTsKPj4gLQo+PiAtCXVwZGF0ZV9tcWQobW0sIG1xZCwgcSk7Cj4+IC0K
Pj4gLQkvKiBUT0RPOiB3aGF0J3MgdGhlIHBvaW50PyB1cGRhdGVfbXFkIGFscmVhZHkgZG9lcyB0
aGlzLiAqLwo+PiAtCW0gPSBnZXRfbXFkKG1xZCk7Cj4+IC0JbS0+Y3BfaHFkX3ZtaWQgPSBxLT52
bWlkOwo+PiAtfQo+PiAtCj4+ICAgc3RhdGljIHZvaWQgaW5pdF9tcWRfc2RtYShzdHJ1Y3QgbXFk
X21hbmFnZXIgKm1tLCB2b2lkICoqbXFkLAo+PiAgIAkJc3RydWN0IGtmZF9tZW1fb2JqICptcWRf
bWVtX29iaiwgdWludDY0X3QgKmdhcnRfYWRkciwKPj4gICAJCXN0cnVjdCBxdWV1ZV9wcm9wZXJ0
aWVzICpxKQo+PiBAQCAtNDIyLDcgKzQxMCw3IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21h
bmFnZXJfaW5pdF92MTAoZW51bQo+PiBLRkRfTVFEX1RZUEUgdHlwZSwKPj4gICAJCW1xZC0+aW5p
dF9tcWQgPSBpbml0X21xZF9oaXE7Cj4+ICAgCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWRfaGlx
X3NkbWE7Cj4+ICAgCQltcWQtPmxvYWRfbXFkID0gbG9hZF9tcWQ7Cj4+IC0JCW1xZC0+dXBkYXRl
X21xZCA9IHVwZGF0ZV9tcWRfaGlxOwo+PiArCQltcWQtPnVwZGF0ZV9tcWQgPSB1cGRhdGVfbXFk
Owo+PiAgIAkJbXFkLT5kZXN0cm95X21xZCA9IGRlc3Ryb3lfbXFkOwo+PiAgIAkJbXFkLT5pc19v
Y2N1cGllZCA9IGlzX29jY3VwaWVkOwo+PiAgIAkJbXFkLT5tcWRfc2l6ZSA9IHNpemVvZihzdHJ1
Y3QgdjEwX2NvbXB1dGVfbXFkKTsgQEAgLQo+PiA0MzYsNyArNDI0LDcgQEAgc3RydWN0IG1xZF9t
YW5hZ2VyICptcWRfbWFuYWdlcl9pbml0X3YxMChlbnVtCj4+IEtGRF9NUURfVFlQRSB0eXBlLAo+
PiAgIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFkX2hpcTsKPj4gICAJCW1xZC0+ZnJlZV9tcWQg
PSBmcmVlX21xZDsKPj4gICAJCW1xZC0+bG9hZF9tcWQgPSBsb2FkX21xZDsKPj4gLQkJbXFkLT51
cGRhdGVfbXFkID0gdXBkYXRlX21xZF9oaXE7Cj4+ICsJCW1xZC0+dXBkYXRlX21xZCA9IHVwZGF0
ZV9tcWQ7Cj4+ICAgCQltcWQtPmRlc3Ryb3lfbXFkID0gZGVzdHJveV9tcWQ7Cj4+ICAgCQltcWQt
PmlzX29jY3VwaWVkID0gaXNfb2NjdXBpZWQ7Cj4+ICAgCQltcWQtPm1xZF9zaXplID0gc2l6ZW9m
KHN0cnVjdCB2MTBfY29tcHV0ZV9tcWQpOyBkaWZmIC0tZ2l0Cj4+IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+PiBpbmRleCBkZjc3ZDY3ZWM5YWEuLmFhOTAx
MDk5NWVhZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21x
ZF9tYW5hZ2VyX3Y5LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21x
ZF9tYW5hZ2VyX3Y5LmMKPj4gQEAgLTMyNSwxOCArMzI1LDYgQEAgc3RhdGljIHZvaWQgaW5pdF9t
cWRfaGlxKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sCj4+IHZvaWQgKiptcWQsCj4+ICAgCQkJMSA8
PCBDUF9IUURfUFFfQ09OVFJPTF9fS01EX1FVRVVFX19TSElGVDsKPj4gICB9Cj4+Cj4+IC1zdGF0
aWMgdm9pZCB1cGRhdGVfbXFkX2hpcShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCB2b2lkICptcWQs
Cj4+IC0JCQlzdHJ1Y3QgcXVldWVfcHJvcGVydGllcyAqcSkKPj4gLXsKPj4gLQlzdHJ1Y3Qgdjlf
bXFkICptOwo+PiAtCj4+IC0JdXBkYXRlX21xZChtbSwgbXFkLCBxKTsKPj4gLQo+PiAtCS8qIFRP
RE86IHdoYXQncyB0aGUgcG9pbnQ/IHVwZGF0ZV9tcWQgYWxyZWFkeSBkb2VzIHRoaXMuICovCj4+
IC0JbSA9IGdldF9tcWQobXFkKTsKPj4gLQltLT5jcF9ocWRfdm1pZCA9IHEtPnZtaWQ7Cj4+IC19
Cj4+IC0KPj4gICBzdGF0aWMgdm9pZCBpbml0X21xZF9zZG1hKHN0cnVjdCBtcWRfbWFuYWdlciAq
bW0sIHZvaWQgKiptcWQsCj4+ICAgCQlzdHJ1Y3Qga2ZkX21lbV9vYmogKm1xZF9tZW1fb2JqLCB1
aW50NjRfdCAqZ2FydF9hZGRyLAo+PiAgIAkJc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnEpCj4+
IEBAIC00NjIsNyArNDUwLDcgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdlcl9pbml0
X3Y5KGVudW0KPj4gS0ZEX01RRF9UWVBFIHR5cGUsCj4+ICAgCQltcWQtPmluaXRfbXFkID0gaW5p
dF9tcWRfaGlxOwo+PiAgIAkJbXFkLT5mcmVlX21xZCA9IGZyZWVfbXFkX2hpcV9zZG1hOwo+PiAg
IAkJbXFkLT5sb2FkX21xZCA9IGxvYWRfbXFkOwo+PiAtCQltcWQtPnVwZGF0ZV9tcWQgPSB1cGRh
dGVfbXFkX2hpcTsKPj4gKwkJbXFkLT51cGRhdGVfbXFkID0gdXBkYXRlX21xZDsKPj4gICAJCW1x
ZC0+ZGVzdHJveV9tcWQgPSBkZXN0cm95X21xZDsKPj4gICAJCW1xZC0+aXNfb2NjdXBpZWQgPSBp
c19vY2N1cGllZDsKPj4gICAJCW1xZC0+bXFkX3NpemUgPSBzaXplb2Yoc3RydWN0IHY5X21xZCk7
IEBAIC00NzUsNyArNDYzLDcKPj4gQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdlcl9p
bml0X3Y5KGVudW0gS0ZEX01RRF9UWVBFCj4+IHR5cGUsCj4+ICAgCQltcWQtPmluaXRfbXFkID0g
aW5pdF9tcWRfaGlxOwo+PiAgIAkJbXFkLT5mcmVlX21xZCA9IGZyZWVfbXFkOwo+PiAgIAkJbXFk
LT5sb2FkX21xZCA9IGxvYWRfbXFkOwo+PiAtCQltcWQtPnVwZGF0ZV9tcWQgPSB1cGRhdGVfbXFk
X2hpcTsKPj4gKwkJbXFkLT51cGRhdGVfbXFkID0gdXBkYXRlX21xZDsKPj4gICAJCW1xZC0+ZGVz
dHJveV9tcWQgPSBkZXN0cm95X21xZDsKPj4gICAJCW1xZC0+aXNfb2NjdXBpZWQgPSBpc19vY2N1
cGllZDsKPj4gICAJCW1xZC0+bXFkX3NpemUgPSBzaXplb2Yoc3RydWN0IHY5X21xZCk7IGRpZmYg
LS1naXQKPj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmku
Ywo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jCj4+
IGluZGV4IDNiNmI1NjcxOTY0Yy4uYTVlOGZmMWU1OTQ1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYwo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYwo+PiBAQCAtMzEyLDExICsz
MTIsNyBAQCBzdGF0aWMgdm9pZCBpbml0X21xZF9oaXEoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwK
Pj4gdm9pZCAqKm1xZCwgIHN0YXRpYyB2b2lkIHVwZGF0ZV9tcWRfaGlxKHN0cnVjdCBtcWRfbWFu
YWdlciAqbW0sIHZvaWQKPj4gKm1xZCwKPj4gICAJCQlzdHJ1Y3QgcXVldWVfcHJvcGVydGllcyAq
cSkKPj4gICB7Cj4+IC0Jc3RydWN0IHZpX21xZCAqbTsKPj4gICAJX191cGRhdGVfbXFkKG1tLCBt
cWQsIHEsIE1UWVBFX1VDLCAwKTsKPj4gLQo+PiAtCW0gPSBnZXRfbXFkKG1xZCk7Cj4+IC0JbS0+
Y3BfaHFkX3ZtaWQgPSBxLT52bWlkOwo+PiAgIH0KPj4KPj4gICBzdGF0aWMgdm9pZCBpbml0X21x
ZF9zZG1hKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKiptcWQsCj4+IC0tCj4+IDIuMTcu
MQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsaXN0cy4KPj4gZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLQo+PiBnZngmYW1wO2RhdGE9MDIlN0MwMSU3Q3poYW4ubGl1JTQwYW1kLmNvbSU3QzBl
M2FiMWExZDExZjQ4NDZkMDMKPj4gYTA4ZDc2ZWM5NWRmMyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcwCj4+IDk5NjgzNTE3MzAyNzAyJmFtcDtzZGF0YT1q
bW10ZEh1Z2psNUI2UCUyRlJBb2p6UHFLUGxDOHMlMkYwN3dtUwo+PiBrWTgyaU9VdlElM0QmYW1w
O3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
