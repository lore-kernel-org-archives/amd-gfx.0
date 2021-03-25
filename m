Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B9C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7676061A0D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7676061A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263A46EB69;
	Thu, 25 Mar 2021 16:20:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BC36EB69
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA++aRdoafXUCzDdfEjU5P7Zlrq+gv2pakSZsyYPs3d1flTEpS7QJ2G1TrgX8Y/f0DfYcF1PrHMwEjoHndCX+wkQuGby4Ld5QSxc249QWjC9Mqbm2MjsM6Fru6hsVUWPD0k2hsHPZN2nOjF41c2gtyWslBd3V0KW3JDZCocqjZgFMqOll/oukHPhWLjfO1JhybA1tF+QR65v4/2wwqjfg6eCwWcIuwKYjILo+izcuPx7cU6tCSDSd5PVi2BmkDSDOn80j6BeKA3oXpK4ErPZbjwZTjjrV05ozSxpHgA0dVm82HX/R0Da4xhXZoPZ1TU/yIZgRKh1Iq/MGX/2e7UjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0VuZbaK3CF3579MF2vAbWv8vI1l6YhEUdLSkwTzXR0=;
 b=cqybzZSPX5W4PlB0jEMOLATMPhI9H/Eawa7WSYl6JNI+q/hAUVgQvcR+BaeQHkiJ+eKzDEoYiacfeLq8rtqQGGusgJTpv6/+QHJbx3kEOHF3O/L8Z8aGDbRxCANmI/TL2ndbFGvAUZDbZq/uTmvYVPR93vFeKsFCCGt0vu4YIJeqBIB5OYqnv8rexNIYCjJt227XUiqWnYVR/rRLT8iYETNZC1AJaTnxVRAJ9Pg/asoOwDwgtjVHL4TzbRPQOaIwwsg3WPQHcH8Gnsmq1jAOvEuCmDu9YFuWNdTbTKUfMPGrifqVFN1pIpDFYT9Ko6E7uySyeBQNSBCXNHgIlNneGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0VuZbaK3CF3579MF2vAbWv8vI1l6YhEUdLSkwTzXR0=;
 b=C6b/6OlZbVg3y8LpkFCcJ0kbb9RXT2wi7K4j/gBeW1RpXAwMpBgLFyjphjB39nfIJ/7N2Vs7SN9Ee1btQXX6vjhNPjW1tqHluXk8FKdQCymfFyszR2F3Ub/SMFUJQ151ZKwPCy/RE8/sDs7z1YaZYtTL0hBRTSfT9NsbGxklqYo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 16:20:08 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.036; Thu, 25 Mar 2021
 16:20:08 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
 <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
 <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a6b6ac1a-d3f2-379f-fc0e-3b10908abc46@amd.com>
