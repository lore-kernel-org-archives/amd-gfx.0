Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D67C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 23:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8C1238D6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 23:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8C1238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B99789C1A;
	Wed, 16 Dec 2020 23:11:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656E789C1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 23:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAssbg0/zErYe+q1n+9p+Y905mstfhjmtuBha+ud13EhnHhb5JtVRjgzaS1JFsy7uHR5ch2aIKntzZkrpfG5F8TtEvhK6jlZHi1FpJcTnD3QM/lN5b0lRkSkkxlzYq7tQSwWwwiI5SRNn3sPln7vcGm2j0RLciQP/xSfsB+U8Hbw+x5Ex5ZO4wFD3X/i4a1Uj+0nHkazCtJTykNE7SC/9GOir8UV/dYcQ7nu3/2Cbcn0OtbE9ZGhYHojVQ2LRiwMbc4iz/12PxOLzf6irwagadRiZctKFqa3FIM+OFWO8LDqQqUJttU2A3r9bCgzGj03U8IxT8d/EKejxOq6zPddvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xsopbwnzwzQCADAkmFq8eBkqSAuJICcRoLfQas7Nnc=;
 b=inT02wt8O+aH33vnJQ0QJG32tWQoEbyFg7yzd3GriZLJ9i4yV57qKD3cYfs0wbik3m5+UGlb2bSii1EkZB0C9TbxIb84Elx1cXuy584vHJFkDY+GR825mfjh+EWURg5sfB9vIWcARshMikPNcWlGj04hORRK0xEAtWt8WfBkcgahzyjMHXyJ5bu8tLKE25JP62F9Lx9LvfWSKLBR87JCzKEtwOQKmL7vAN846tQjG2soMVss54pH+UyR+hbWKpZZfr/lBejChwZ+pr3+mzcL1HF0YRZp1utnVeIk0LyxCNrVtcarZevQY/bmEsMWza9pXZWm+uqRpp2loOTSTudm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xsopbwnzwzQCADAkmFq8eBkqSAuJICcRoLfQas7Nnc=;
 b=VVWjxI7M186ebhO51frvUHsv09wlWtoIKJ4PgYjVpKt6XoZAOSlU4Afk9aw5qEINxtO75UT/KjSDvxrWyMrqt2YcAbWhvfQbgJmzG5dHvxNkucB32h/kWcRddYIlTw3F1R/i1dcVHirIJ1IOLzwWvVwjVpgjnqAqyjohYOiYzIc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 23:11:34 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3654.024; Wed, 16 Dec 2020
 23:11:34 +0000
