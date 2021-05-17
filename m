Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2BC43462
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214F660FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214F660FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEE189FF7;
	Mon, 17 May 2021 20:08:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861FC89FF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 20:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLnDW4L0oMuK57xkFf8auWqzrM9SNiKyVuZDhJos36J2vtXVJB3ARzHGecBvml0A7MsACrPM7Md/OrkZFeT/Dq2pwFwieCQVcSkyl+XV1+ATc56OY7NHdWvcj3Mq6PYd8ABGN2UtrUyRKSwLGZtM76DCJyCdgL901wONc4OREmcKa8hU19IexfL5syjDqFMzvhMChent1WTAxWSD2UEr+K0eE401HED9gyCteyBZYffsQ6Ahi5ss3y9bRuB7yDeFl80oZUCx1DhaqMllgISduHQoF7wMQAIjtkCGc4K96uKV43z9Wc0KXgMV0V0akWdnWaMVaMzS7DWEvoozcnvbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nf1l2SZhoxzwo8AEKswtgDyCCAGSmRkR3A1t2tEU6k=;
 b=hHQWaFTeZ138fQjL1snB280e80acvRlmAONQ5xgpD0D0QGp52LWo7ssdHJgf5fYCc1FC/aUUYMtRV2LtDWV5XrKF/dGSG7WaWC4T319KEmVVoN1wsnl3jcrsj/WHQQulQ7nr6omrv1dwI53WkAQSFDFRZgUeG0wSDx6bxEqF1zY9oF7hB5q+jOFGb6mSNAY2y0G2DE2ouTL0bbHZ/v65G8bSOAwwoqW7Ql5J8p3lVdVczTdXyMh0RA0pNkT89Ysqdy7B6PmUQr2HrArsvIBQ1hJYdKQmcJLvlDVG1+48HB06seUcisIVaMlRFcGQcsnGNuXlpBtP96T/2EPA448srA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nf1l2SZhoxzwo8AEKswtgDyCCAGSmRkR3A1t2tEU6k=;
 b=P/DOX9waVNcgAqbmasbOMhPGUA/sCDMX042v0IGLJ4vj5QU7AtNy+BNNFfJ2fsHIMpO8Mqkhl4zhmNEMfPt6EgMz3fp02JNJrUq2Fa4Jjl0rd4dzsAReTGcrvvQtTvZXJIkYgo1Jd4pp7dc+AjsaS6iNEZ/MxTqc01up/MFHx80=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2455.namprd12.prod.outlook.com (2603:10b6:4:b7::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Mon, 17 May 2021 20:08:22 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 20:08:22 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <4e8c5fd1-2a2a-c40a-29a2-a19c8c75d3d7@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <14525116-f4cf-6ca8-a787-f3078cb5287f@amd.com>
Date: Mon, 17 May 2021 16:08:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <4e8c5fd1-2a2a-c40a-29a2-a19c8c75d3d7@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 17 May 2021 20:08:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88e4d9d-841e-4492-5f31-08d9196f8571
X-MS-TrafficTypeDiagnostic: DM5PR12MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24553AC8D151EFE9D2663CD9E42D9@DM5PR12MB2455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQ+KTfHy1PiyCJEflVUvn+hrq4pmY01P8t46B+1KcwEO1iOXeysXcs5pg9jhy665y5K42tlhLqllWdeNiz7K3assvdSagDQqriX0K9D3raE5YVD6jcJue4HripeQmqU71Mj6SZX83UOoothB/6J6w82k1L77kNwdVG3QfkDKjOpH9a9ttM2hSZfAWm1GHoA5Da3m6BYFZZl98jia9jDgooyYaeKDRM803aVHZj/tHgXrDx8ZMct3/CQ23MFv7Fjle2/+KhmNBTXgDY5ChT8tRQyG0EtOdhr93wDaeonCLkbgr8BZ5SsEglK47cOqeGbL11eXQ2NKX85Kn06N5kF8WMUThVMazyHxxTt7qL7d3c+1EETgiDf6n3K4tjiXWtz2/dPcz911hMo1jgejzeZ8eFPhHWrfVWzUn+R1uXiGpHYZnIBCjEKjoRqMC4Or0hnLEhqcQ3QPT+dHdqRNIZJJYNJEw+IF9bKAI21i1z5N/hjSM019OGOHhhOozUFLTFsN5Vy9URSEGhDEtEOUCOTHAMPUbmOJ9wp7pp7htCpmSjbqApdfawLXl1yzDaXq4kpvPVUUJK+GLRuUq6DdQoRwGKpS4MgOK5M+APd7ayeb0K29nI97CklRNM65PP43dWvj0KYiYS4K6APl4cZx/Bvfywk98v+gcUUl+BaTGUf8zI9rWjHcAqKuWKL1paqXa5o8FP9u44fPTJeJ7dCZHAAMHha6P/eb/lFhbhoNw7p9UP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(66946007)(66556008)(8936002)(83380400001)(186003)(66476007)(31696002)(8676002)(38350700002)(38100700002)(956004)(110136005)(478600001)(16576012)(2616005)(316002)(26005)(2906002)(16526019)(66574015)(6486002)(36756003)(53546011)(5660300002)(36916002)(31686004)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?elhWQy9JNWwvazJWR0RpSFE0QVpielRKL29rcUQxY0VVVUVialdmZ3lNSWVt?=
 =?utf-8?B?VGJrT2Q2cVZ6SzA3Y3I0TzFSWkd0cHFsc3lWNW1EeFBFSHVYT2cxRjhSL0x0?=
 =?utf-8?B?cnJpN3hPT1RKcEo2Z2xVTE5HSzhUVHpaMXZXdWg4VWh5OEFRYlUvdDlXK0pN?=
 =?utf-8?B?ZGJwZTBDMEc2R2xER29CMFV5U21IVENaZWdzRDUxcE9pejFReStmdWFQSmxv?=
 =?utf-8?B?dFZTQlg4RjF2QXhWN1IrZnk4bGtlSWxKRXYrNmZnTVpCcENhVjlkWVlBeTZZ?=
 =?utf-8?B?bUk4RC9uUkVhckdZNGE2NW02OFo5b3I5bUU3WFlLcERBSUF4bmR3WFp2SVhT?=
 =?utf-8?B?SU5ISnBIc25PaENOV0lGdU1HUnMyMFBWajEvK1BkMVA4dTRacG9qQi9sNkk4?=
 =?utf-8?B?cFBCU2VMT3pBeUl2SGpVKzRKOVpFSkJxQUJ2UTQvbkc0ZzN0TzQ5YStoc21R?=
 =?utf-8?B?bzJUeENKVjByUnNNM3JFK0pFeSswSTAwWGNiL1ZWKy9Ga1YzUWU0WGFiamRI?=
 =?utf-8?B?YzJldGdQNm84QkR0TXljbnFRYm1pN3ZCSUNEZy9tcXV5aVVXYW1vbCtLVVZw?=
 =?utf-8?B?MjdYMm5WZGI3THVPcmhFTWRaQlhTQ2ZQbXhwajQyVXZhcENQS3ZyNVZ2c1Q2?=
 =?utf-8?B?REU5TWJ2YkFIaDdBbVI4RUE2VG81eXJVLzBkTGhxcm50Y2dtOWhOUEUzUVVP?=
 =?utf-8?B?UVdkNTJPRTJDVDRDRlQ3eVNIYnlRYTk4eCtXdFhuQ0tIZTF4RXIzZ0hRRTVE?=
 =?utf-8?B?di9aVGFDcGFja3ovUmJIOFBCY0pxUFBhL1NPYVltczZOSFZIZ1E1Unc1NG5F?=
 =?utf-8?B?R1dnS0NNa3YrVlJ0ZHBtL0ljS1I3NjV6aDQzNlhGMHc5b2o1WGpTRnVianhu?=
 =?utf-8?B?LzZTODZIdFI1NnFzN2RpUFhGMWRqR2lWMHg5VVpzV3dLZGh4dkxNOUMrcWpK?=
 =?utf-8?B?aEJWMTdvSURmUlk1d2tCWW5RY3l3djk5MzFxVWJpMCsyS3RLbmRCbkliaTR4?=
 =?utf-8?B?RXBTN3llcmY1Ni85RnpXRVB1K2JjQU5jaU80Rmw4Qnp6Wm5QTDZTYkkwc3U0?=
 =?utf-8?B?WUJnR0djVGp6NzB5YzJ6Vms0ak9EM0FwYzhJOHhTSDd0NFJTbVR5Umt5ZEtj?=
 =?utf-8?B?RDlhV2ttN3FiRlFpMWZVcndPTldRdk02T0xEL08zQUEvK1BTbHNOOWZ0VmVq?=
 =?utf-8?B?MVNsVUtxWVhkNHMzN0MrZ1BzZkZhZXVCSnBVQlVZUStqY2JDQklUeVV0Tlkw?=
 =?utf-8?B?QjhiU2EzYjkzcjVMcCt4aGh4Q2tkUXFwZ2R6akZkNDJVMTIzai9mTkhZVUNs?=
 =?utf-8?B?amptMWZ1KzhaYlVZKzl4Tm1VeEhMS1h2NFFrd3RIa21ETmZreWd0UDVjSGpB?=
 =?utf-8?B?M2Rua3YvOVZLMkFDNzJMQTJVY0NjOGNRNVJqQURmT3FmT1pzYjdsbWQrR1I5?=
 =?utf-8?B?ZTVTWXZRcDVRb1FDd04xaGlNeEpseEw5QmtZTDVYQ2ordkUzTUwvb2JxSW9K?=
 =?utf-8?B?L2R0NlVOem9WTlZSVjdLUUd2NHJmY0hPVTdGSm9JWFJKSjhGRmcrRUVGQ2ds?=
 =?utf-8?B?MlFLZTBydzRjbUN0NmoyemFSOU5xU0ZZeHhMVjJoQXViR0NqQ2tQTmJDdUJD?=
 =?utf-8?B?TjJDN0trYVJPa0hmMUFHSDJwZXoyNmFjUUR6Nnh0b3ovSTQzaVBUWStJWnY2?=
 =?utf-8?B?QjlHS3lUNFllR0hIWFM4YW9pR2pLcEJmOU1PditUN3g5dG1DZWdXejBwWjRZ?=
 =?utf-8?Q?nrfxDXueV2rlVe01ue+BNI8O6rwfiWzfUKhctwx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e4d9d-841e-4492-5f31-08d9196f8571
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 20:08:22.2228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8fUopP1tTW59m0skT3D1nCjvvxwv/kkbYdztcpqXUp6rwfGCG8wsuEooUAebHq7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
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

Ck9uIDIwMjEtMDUtMTcgMzo0MyBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE3
LjA1LjIxIHVtIDE2OjU3IHNjaHJpZWIgSmFtZXMgWmh1Ogo+PiBEdXJpbmcgdmNuIHN1c3BlbmRz
LCBzdG9wIHJpbmcgY29udGludWUgdG8gcmVjZWl2ZSBuZXcgcmVxdWVzdHMsCj4+IGFuZCB0cnkg
dG8gd2FpdCBmb3IgYWxsIHZjbiBqb2JzIHRvIGZpbmlzaCBncmFjZWZ1bGx5Lgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgMjAgKysrKysrKysrKysrKysr
KysrKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4gaW5k
ZXggMjAxNjQ1OS4uN2U5ZjVjYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uYwo+PiBAQCAtMjc1LDkgKzI3NSwyNyBAQCBpbnQgYW1kZ3B1X3Zjbl9zdXNwZW5k
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgdW5zaWdu
ZWQgc2l6ZTsKPj4gwqDCoMKgwqDCoCB2b2lkICpwdHI7Cj4+ICvCoMKgwqAgaW50IHJldHJ5X21h
eCA9IDY7Cj4+IMKgwqDCoMKgwqAgaW50IGk7Cj4+IMKgIC3CoMKgwqAgY2FuY2VsX2RlbGF5ZWRf
d29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBp
IDwgYWRldi0+dmNuLm51bV92Y25faW5zdDsgKytpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
YWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaSkpCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnRpbnVlOwo+PiArwqDCoMKgwqDCoMKgwqAgcmluZyA9ICZhZGV2LT52Y24uaW5z
dFtpXS5yaW5nX2RlYzsKPj4gK8KgwqDCoMKgwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFs
c2U7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIGZvciAoaiA9IDA7IGogPCBhZGV2LT52Y24ubnVt
X2VuY19yaW5nczsgKytqKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpbmcgPSAmYWRl
di0+dmNuLmluc3RbaV0ucmluZ19lbmNbal07Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJp
bmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqAg
fQo+PiArCj4+ICvCoMKgwqAgd2hpbGUgKHJldHJ5X21heC0tKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAoY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKSkgewo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfd2FybihhZGV2LT5kZXYsICJXYWl0aW5nIGZv
ciBsZWZ0IFZDTiBqb2IocykgdG8gCj4+IGZpbmlzaCBncmFjZWZ1bGx5IC4uLiIpOwo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBtZGVsYXkoNSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvC
oMKgwqAgfQo+Cj4gT2sgdGhhdCBqdXN0IG1ha2VzIG5vIHNlbnNlIGF0IGFsbC4KPgo+IEEgY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgY2FsbCBpcyBmaW5hbCwgeW91IG5ldmVyIG5lZWQgdG8g
Y2FsbCBpdCAKPiBtb3JlIHRoYW4gb25jZS4KPgp5ZWFoLCBJIGFtIHByZXBhcmluZyBhIG5ldyBw
YXRjaC4gVGhhbmtzISBKYW1lcwo+IENocmlzdGlhbi4KPgo+PiDCoCDCoMKgwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyArK2kpIHsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChhZGV2LT52Y24uaGFydmVzdF9jb25maWcgJiAoMSA8PCBpKSkKPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