Date: Thu, 25 Mar 2021 12:20:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:20:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e02985db-fff6-462f-e969-08d8efa9db64
X-MS-TrafficTypeDiagnostic: MN2PR12MB4255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42556CEFE2896FE71156F8F992629@MN2PR12MB4255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8u+EDLW68W3WPSWKhQ3kRMRmIHEbvjrgsTJHsFhRdVbRkP7REB+lbkBVop6rDvuJcP9Po61PKLFveIL+Un0GVUwIq5Iu8gqDMMSmyL74eQs+0Xckc7wIiFpKil+5dbXj6ssl6z6mTSLpmKBXNzWe69tv7GulitDFmZVgbLp6NiLgN85RPjmhSTSlAFmtMcYUC0xDwtk1j/CLH7znITXa/FtQCxdrp+D2TdeZsQarKwldFElb1S8xpkzhHZuGK+GZqGQJPDmvNtvM6t4xUr7JbkZTTpXKq4hWPDI97hm2YeC6ZkVid/bdwqSp8rp3coxZijb9MO+v8p0h+iF6sipt5MB5BPViIOijwuFpz6FBO6ybGxdKwg3oMEuQ5N5XyshUOdKnJ1WTi3DFjwyRZ8aFF1KETO0OnqLnU6D2mWyG3lEkdw74WFv8xKjWZUADRs9h0aqm8J4zlWAUKuG/taSNZ1cq1llQgwsQIr8zoP5bkhxg3NakkhJ8YWhfPNDZCe54OV9FKz1cvHGsoFs1d83JCO6kl2+UkkX3vTC0RjmiYANjj345Zpxj7clyf57ozuOa3M2o5c/D9EkfzydySiLuioioKiezghL1Q49Sz3l106P07mJtoWlN5VccCBwIfoC6ZMwFzvknyaNXuNWZPMfbyxhWBXLra2H1M7IJU4xILcurGOcN0le02MWglJxVGCzUoBWgeDXmlbkYE+ilt70QcvgqUkYOKtgqkmqiXhzouWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(66946007)(86362001)(66556008)(956004)(2616005)(66476007)(2906002)(44832011)(31686004)(478600001)(83380400001)(6666004)(16576012)(5660300002)(110136005)(186003)(26005)(6486002)(8936002)(38100700001)(66574015)(316002)(8676002)(36756003)(31696002)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QmNadlY3dHJCVFBSM05nVnEvQmhhbVdCZW11Y2J1TmJ1WWJ2NWN6MSs5Mzkx?=
 =?utf-8?B?cVJ2UjFJK1JpdW9sdHMwNVlVRGV3RnBoVkpFZ2pwVnVGWFcrcWxmbWtZTkRS?=
 =?utf-8?B?RDJFa1Z5eDJQekh1czhJYUpuY1RYWTNjeGd0YTBFMlkxc1l2NUdVMWV4dXFj?=
 =?utf-8?B?MUQ5T0w0SWxjaWRkMTFIc2ZXcFRUWStKMm9RL3R0WmtqL2ZYOFZhRERIUzNu?=
 =?utf-8?B?a0Rrdjk4UUJRV1ZSWVFUbVk4dkZKZVpYa2FZVVV1L05UUkN4bDVhOWU3VE5J?=
 =?utf-8?B?ZFBqMGo5ZXNOMU5ybjNQV2p2c2lQVmZtdXJjUC9McHFSWHJiQ2RJcjdKTzVB?=
 =?utf-8?B?ZnVGZWRYdE1ZNERBV0FiZ3E1S1pJUURLbThvZ0V3YXh3MWxzaWlrVWd3TGJD?=
 =?utf-8?B?MkU5NTh0Z3lGVnRYVTJHUlN5amcrVnpsM3RrclF5TGJjdUxla2hQSEVqZmZm?=
 =?utf-8?B?SzFpYnMyd3IxNFpUNEtEcS9WN3BvbFRJdWJYcEhQa203dWtCT3NBVmFjQmpq?=
 =?utf-8?B?b2hWeEpQNThZS0RPSityUFI0bDYrZnh3ZENJaFNLanFaZm5YTTkzUExkUXZQ?=
 =?utf-8?B?Z2pueHZUNHpqdlZpUVNySFRqVVk4RWs0RkpWZlBEZEN6WGlZRWZ0S3VScGVo?=
 =?utf-8?B?cHdWazZFUGJ5Q2RlakZubWVURlArc3dwaFlNRTVXTjE2VituZVFSYVBGclpX?=
 =?utf-8?B?SjNYS2svTGhaMGdGWVU0cDMvTzVIUHpNWVhrNkY4dDdndlpNZmgxUGZvc2U1?=
 =?utf-8?B?OTJ5QlNZZityamo4YXVTT1NVd3ROMk1NOGx4dU96YnJiNFllS216V3FVQ0Zo?=
 =?utf-8?B?MzlYVUY1R1ZZVHM4R3Bid1dzVmNQazgwdjVnMExmWTZCUkhZQldNbTNOMlFC?=
 =?utf-8?B?TitzSkR4djF3UDNSNFZocndhL3RYY2V6MWRHOFVZcUppMUFoeExjN3ZUT251?=
 =?utf-8?B?R2JNVlZyTzB1elcrVk41SEx2Yk1LTlMxaUt3YmhoaFZWVklMeEZvdlhpOXVy?=
 =?utf-8?B?aHFiTVdsUEU4YkJWNEZRSjVxUWh4N2tzcGhVa1NxSVRRT29yKzB4OXZ4b0Jp?=
 =?utf-8?B?aUtNMGVaSklkSW5FNGROODRMOVlDcjkyNVdRWlp1ZURhZUl5NVZ6ejRwcnZY?=
 =?utf-8?B?S0Z2NC9UVC9EaDVzYS90L0E3ODNjV1d1b2cwNCtGVDduODljdHVxeHZldHM3?=
 =?utf-8?B?MFR5MG1CZ3lSa01rV3RNQ083R2pINTBJL1dHbFR5YkhuSEpRQzdMY2JOa2Fy?=
 =?utf-8?B?YzZMYVNiMi9DWUFvbDBYMHlVaUkvWDlqbGtla09LVTI3QjUvSVF4cEZiSXNS?=
 =?utf-8?B?TWxsWndoclNGZ2FTZEw0M2VBL09Yb0RHWFQrU25CS2hVVkM1RExwZ3VIRUVL?=
 =?utf-8?B?eXMxYUJHOXFYYmVrUUk3am1UZER1L3NsSjU2aEE0b3pldTlaLzg3dVpNZ0x3?=
 =?utf-8?B?bEdzUjVXTmNWT2xmU215TmhpTWErbUJPRnZBY1BzSmZyY2pYTnV0NkVsUXRS?=
 =?utf-8?B?Q1RIYlZZVDZkNVlEaVBMaWhSWU00R0RRZG9NSGFCb1NwMU05M2VmVnJtS0p5?=
 =?utf-8?B?YnpCOEIzbytTb3NyY1pCMkp0NlJ5SHFuQXp4RFpjck0xOEFhOWkxcVY5Vm1i?=
 =?utf-8?B?YnVRdDdZSk5tZFV0dkhjbnRVSnIxSURmdTd1ZWdvckNMckhvTHBRSUZDdmo1?=
 =?utf-8?B?TDYzUlN4UFlzWjdNRGtKay9vQXBhK1RYaWV1enhRalU2WGxGZXYrakJjQ290?=
 =?utf-8?Q?xWy3aNyHVin8QLLnKd+5PiL9NKWqLiTH1QfCD0G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02985db-fff6-462f-e969-08d8efa9db64
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:20:08.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzkFTQfO+4VFwWSq3pQLKPZbIzCzr5D6HaE84+I2ldxP6lzJs358G+BifAa0N1x/VeLIWMfjZ9gLX1hVhGrq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