Subject: Re: [PATCH] drm/amdkfd: PCIe atomics required for gfx10
To: amd-gfx@lists.freedesktop.org,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20201216223413.510714-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e3e26d77-6ebf-c3da-4bd7-c283ebc74621@amd.com>
Date: Wed, 16 Dec 2020 18:11:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201216223413.510714-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::35) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 16 Dec 2020 23:11:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8e7d4dd-25cf-43f8-6844-08d8a217eebd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4948EB3EA2C27D6EB8E9E0D692C50@BL0PR12MB4948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4sggVh5V+ckHu49ihP6mRkZxyEk3FEMY2x6v4T/xOytzS44NByVZ8CVyXMEATli0A9O11Gk/E4w+ZyT4mUJNJCOivSg5mcCrIGZtJvWppiUVqGcsQoE/rFEvqpksHgnDAz07Adkrg3BBJQUpPWhcfUKCcd34bUul2NceCKWRb0NEvstkuqHvlZBCKULWK8E6at+UKsLwGcN2qSygO33NotgeEynOpARbDUsVU6lRtTB8q6m9R1fG39me41ZP+d91CEsRMol93j20PniC/oMW2RaQ7xzIAsjdMZhBISpAavBCoEs5FDrRcZANSZlnv8z0WHk2PC6dDwmqDVOjR0UEFX+0DWscR0OyJQZck19J/KkEa1k7fMeyn0oxZGE3Qt6cr+l1cQEJhLCRDbvdpSP30iNul62J4boS/Slxj3UPvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(44832011)(5660300002)(66476007)(6636002)(37006003)(316002)(66556008)(66946007)(86362001)(31686004)(31696002)(52116002)(8676002)(8936002)(2906002)(36756003)(4001150100001)(956004)(478600001)(6486002)(26005)(83380400001)(186003)(16526019)(16576012)(6862004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RjVtNUgxYXN2N2ltQ093RGdkb2hpN0pnU2tqdVk0WkJ3dkRMRy8rVlBhTnI1?=
 =?utf-8?B?eSs2cCtnOWVpbmgzWnE3bXJreGEvNTliZXdnNFErZEdzcFQ2M0JlMU5qN3ZG?=
 =?utf-8?B?czZSN3BJRS9sYm9DaE5XZmZkZjlndEVtOVZnMnR3OVlLV3d2eFU4ZWdSSnh5?=
 =?utf-8?B?VmZsM25PeDA0NVRDMlRBbytkL1crYTcxZTNuNk5ValUyTDJTSVNyZmowb2Ra?=
 =?utf-8?B?dTVvMGQwUDNya0FjZ3FxSWNhaWozRWdSMEw0aEh3b1BOaFZCdi9sNmY0dDJL?=
 =?utf-8?B?NDFmbUFxKytWSzdORzhURkdhenN4TGQ2am5pMWt0VXRBanFyei9OWFdheEh1?=
 =?utf-8?B?ZkdvN1dlcGJDUkE2MU5DUDVKclQzTlN5RU9vVGxjS3pHWTNzM1psMCtITmpu?=
 =?utf-8?B?MFMwSE1NVmlobnIzK1l4VldsVzhMY253NkZrTE05TWNtQTZUMU9KOXFDNklv?=
 =?utf-8?B?T0psOFIzd1JyalNxWVdrTjNDN294YSs3SjI1WXNEV3Q3YlZzU0FkMWV3Y3du?=
 =?utf-8?B?K3RGSTRBMlE1N1Q5akN5SjF2aTFpUjRKWDlVRlk1Tm5uNEZXTUlXMzlXMTBX?=
 =?utf-8?B?ZllEcFhnaVpuREIzNGtuZm1LS0dTVEY2Y1lmS3pvdVQxbzVBVEg4dUlZQ2NS?=
 =?utf-8?B?UXYvcDFZYmZPTHNEQ3FFRzBSd3cxRHp2enFDdlBiZkhtS2NuVGpyS1U0eVVS?=
 =?utf-8?B?Yk5nUElad3pXbVdJVmJUdWIvbGFnRjFET3Z2OEZEMkkxSm04U0FxMUVxenpv?=
 =?utf-8?B?T1QyVTdwYlZzUCs0K3h0eFNzSXhQZFhLZ01yMjZqeTRZRG05UXZ6RWdBZkt1?=
 =?utf-8?B?S1NDbXBiKzJFZVlqemRnSlBlRS9ocjBXMUdSeUVyMjNGMVVseG9GSVNPWWp0?=
 =?utf-8?B?ZUNEYzhGazIzR0k4Ty9vN2ttMDlrRkRmMXhpbHJ6MmtWT3hFQ1ZvOVBETUpU?=
 =?utf-8?B?S3Y5dkxvQUxuZG9KNEhIbHZIUUNuRTNwcThieXRHWGdOa1p2eWtOTWtHSDNB?=
 =?utf-8?B?cWdCSmxsYk8xdVFqeTlSZGx6ZVpacERLZnFZRXZ6ZzlQS2cwR0RidDkvNk4v?=
 =?utf-8?B?QnRFQVFiOXo1ZUM0ZFdvZDZtaFdkQXdWcENUdGxRMHF4TzNoeitIQTZHT0wz?=
 =?utf-8?B?S1pud1VmQnJBVmZnYmJjNStmQXZ2T1dINElPKzVzeWJENnpEbDIyTGFTSHJ3?=
 =?utf-8?B?Y0psQjZWdWFFekRTYkFSZm50TGRWdThpQk9jb3UxUy9GMGJ1djJkODJnYnl5?=
 =?utf-8?B?emVFMmRXd3ZQNW9GcE50c3JGL3d2Z0hJclh1SHUxVTJ5eVA2QkkyV1lHeUx3?=
 =?utf-8?Q?ouc4IFA8ee5NXKGM2tA0Fulf9xLewFubol?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 23:11:34.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e7d4dd-25cf-43f8-6844-08d8a217eebd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBuu3xxxMCd8JU1+Z7QVTPueQpXAKWfiFwSqpmukhUI1tMPckFnX09sZfLNHfVZAjWbzlMiV7onHPH03LtHYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
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

QW0gMjAyMC0xMi0xNiB1bSA1OjM0IHAubS4gc2NocmllYiBIYXJpc2ggS2FzaXZpc3dhbmF0aGFu
Ogo+IFNpZ25lZC1vZmYtYnk6IEhhcmlzaCBLYXNpdmlzd2FuYXRoYW4gPEhhcmlzaC5LYXNpdmlz
d2FuYXRoYW5AYW1kLmNvbT4KPiBDaGFuZ2UtSWQ6IEljMTM5YThiOWM4YmVmMWRmMTgzODA0ZTU0
MzEwM2JlMjA2NDA1ZGNhCgpQbGVhc2UgYWRkIGEgcGF0Y2ggZGVzY3JpcHRpb24gKHdoYXQgdHlw
ZSBvZiBwcm9ibGVtIGRvZXMgdGhpcyBmaXgpIGFuZApyZW1vdmUgdGhlICJDaGFuZ2UtSWQiLiBU
byBzdG9wIGdpdCBmcm9tIGFkZGluZyBvbmUgYXV0b21hdGljYWxseSBpbiB0aGUKY29tbWl0LW1z
ZyBob29rLCBJIHRoaW5rIHRoaXMgc2hvdWxkIGRvIHRoZSB0cmljazoKCsKgwqDCoCBnaXQgY29u
ZmlnIGdlcnJpdC5jcmVhdGVDaGFuZ2VJZCBmYWxzZQoKRm9yIFZhbkdvZ2ggSSBkb24ndCB0aGlu
ayB3ZSBuZWVkIFBDSWUgYXRvbWljcy4gVGhhdCdzIGFuIEFQVSwgc28gc3lzdGVtCm1lbW9yeSBh
Y2Nlc3MgZG9lc24ndCBhY3R1YWxseSBnbyB0aHJvdWdoIFBDSWUuCgpXaXRoIHRoYXQgZml4ZWQs
IHRoZSBwYXRjaCBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPgoKVGhhbmtzLArCoCBGZWxpeAoKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDE0ICsrKysrKystLS0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZS5jCj4gaW5kZXggNTA5MjJmZjI5MjdiLi4wZTE4Mzg2MzdjNTQg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jCj4gQEAgLTQyMiw3
ICs0MjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyBuYXZpMTBfZGV2
aWNlX2luZm8gPSB7Cj4gIAkubXFkX3NpemVfYWxpZ25lZCA9IE1RRF9TSVpFX0FMSUdORUQsCj4g
IAkubmVlZHNfaW9tbXVfZGV2aWNlID0gZmFsc2UsCj4gIAkuc3VwcG9ydHNfY3dzciA9IHRydWUs
Cj4gLQkubmVlZHNfcGNpX2F0b21pY3MgPSBmYWxzZSwKPiArCS5uZWVkc19wY2lfYXRvbWljcyA9
IHRydWUsCj4gIAkubnVtX3NkbWFfZW5naW5lcyA9IDIsCj4gIAkubnVtX3hnbWlfc2RtYV9lbmdp
bmVzID0gMCwKPiAgCS5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDgsCj4gQEAgLTQ0MCw3
ICs0NDAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyBuYXZpMTJfZGV2
aWNlX2luZm8gPSB7Cj4gIAkubXFkX3NpemVfYWxpZ25lZCA9IE1RRF9TSVpFX0FMSUdORUQsCj4g
IAkubmVlZHNfaW9tbXVfZGV2aWNlID0gZmFsc2UsCj4gIAkuc3VwcG9ydHNfY3dzciA9IHRydWUs
Cj4gLQkubmVlZHNfcGNpX2F0b21pY3MgPSBmYWxzZSwKPiArCS5uZWVkc19wY2lfYXRvbWljcyA9
IHRydWUsCj4gIAkubnVtX3NkbWFfZW5naW5lcyA9IDIsCj4gIAkubnVtX3hnbWlfc2RtYV9lbmdp
bmVzID0gMCwKPiAgCS5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDgsCj4gQEAgLTQ1OCw3
ICs0NTgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyBuYXZpMTRfZGV2
aWNlX2luZm8gPSB7Cj4gIAkubXFkX3NpemVfYWxpZ25lZCA9IE1RRF9TSVpFX0FMSUdORUQsCj4g
IAkubmVlZHNfaW9tbXVfZGV2aWNlID0gZmFsc2UsCj4gIAkuc3VwcG9ydHNfY3dzciA9IHRydWUs
Cj4gLQkubmVlZHNfcGNpX2F0b21pY3MgPSBmYWxzZSwKPiArCS5uZWVkc19wY2lfYXRvbWljcyA9
IHRydWUsCj4gIAkubnVtX3NkbWFfZW5naW5lcyA9IDIsCj4gIAkubnVtX3hnbWlfc2RtYV9lbmdp
bmVzID0gMCwKPiAgCS5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDgsCj4gQEAgLTQ3Niw3
ICs0NzYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyBzaWVubmFfY2lj
aGxpZF9kZXZpY2VfaW5mbyA9IHsKPiAgCS5tcWRfc2l6ZV9hbGlnbmVkID0gTVFEX1NJWkVfQUxJ
R05FRCwKPiAgCS5uZWVkc19pb21tdV9kZXZpY2UgPSBmYWxzZSwKPiAgCS5zdXBwb3J0c19jd3Ny
ID0gdHJ1ZSwKPiAtCS5uZWVkc19wY2lfYXRvbWljcyA9IGZhbHNlLAo+ICsJLm5lZWRzX3BjaV9h
dG9taWNzID0gdHJ1ZSwKPiAgCS5udW1fc2RtYV9lbmdpbmVzID0gNCwKPiAgCS5udW1feGdtaV9z
ZG1hX2VuZ2luZXMgPSAwLAo+ICAJLm51bV9zZG1hX3F1ZXVlc19wZXJfZW5naW5lID0gOCwKPiBA
QCAtNDk0LDcgKzQ5NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2ZkX2RldmljZV9pbmZvIG5h
dnlfZmxvdW5kZXJfZGV2aWNlX2luZm8gPSB7Cj4gIAkubXFkX3NpemVfYWxpZ25lZCA9IE1RRF9T
SVpFX0FMSUdORUQsCj4gIAkubmVlZHNfaW9tbXVfZGV2aWNlID0gZmFsc2UsCj4gIAkuc3VwcG9y
dHNfY3dzciA9IHRydWUsCj4gLQkubmVlZHNfcGNpX2F0b21pY3MgPSBmYWxzZSwKPiArCS5uZWVk
c19wY2lfYXRvbWljcyA9IHRydWUsCj4gIAkubnVtX3NkbWFfZW5naW5lcyA9IDIsCj4gIAkubnVt
X3hnbWlfc2RtYV9lbmdpbmVzID0gMCwKPiAgCS5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9
IDgsCj4gQEAgLTUxMiw3ICs1MTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2Vf
aW5mbyB2YW5nb2doX2RldmljZV9pbmZvID0gewo+ICAJLm1xZF9zaXplX2FsaWduZWQgPSBNUURf
U0laRV9BTElHTkVELAo+ICAJLm5lZWRzX2lvbW11X2RldmljZSA9IGZhbHNlLAo+ICAJLnN1cHBv
cnRzX2N3c3IgPSB0cnVlLAo+IC0JLm5lZWRzX3BjaV9hdG9taWNzID0gZmFsc2UsCj4gKwkubmVl
ZHNfcGNpX2F0b21pY3MgPSB0cnVlLAo+ICAJLm51bV9zZG1hX2VuZ2luZXMgPSAxLAo+ICAJLm51
bV94Z21pX3NkbWFfZW5naW5lcyA9IDAsCj4gIAkubnVtX3NkbWFfcXVldWVzX3Blcl9lbmdpbmUg
PSAyLAo+IEBAIC01MzAsNyArNTMwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZmRfZGV2aWNl
X2luZm8gZGltZ3JleV9jYXZlZmlzaF9kZXZpY2VfaW5mbyA9IHsKPiAgCS5tcWRfc2l6ZV9hbGln
bmVkID0gTVFEX1NJWkVfQUxJR05FRCwKPiAgCS5uZWVkc19pb21tdV9kZXZpY2UgPSBmYWxzZSwK
PiAgCS5zdXBwb3J0c19jd3NyID0gdHJ1ZSwKPiAtCS5uZWVkc19wY2lfYXRvbWljcyA9IGZhbHNl
LAo+ICsJLm5lZWRzX3BjaV9hdG9taWNzID0gdHJ1ZSwKPiAgCS5udW1fc2RtYV9lbmdpbmVzID0g
MiwKPiAgCS5udW1feGdtaV9zZG1hX2VuZ2luZXMgPSAwLAo+ICAJLm51bV9zZG1hX3F1ZXVlc19w
ZXJfZW5naW5lID0gOCwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
