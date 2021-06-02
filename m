Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37033C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DCC613D5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DCC613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7126EBFB;
	Wed,  2 Jun 2021 09:00:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE746EBFB
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 09:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHOa26+JK4sAMlY6hSWN3OBFMupsekOGWHyTFfNU43D9C14iHHjB+hSFbgcrO8pn13IPGoFnImNITm/og2TxaldjVsLBK/1c1hJ9+izSPO5LIri2zmiBSC+HFu9gb3N3kL0Vq0qemSzxplBbX3EEnEVufd4v4vBaAdmm9PKFE6IFPyQpmwNV1CF4KyW3S37gGCkPS8dfv4nU6kujEOinHr4JqVugnqztmixzKBljNuqnTVDFnzAA69YqxKuZvkLCARJQ6Nkea04ViwpWfuw6hLEU08uNVA/FTglk20lPJA5Xg9Qn9JRS76ian28DNMSQ0nJYFuV5zsozFt+BOcCLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcmuGz5qXF9EM9/HF8QW0P68OWo93Bd2dI2clrVI800=;
 b=e9VEGGW++64xXRQ5Z8chguDuy/PSQ3ZyqZ7bPoHCjH/8CTNSsc3q0w8NHTsIR3OuFu6t6m+LkZnjgRI4VRXHllm1ePr7viN2nqoRa2B3v4idvt/5JfaLi61gSGFB46l3BQBkzYQ40S5fDzFfV37oRNJzs5P7+/me/YC5Mfn5TjroY6QjQomnq/JMeG1n93O5w6WWM7gVk9AErEFZGIEzni0Fcs1D/qIHixQ9QZyD3VpuR4VpwD9gutQfTIuM8eKp6hCO7mUwZxRa3UBO6MXu5xXiL/9LfWMPMJqGrzyNkFrS/K1kbbw1baB30nUlThUqKN3/6pWiJ9r98RMatcCWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcmuGz5qXF9EM9/HF8QW0P68OWo93Bd2dI2clrVI800=;
 b=xUwsLOVdzyaEkwO7ig4nJqscwQMd+5n4Bc6XwMBwrg8RPL0ZJwECbSkDB7gYMVu92sYzgDR7Pr1d79FRj0Ct7ulUHHoV2u83AX77yEElibQbQGCK7T7xwlLDQrSuNxvZSQZsRdU3/cxj+l3t8X2QEyLuvyNJXzdRjb7MFXKL29k=
Authentication-Results: freedesktop.org; dkim=none (message not signed)
 header.d=none;freedesktop.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 09:00:49 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 09:00:49 +0000
Subject: Re: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Changfeng <Changfeng.Zhu@amd.com>, Ray.Huang@amd.com, amd-gfx@freedesktop.org
References: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
 <c9c3817a-ddd5-d73e-5a5b-fb3ad25d8ddc@amd.com>
 <9a3adb34-031e-9742-d165-cb6f36c91063@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <6732a968-766e-b8d6-fd55-43a33632169c@amd.com>