QW0gMjAyMS0wMy0yNSB1bSAxMjoxNiBwLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBB
bSAyNS4wMy4yMSB1bSAxNzoxNCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBBbSAyMDIxLTAz
LTI1IHVtIDEyOjEwIHAubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4KPj4+IEFtIDI1
LjAzLjIxIHVtIDE3OjAzIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+Pj4gSGksCj4+Pj4KPj4+
PiBUaGlzIGlzIGEgbG9uZyBvbmUgd2l0aCBhIHByb3Bvc2FsIGZvciBhIHByZXR0eSBzaWduaWZp
Y2FudAo+Pj4+IHJlZGVzaWduIG9mCj4+Pj4gaG93IHdlIGhhbmRsZSBtaWdyYXRpb25zIGFuZCBW
UkFNIG1hbmFnZW1lbnQgd2l0aCBITU0uIFRoaXMgaXMKPj4+PiBiYXNlZCBvbgo+Pj4+IG15IG93
biBkZWJ1Z2dpbmcgYW5kIHJlYWRpbmcgb2YgdGhlIG1pZ3JhdGVfdm1hIGhlbHBlcnMsIGFzIHdl
bGwgYXMKPj4+PiBBbGV4J3MgcHJvYmxlbXMgd2l0aCBtaWdyYXRpb25zIG9uIEErQS4gSSBob3Bl
IHdlIGNhbiBkaXNjdXNzIHRoaXMKPj4+PiBuZXh0Cj4+Pj4gTW9uZGF5IGFmdGVyIHlvdSd2ZSBo
YWQgc29tZSB0aW1lIGRvIGRpZ2VzdCBpdC4KPj4+Pgo+Pj4+IEkgZGlkIHNvbWUgZGVidWdnaW5n
IHllc3RlcmRheSBhbmQgZm91bmQgdGhhdCBtaWdyYXRpb25zIHRvIFZSQU0gY2FuCj4+Pj4gZmFp
bCBmb3Igc29tZSBwYWdlcy4gVGhlIGN1cnJlbnQgbWlncmF0aW9uIGhlbHBlcnMgaGF2ZSBtYW55
IGNvcm5lcgo+Pj4+IGNhc2VzIHdoZXJlIGEgcGFnZSBjYW5ub3QgYmUgbWlncmF0ZWQuIFNvbWUg
b2YgdGhlbSBtYXkgYmUgZml4YWJsZQo+Pj4+IChhZGRpbmcgc3VwcG9ydCBmb3IgVEhQKSwgb3Ro
ZXJzIGFyZSBub3QgKGxvY2tlZCBwYWdlcyBhcmUgc2tpcHBlZCB0bwo+Pj4+IGF2b2lkIGRlYWRs
b2NrcykuIFRoZXJlZm9yZSBJIHRoaW5rIG91ciBjdXJyZW50IGNvZGUgaXMgdG9vIGluZmxleGli
bGUKPj4+PiB3aGVuIGl0IGFzc3VtZXMgdGhhdCBhIHJhbmdlIGlzIGVudGlyZWx5IGluIG9uZSBw
bGFjZS4KPj4+Pgo+Pj4+IEFsZXggYWxzbyByYW4gaW50byBzb21lIGZ1bm55IGlzc3VlcyB3aXRo
IENPVyBvbiBBK0Egd2hlcmUgc29tZSBwYWdlcwo+Pj4+IGdldCBmYXVsdGVkIGJhY2sgdG8gc3lz
dGVtIG1lbW9yeS4gSSB0aGluayBhIGxvdCBvZiB0aGUgcHJvYmxlbXMgaGVyZQo+Pj4+IHdpbGwg
Z2V0IGVhc2llciBvbmNlIHdlIHN1cHBvcnQgbWl4ZWQgbWFwcGluZ3MuCj4+Pj4KPj4+PiBNaXhl
ZCBHUFUgbWFwcGluZ3MKPj4+PiA9PT09PT09PT09PQo+Pj4+Cj4+Pj4gVGhlIGlkZWEgaXMsIHRv
IHJlbW92ZSBhbnkgYXNzdW1wdGlvbnMgdGhhdCBhbiBlbnRpcmUgc3ZtX3JhbmdlIGlzIGluCj4+
Pj4gb25lIHBsYWNlLiBJbnN0ZWFkIGhtbV9yYW5nZV9mYXVsdCBnaXZlcyB1cyBhIGxpc3Qgb2Yg
cGFnZXMsIHNvbWUgb2YKPj4+PiB3aGljaCBhcmUgc3lzdGVtIG1lbW9yeSBhbmQgb3RoZXJzIGFy
ZSBkZXZpY2VfcHJpdmF0ZSBvcgo+Pj4+IGRldmljZV9nZW5lcmljLgo+Pj4+Cj4+Pj4gV2Ugd2ls
bCBuZWVkIGFuIGFtZGdwdV92bSBpbnRlcmZhY2UgdGhhdCBsZXRzIHVzIG1hcCBtaXhlZCBwYWdl
IGFycmF5cwo+Pj4+IHdoZXJlIGRpZmZlcmVudCBwYWdlcyB1c2UgZGlmZmVyZW50IFBURSBmbGFn
cy4gV2UgY2FuIGhhdmUgYXQgbGVhc3QgMwo+Pj4+IGRpZmZlcmVudCB0eXBlcyBvZiBwYWdlcyBp
biBvbmUgbWFwcGluZzoKPj4+Pgo+Pj4+IMKgwqAgMS4gU3lzdGVtIG1lbW9yeSAoUy1iaXQgc2V0
KQo+Pj4+IMKgwqAgMi4gTG9jYWwgbWVtb3J5IChTLWJpdCBjbGVhcmVkLCBNVFlQRSBmb3IgbG9j
YWwgbWVtb3J5KQo+Pj4+IMKgwqAgMy4gUmVtb3RlIFhHTUkgbWVtb3J5IChTLWJpdCBjbGVhcmVk
LCBNVFlQRStDIGZvciByZW1vdGUgbWVtb3J5KQo+Pj4+Cj4+Pj4gTXkgaWRlYSBpcyB0byBjaGFu
Z2UgdGhlIGFtZGdwdV92bV91cGRhdGVfbWFwcGluZyBpbnRlcmZhY2UgdG8gdXNlCj4+Pj4gc29t
ZQo+Pj4+IGhpZ2gtYml0IGluIHRoZSBwYWdlc19hZGRyIGFycmF5IHRvIGluZGljYXRlIHRoZSBw
YWdlIHR5cGUuIEZvciB0aGUKPj4+PiBkZWZhdWx0IHBhZ2UgdHlwZSAoMCkgbm90aGluZyByZWFs
bHkgY2hhbmdlcyBmb3IgdGhlIGNhbGxlcnMuIFRoZQo+Pj4+ICJmbGFncyIgcGFyYW1ldGVyIG5l
ZWRzIHRvIGJlY29tZSBhIHBvaW50ZXIgdG8gYW4gYXJyYXkgdGhhdCBnZXRzCj4+Pj4gaW5kZXhl
ZCBieSB0aGUgaGlnaCBiaXRzIGZyb20gdGhlIHBhZ2VzX2FkZHIgYXJyYXkuIEZvciBleGlzdGlu
Zwo+Pj4+IGNhbGxlcnMKPj4+PiBpdCdzIGFzIGVhc3kgYXMgY2hhbmdpbmcgZmxhZ3MgdG8gJmZs
YWdzIChhcnJheSBvZiBzaXplIDEpLiBGb3IgSE1NIHdlCj4+Pj4gd291bGQgcGFzcyBhIHBvaW50
ZXIgdG8gYSByZWFsIGFycmF5Lgo+Pj4gWWVhaCwgSSd2ZSB0aG91Z2h0IGFib3V0IHN0dWZmIGxp
a2UgdGhhdCBhcyB3ZWxsIGZvciBhIHdoaWxlLgo+Pj4KPj4+IFByb2JsZW0gaXMgdGhhdCB0aGlz
IHdvbid0IHdvcmsgdGhhdCBlYXNpbHkuIFdlIGFzc3VtZSBhdCBtYW55IHBsYWNlcwo+Pj4gdGhh
dCB0aGUgZmxhZ3MgZG9lc24ndCBjaGFuZ2UgZm9yIHRoZSByYW5nZSBpbiBxdWVzdGlvbi4KPj4g
SSB0aGluayBzb21lIGxvd2VyIGxldmVsIGZ1bmN0aW9ucyBhc3N1bWUgdGhhdCB0aGUgZmxhZ3Mg
c3RheSB0aGUgc2FtZQo+PiBmb3IgcGh5c2ljYWxseSBjb250aWd1b3VzIHJhbmdlcy4gQnV0IGlm
IHlvdSB1c2UgdGhlIGhpZ2gtYml0cyB0byBlbmNvZGUKPj4gdGhlIHBhZ2UgdHlwZSwgdGhlIHJh
bmdlcyB3b24ndCBiZSBjb250aWd1b3VzIGFueSBtb3JlLiBTbyB5b3UgY2FuCj4+IGNoYW5nZSBw
YWdlIGZsYWdzIGZvciBkaWZmZXJlbnQgY29udGlndW91cyByYW5nZXMuCj4KPiBZZWFoLCBidXQg
dGhlbiB5b3UgYWxzbyBnZXQgYWJzb2x1dGVseSB6ZXJvIFRIUCBhbmQgZnJhZ21lbnQgZmxhZ3MK
PiBzdXBwb3J0LgoKQXMgbG9uZyBhcyB5b3UgaGF2ZSBhIGNvbnRpZ3VvdXMgMk1CIHBhZ2Ugd2l0
aCB0aGUgc2FtZSBwYWdlIHR5cGUsIEkKdGhpbmsgeW91IGNhbiBzdGlsbCBnZXQgYSBUSFAgbWFw
cGluZyBpbiB0aGUgR1BVIHBhZ2UgdGFibGUuIEJ1dCBpZiBvbmUKcGFnZSBpbiB0aGUgbWlkZGxl
IG9mIGEgMk1CIHBhZ2UgaGFzIGEgZGlmZmVyZW50IHBhZ2UgdHlwZSwgdGhhdCB3aWxsCmJyZWFr
IHRoZSBUSFAgbWFwcGluZywgYXMgaXQgc2hvdWxkLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4g
QnV0IEkgdGhpbmsgd2UgY291bGQgYWxzbyBhZGQgdGhvc2UgbGF0ZXIgb24uCj4KPiBSZWdhcmRz
LAo+IENocmlzdGlhbi4KPgo+Pgo+PiBSZWdhcmRzLAo+PiDCoMKgIEZlbGl4Cj4+Cj4+Cj4+PiBX
ZSB3b3VsZCBzb21laG93IG5lZWQgdG8gY2hhbmdlIHRoYXQgdG8gZ2V0IHRoZSBmbGFncyBkaXJl
Y3RseSBmcm9tCj4+PiB0aGUgbG93IGJpdHMgb2YgdGhlIERNQSBhZGRyZXNzIG9yIHNvbWV0aGlu
ZyBpbnN0ZWFkLgo+Pj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4gT25jZSB0aGlzIGlzIGRvbmUs
IGl0IGxlYWRzIHRvIGEgbnVtYmVyIG9mIG9wcG9ydHVuaXRpZXMgZm9yCj4+Pj4gc2ltcGxpZmlj
YXRpb24gYW5kIGJldHRlciBlZmZpY2llbmN5IGluIGtmZF9zdm06Cj4+Pj4KPj4+PiDCoMKgwqAg
KiBTdXBwb3J0IG1pZ3JhdGlvbiB3aGVuIGNwYWdlcyAhPSBucGFnZXMKPj4+PiDCoMKgwqAgKiBN
aWdyYXRlIGEgcGFydCBvZiBhbiBzdm1fcmFuZ2Ugd2l0aG91dCBzcGxpdHRpbmcgaXQuIE5vIG1v
cmUKPj4+PiDCoMKgwqDCoMKgIHNwbGl0dGluZyBvZiByYW5nZXMgaW4gQ1BVIHBhZ2UgZmF1bHRz
Cj4+Pj4gwqDCoMKgICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIGluIEdQVSBwYWdl
IGZhdWx0IGhhbmRsZXIuIE5vCj4+Pj4gbW9yZQo+Pj4+IMKgwqDCoMKgwqAgbWlncmF0aW5nIHRo
ZSB3aG9sZSByYW5nZSBmb3IgYSBzaW5nbGUgcGFnZSBmYXVsdAo+Pj4+IMKgwqDCoCAqIFNpbXBs
aWZpZWQgVlJBTSBtYW5hZ2VtZW50IChzZWUgYmVsb3cpCj4+Pj4KPj4+PiBXaXRoIHRoYXQsIHN2
bV9yYW5nZSB3aWxsIG5vIGxvbmdlciBoYXZlIGFuICJhY3R1YWxfbG9jIiBmaWVsZC4gSWYKPj4+
PiB3ZSdyZQo+Pj4+IG5vdCBzdXJlIHdoZXJlIHRoZSBkYXRhIGlzLCB3ZSBuZWVkIHRvIGNhbGwg
bWlncmF0ZS4gSWYgaXQncwo+Pj4+IGFscmVhZHkgaW4KPj4+PiB0aGUgcmlnaHQgcGxhY2UsIHRo
ZW4gY3BhZ2VzIHdpbGwgYmUgMCBhbmQgd2UgY2FuIHNraXAgYWxsIHRoZSBzdGVwcwo+Pj4+IGFm
dGVyIG1pZ3JhdGVfdm1hX3NldHVwLgo+Pj4+Cj4+Pj4gU2ltcGxpZmllZCBWUkFNIG1hbmFnZW1l
bnQKPj4+PiA9PT09PT09PT09PT09PQo+Pj4+Cj4+Pj4gVlJBTSBCT3MgYXJlIG5vIGxvbmdlciBh
c3NvY2lhdGVkIHdpdGggcHJhbmdlcy4gSW5zdGVhZCB0aGV5IGFyZQo+Pj4+ICJmcmVlLWZsb2F0
aW5nIiwgYWxsb2NhdGVkIGR1cmluZyBtaWdyYXRpb24gdG8gVlJBTSwgd2l0aCByZWZlcmVuY2UK
Pj4+PiBjb3VudCBmb3IgZWFjaCBwYWdlIHRoYXQgdXNlcyB0aGUgQk8uIFJlZiBpcyByZWxlYXNl
ZCBpbiBwYWdlLXJlbGVhc2UKPj4+PiBjYWxsYmFjay4gV2hlbiB0aGUgcmVmIGNvdW50IGRyb3Bz
IHRvIDAsIGZyZWUgdGhlIEJPLgo+Pj4+Cj4+Pj4gVlJBTSBCTyBzaXplIHNob3VsZCBtYXRjaCB0
aGUgbWlncmF0aW9uIGdyYW51bGFyaXR5LCAyTUIgYnkgZGVmYXVsdC4KPj4+PiBUaGF0IHdheSB0
aGUgQk8gY2FuIGJlIGZyZWVkIHdoZW4gbWVtb3J5IGdldHMgbWlncmF0ZWQgb3V0LiBJZgo+Pj4+
IG1pZ3JhdGlvbgo+Pj4+IG9mIHNvbWUgcGFnZXMgZmFpbHMgdGhlIEJPIG1heSBub3QgYmUgZnVs
bHkgb2NjdXBpZWQuIEFsc28gc29tZSBwYWdlcwo+Pj4+IG1heSBiZSByZWxlYXNlZCBpbmRpdmlk
dWFsbHkgb24gQStBIGR1ZSB0byBDT1cgb3Igb3RoZXIgZXZlbnRzLgo+Pj4+Cj4+Pj4gRXZpY3Rp
b24gbmVlZHMgdG8gbWlncmF0ZSBhbGwgdGhlIHBhZ2VzIHN0aWxsIHVzaW5nIHRoZSBCTy4gSWYg
dGhlIEJPCj4+Pj4gc3RydWN0IGtlZXBzIGFuIGFycmF5IG9mIHBhZ2UgcG9pbnRlcnMsIHRoYXQn
cyBiYXNpY2FsbHkgdGhlCj4+Pj4gbWlncmF0ZS5zcmMKPj4+PiBmb3IgdGhlIGV2aWN0aW9uLiBN
aWdyYXRpb24gY2FsbHMgInRyeV90b191bm1hcCIsIHdoaWNoIGhhcyB0aGUgYmVzdAo+Pj4+IGNo
YW5jZSBvZiBmcmVlaW5nIHRoZSBCTywgZXZlbiB3aGVuIHNoYXJlZCBieSBtdWx0aXBsZSBwcm9j
ZXNzZXMuCj4+Pj4KPj4+PiBJZiB3ZSBjYW5ub3QgZ3VhcmFudGVlIGV2aWN0aW9uIG9mIHBhZ2Vz
LCB3ZSBjYW5ub3QgdXNlIFRUTSBmb3IgVlJBTQo+Pj4+IGFsbG9jYXRpb25zLiBOZWVkIHRvIHVz
ZSBhbWRncHVfdnJhbV9tZ3IuIE5lZWQgYSB3YXkgdG8gZGV0ZWN0IG1lbW9yeQo+Pj4+IHByZXNz
dXJlIHNvIHdlIGNhbiBzdGFydCBldmljdGluZyBtZW1vcnkuCj4+Pj4KPj4+PiBSZWdhcmRzLAo+
Pj4+IMKgwqDCoCBGZWxpeAo+Pj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