Date: Wed, 2 Jun 2021 11:00:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <9a3adb34-031e-9742-d165-cb6f36c91063@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM0PR04CA0112.eurprd04.prod.outlook.com
 (2603:10a6:208:55::17) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM0PR04CA0112.eurprd04.prod.outlook.com (2603:10a6:208:55::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.15 via Frontend Transport; Wed, 2 Jun 2021 09:00:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f92d56-3599-471c-2514-08d925a4eae0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5117:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51176F98D1A59578A0CAB9058B3D9@DM4PR12MB5117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7LTakj0C5LA2haUCc5GNOWXzeraobx3TMuZdB7eEwNnTlI5GT2J8oIBM3Kum8HkDWU5F+0MfwaGVAQrzCmoLB3OYHImFRJbKMyvy7EqFGmlZt1ADgfgQpehE/DWMJUoZ/309j3ixeasK+Cci5NP545EYv4fhiX7caS2iMEAno+K59EAsIiaReyL3CXvXhlZ7it5Z/GnL02ysyqLU/9pi+6ZBBotsO+y2ejGHAXjurvWd68kkDpgH2LuqxshI6pU5gtZRxix6e96ROZyjP1jaHqbO1OYPmIr100ZSh/JuPPUvhIULXCNyJBo/ibdiHlGnghR1W+pXrnLwXvt1M7gzRZg77SBU4mtqmc78S649yl0CfzvOYw0xBappU7MWhy0IIVtVbfXc7esUNiWT7WwI8Tk3EXt9f2QjlZC1HeWpQwHiVDT788uROXudVBRSBtL9Ec92Gbsqsats7U+s+t7qts7PW9gvmpR2jiNbwjBHC+syTQ54OjOnGpqGLNFgcFif4Glz1ywlMl5In/d+Hj13DcBsi/24znQ+3Q9cVrm3oezELsBEX6fpPd8i/JYOgp+36sUgquboHXO2SYVOWh8GoOd7hsQYw2KtME2lqbNJwVlMrJfN5v92ndApt582DNYRnakcCE9j4ZAuyz5urz8uK7Z0e9xXx+L/IFQ/EUd4K5T77u4lEGjfrGyZfv4p8MtGHnDRfJaqf7spwV15A4n9qp1kAPQCrWAvdBjTW/SdCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(2616005)(956004)(31696002)(6486002)(52116002)(316002)(66556008)(6666004)(66574015)(8676002)(110136005)(16576012)(478600001)(38350700002)(5660300002)(36756003)(86362001)(38100700002)(53546011)(31686004)(186003)(26005)(2906002)(16526019)(8936002)(66946007)(83380400001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YlFjbWpmbVp6RG9CVDZEVjZtZnhOc0JUSGhTL2p6YkRvSmV4TEJDSXdYVjdQ?=
 =?utf-8?B?MHpFdUVFMHNOMTdrN09QbXoyRXVpTEp4SXpaUElDaXhNSWlxTkhUMFYrUGtJ?=
 =?utf-8?B?Zm5Jd0txVmZkRXVvZVJOekM3UnRLREhqN2RrQnQ5Z0JUUFlaYWpldzhmM2pT?=
 =?utf-8?B?OUpVbWtsa0lxTVdiWTZTNU1WZXkzS0I1N1REU0VHVlRET0NUK2VRdGFISVdU?=
 =?utf-8?B?WUNySUwvMVltNVNncmpyTFQrSjJnQmZhU1B5aUEwOU4vVmpMOUpSVENoUVh4?=
 =?utf-8?B?QTVuaE9RR0JKVHdjRmthdlI3OXBlS0ZYWGFsV3p6OU5sc0ZqOW1hTlhaMzBt?=
 =?utf-8?B?WDdOdmRJUUVpWkdNcEJkOEFNd3ZmWFBmU3AzN3FpTkNCNFJudURLeUZoVG00?=
 =?utf-8?B?NW9NRkdNMFRYZnZlZHZsWndUeVFxb2R2RGJiYWlYOWdLbklrL1ArUHdFOFJK?=
 =?utf-8?B?YUtQZW5VQjBNU0x2MHVTQVZQMjJTQVJQTXp6WTZZRVJuSGRXOE9ESUl4UHFx?=
 =?utf-8?B?enlNZVZNOGxaNlBUVG54M1ZGVnhWWnRLeVZ2eDJpTkF1bXFab1BjV2RTbE1r?=
 =?utf-8?B?Y2lmK0tWdDhvTTgrVWNpUVJDR256bHBjRTFIQXB2VXhPcGtjY0VQZ2Y1SXhz?=
 =?utf-8?B?WG5qd291Ry9jR3pqK01TcXFiV0pLZlgzM3FKZlFQeFVKb05MQkdkN3NORWFO?=
 =?utf-8?B?M2NJQmR6VEhTWTcxUTJWVVZ4dFdyWHNSNEZRbDdYVWI3UlB1bVRvMDRBWU5v?=
 =?utf-8?B?ZkFRcUFCRG9XaDRZNG83a0JSR3p1VFRtZEQ0NEc1TG54bmk4R2dhdFhDZWgw?=
 =?utf-8?B?Vm1EaXdTbGhCSE96eklVYW51ai9zY2xmVHN6K1J4WEF6R2NMNGFBSlZLZ05C?=
 =?utf-8?B?Y3VkSmxRaHdJb01PbEplN1dxOS9PclpOTVpnMlkzc01OVGtBZGlYVEc4R3lQ?=
 =?utf-8?B?eHF0OEZadzZwVDhZMjBVNGZJbkM3M3NudUM0SU1HSFlMQmdBdVlBRXIvNFBE?=
 =?utf-8?B?L0ZDYVlYcTgvQloxZHRxR1M3eWxrQXJxYTM0alBsU1d0ZDh1ZnF6eWE3M1hw?=
 =?utf-8?B?UllHOC9kWUh2MW1ZS0VOVWdOS3RVMFlNNVpIV1FGM1NVdzdJK2NhVUtJNW9y?=
 =?utf-8?B?TDlRQSs0VlBFWGR2ZmR5b1crSGthNWNSVkZFWVI3SnVSQVNIMTZGeXBEcGZq?=
 =?utf-8?B?VXJCZEZodVhkQlhaUyt4QlRLR0IzNXcwUExheEkxT1VzbkpLZXNyU3pXM1Rq?=
 =?utf-8?B?QkdHci9BTkIzY0c5WG02eFRoRE5UY0ZwOGZxYXZMc3hMTjRhRU92OE9QVm5t?=
 =?utf-8?B?RW1pYnBOWVRDY0xtazdaNDZHRFZLczBTbUYrV3IvcDB2UndwSjMyY3lMQTlH?=
 =?utf-8?B?dmV2NVZnd2o1Sjk1bnBncisyTzc4UU81bmgwVnloNmpodEdpL1d0M1BYdXJn?=
 =?utf-8?B?Wkt4VFIrUjMvTjRwbUVyZGdvZmYwL3RyTGV3ZkZNZGIvK3MrSUJkWisxejU2?=
 =?utf-8?B?YnhTMkRiWVA3b1NncEVOZS9iTzZPTlc4QmE2emc0VjZrM0czZjZrQ21jbyts?=
 =?utf-8?B?Y3VQYlFETHhYNG1GYThnVEdNbStRVy9JMzRrTW9ZS1JMcUUzb2VYUFBZc0Mw?=
 =?utf-8?B?T2RLQVUrU3E2ZUVrNG5mc0Jzd01jTzZsbHNvOFgvZTNVRjJWbktSV2hKZUpq?=
 =?utf-8?B?N3A4dDFwYWtJWXdGWjl4MnY5UGI0MVAxSFg0c0EzMk5WUUMrd1ZOS0Voc242?=
 =?utf-8?Q?WfEvR5DLxS2KAvCfofL0ytKjYFh1D86M1zNgfTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f92d56-3599-471c-2514-08d925a4eae0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 09:00:49.6601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7OY8eQqmeVYiQp9g/D5SMor08U+RqDK/ftzvK2cfRC4Vlak4ibp1E4/P8HJCw0c5dtrrEaafiq2iqdO1DLUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
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

Ck9uIDYvMi8yMDIxIDEwOjU3IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAw
Mi4wNi4yMSB1bSAxMDo1NCBzY2hyaWViIERhcywgTmlybW95Ogo+Pgo+PiBPbiA2LzIvMjAyMSAx
MDozMCBBTSwgQ2hhbmdmZW5nIHdyb3RlOgo+Pj4gRnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5a
aHVAYW1kLmNvbT4KPj4+Cj4+PiBGcm9tOiBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNv
bT4KPj4+Cj4+PiBJdCB3aWxsIGNhdXNlIGVycm9yIHdoZW4gYWxsb2MgbWVtb3J5IGxhcmdlciB0
aGFuIDEyOEtCIGluCj4+PiBhbWRncHVfYm9fY3JlYXRlLT5remFsbG9jLgo+Pgo+Pgo+PiBJIHdv
bmRlciB3aHkgSSBkaWRuJ3Qgc2VlIHRoZSBlcnJvciBvbiBteSBtYWNoaW5lLiBJcyB0aGVyZSBh
bnkgCj4+IGNvbmZpZyBJIG1pZ2h0IGJlIG1pc3NpbmcgPwo+Cj4gVk0gcGFnZSB0YWJsZSBsYXlv
dXQgZGVwZW5kcyBvbiBoYXJkd2FyZSBnZW5lcmF0aW9uLCBBUFUgdnMgZEdQVSBhbmQgCj4ga2Vy
bmVsIGNvbW1hbmQgbGluZSBzZXR0aW5ncy4KCgpUaGFua3MgZm9yIGNsYXJpZnlpbmcsIENocmlz
dGlhbi4KCgo+Cj4gSSB0aGluayB3ZSBqdXN0IG5lZWQgdG8gc3dpdGNoIGFtZGdwdV9ib19jcmVh
dGUoKSBmcm9tIGt6YWxsb2MgdG8gCj4ga3ZtYWxsb2MgKGFuZCBrZnJlZSB0byBrdmZyZWUgaW4g
YW1kZ3B1X2JvX2Rlc3Ryb3kgb2YgY291cnNlKS4KPgo+IFNob3VsZG4ndCBiZSBtb3JlIHRoYW4g
YSB0d28gbGluZSBwYXRjaC4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+Cj4+IFRo
YW5rcywKPj4KPj4gTmlybW95Cj4+Cj4+PiBDYWxsIFRyYWNlOgo+Pj4gwqDCoMKgIGFsbG9jX3Bh
Z2VzX2N1cnJlbnQrMHg2YS8weGUwCj4+PiDCoMKgwqAga21hbGxvY19vcmRlcisweDMyLzB4YjAK
Pj4+IMKgwqDCoCBrbWFsbG9jX29yZGVyX3RyYWNlKzB4MWUvMHg4MAo+Pj4gwqDCoMKgIF9fa21h
bGxvYysweDI0OS8weDJkMAo+Pj4gwqDCoMKgIGFtZGdwdV9ib19jcmVhdGUrMHgxMDIvMHg1MDAg
W2FtZGdwdV0KPj4+IMKgwqDCoCA/IHhhc19jcmVhdGUrMHgyNjQvMHgzZTAKPj4+IMKgwqDCoCBh
bWRncHVfYm9fY3JlYXRlX3ZtKzB4MzIvMHg2MCBbYW1kZ3B1XQo+Pj4gwqDCoMKgIGFtZGdwdV92
bV9wdF9jcmVhdGUrMHhmNS8weDI2MCBbYW1kZ3B1XQo+Pj4gwqDCoMKgIGFtZGdwdV92bV9pbml0
KzB4MWZkLzB4NGQwIFthbWRncHVdCj4+Pgo+Pj4gQ2hhbmdlLUlkOiBJMjllNDc5ZGI0NWVhZDM3
YzM5NDQ5ZTg1NjU5OWZkNGY2YTBlMzRjZQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hhbmdmZW5nIDxD
aGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIHwgMjcgCj4+PiArKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+
Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IGluZGV4
IDE5MjNmMDM1NzEzYS4uNzE0ZDYxM2QwMjBiIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4+PiBAQCAtODk0LDYgKzg5NCwxMCBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9wdF9jcmVhdGUoc3RydWN0IAo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBudW1fZW50cmllcyA9IDA7Cj4+PiDCoCDCoMKgwqDCoMKgIGJwLmJv
X3B0cl9zaXplID0gc3RydWN0X3NpemUoKCp2bWJvKSwgZW50cmllcywgbnVtX2VudHJpZXMpOwo+
Pj4gK8KgwqDCoCBpZiAoYnAuYm9fcHRyX3NpemUgPiAzMipBTURHUFVfR1BVX1BBR0VfU0laRSkg
ewo+Pj4gK8KgwqDCoMKgwqDCoMKgIERSTV9JTkZPKCJDYW4ndCBhbGxvYyBtZW1vcnkgbGFyZ2Vy
IHRoYW4gMTI4S0IgYnkgdXNpbmcgCj4+PiBremFsbG9jIGluIGFtZGdwdV9ib19jcmVhdGVcbiIp
Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGJwLmJvX3B0cl9zaXplID0gc2l6ZW9mKHN0cnVjdCBhbWRn
cHVfYm9fdm0pOwo+Pj4gK8KgwqDCoCB9Cj4+PiDCoCDCoMKgwqDCoMKgIGlmICh2bS0+dXNlX2Nw
dV9mb3JfdXBkYXRlKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJwLmZsYWdzIHw9IEFNREdQVV9H
RU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7Cj4+PiBAQCAtOTY1LDE1ICs5NjksMTkgQEAg
c3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCAKPj4+IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fdm0gKnB0Owo+Pj4gwqDCoMKg
wqDCoCBpbnQgcjsKPj4+IMKgIC3CoMKgwqAgaWYgKGVudHJ5LT5iYXNlLmJvKSB7Cj4+PiAtwqDC
oMKgwqDCoMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwgPCBBTURHUFVfVk1fUFRCKQo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPQo+Pj4gLSB0b19hbWRncHVfYm9fdm0o
ZW50cnktPmJhc2UuYm8pLT5lbnRyaWVzOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5LT5lbnRyaWVzID0gTlVMTDsKPj4+IC3CoMKgwqDC
oMKgwqDCoCByZXR1cm4gMDsKPj4+ICvCoMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwgPCBBTURHUFVf
Vk1fUFRCICYmICFlbnRyeS0+ZW50cmllcykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IG51bV9lbnRyaWVzOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIG51bV9lbnRyaWVzID0gYW1kZ3B1X3Zt
X251bV9lbnRyaWVzKGFkZXYsIGN1cnNvci0+bGV2ZWwpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVu
dHJ5LT5lbnRyaWVzID0ga3ZtYWxsb2NfYXJyYXkobnVtX2VudHJpZXMsCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoKmVudHJ5LT5lbnRy
aWVzKSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEdGUF9LRVJORUwgfCBfX0dGUF9aRVJPKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWVudHJ5
LT5lbnRyaWVzKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+
PiDCoMKgwqDCoMKgIH0KPj4+IMKgICvCoMKgwqAgaWYgKGVudHJ5LT5iYXNlLmJvKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCByID0gYW1kZ3B1X3Zt
X3B0X2NyZWF0ZShhZGV2LCB2bSwgY3Vyc29yLT5sZXZlbCwgaW1tZWRpYXRlLCAmcHQpOwo+Pj4g
wqDCoMKgwqDCoCBpZiAocikKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4+IEBA
IC05ODQsMTAgKzk5Miw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3Qg
Cj4+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4gwqDCoMKgwqDCoCBwdF9ibyA9ICZwdC0+Ym87
Cj4+PiDCoMKgwqDCoMKgIHB0X2JvLT5wYXJlbnQgPSBhbWRncHVfYm9fcmVmKGN1cnNvci0+cGFy
ZW50LT5iYXNlLmJvKTsKPj4+IMKgwqDCoMKgwqAgYW1kZ3B1X3ZtX2JvX2Jhc2VfaW5pdCgmZW50
cnktPmJhc2UsIHZtLCBwdF9ibyk7Cj4+PiAtwqDCoMKgIGlmIChjdXJzb3ItPmxldmVsIDwgQU1E
R1BVX1ZNX1BUQikKPj4+IC3CoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IHB0LT5lbnRy
aWVzOwo+Pj4gLcKgwqDCoCBlbHNlCj4+PiAtwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMg
PSBOVUxMOwo+Pj4gwqAgwqDCoMKgwqDCoCByID0gYW1kZ3B1X3ZtX2NsZWFyX2JvKGFkZXYsIHZt
LCBwdCwgaW1tZWRpYXRlKTsKPj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+PiBAQCAtMTAxNyw2ICsx
MDIxLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyZWVfdGFibGUoc3RydWN0IAo+Pj4gYW1k
Z3B1X3ZtX3B0ICplbnRyeSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZWYo
JnNoYWRvdyk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+
YmFzZS5ibyk7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqAga3ZmcmVlKGVudHJ5LT5lbnRy
aWVzKTsKPj4+IMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPSBOVUxMOwo+Pj4gwqAgfQo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
