Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A4AC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 20:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFC36121F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 20:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFC36121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A539389CCB;
	Mon, 12 Apr 2021 20:01:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EAEB89CCB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 20:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elo7Omml+G7IUl4WH+TZwTs4UHbIHFXIB8m536D5TyHYnU+SwbVfhNqPMNfNEpnDTdNBbEUSDckeLTod6L0Wf9+XAyDpCLf+ZmfCSnrJ6DQQeHPrwdXIo5P1eCW+uDcScBVh07FXdZbNhLcvBbuYfrFRpB5lAyF1tdAx7of42rX5aFVGb6iKo3a4php5SjblDZpERXvH6uNGylDdWd1DLQzmrr6GZ9bVIXsN3uV8RcYyjtA640NP/4y3mc+FHNzas9Zn/DOfZmOucNwLX6fl6XZio/ZPKPNqOc6BWUC5/Q9Em0+/GM4V8C0Lvitk7whp7vvpKch358hSS4VULLrVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBjgbvKVGgRl1PwRtJ98/eEqqQNYlfnNuxmBXrl5VZ8=;
 b=nBNq7IPcLA2In8N/jauas+dtqw0k3npCQ5OFQDGBgbUdKHtvsL3BfeZruBtzsRK+kkDpnMDkfqVawVWIUomIwFVrdGApd9rTLBx+qP4Mm/vWfjSEDJa1SilXoy+PeRbiYA6aQK2TTLV4lqVirXY5f851sbc0Bap/bLY7+1/JhcvgHg1MO2RtZNaWVFBP6CmgtGLrASy3ZyROljK6bXQdtF68qLig+qpXT6puJmpH1S9rm2ogct2tm3aonj95a/uBORhSRa9zvZHXNobTzSgUrPPHSSN+/pWRl38c4pXnQt9suWofTHKO7D5rYAOCRaIdStl/4+GdKmQ/T/x2SP+OYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBjgbvKVGgRl1PwRtJ98/eEqqQNYlfnNuxmBXrl5VZ8=;
 b=1SNAk01FNaln6okvTfrXKno4NVaTjBnCfTUxXnwD/M/Lyhmdo//Nuu8z9f4b6EYGIAUZ9kek4VxYGV2KbBIWrNwS9Wu12k6mTt9QtrUJBql4Rkm9o63336+bG5n5xLwxQihxeQUVrR/PJYFn/k939qMgsqp4H/q/IH9yLK0VfzQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 20:01:11 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 20:01:10 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
Date: Mon, 12 Apr 2021 16:01:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
 (2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Mon, 12 Apr 2021 20:01:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b66f264-a456-473d-f204-08d8fdedb7d5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44948699A8ACA351A83B09F1EA709@SA0PR12MB4494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jP0s2BSL4TsQ1pdb0Vb9jbvw/IdDtZsj7P2G0UxloRHTofnUc/aNWObbDshEKdzhhF64cUxEkGttvnQdPFp02UrlZnLr7FTl4GXeMLfFa3Ky8r+fsXCvvAA2Wx0sf85nD2OIivoi7l3r03s1neeXSC7G62Evp2+tOULAHDz6ZkwhyjmA9nCDa16ookSMBszDlthV/EWSoXPKE9Q3wwYAuSn4gtkn3YrqAzYUWY4rb7aj7NFUw0qdpv646GNkB+J1XpaAn4kNXs/mK3D1sAakY+soztQiTaRmHp7IMSxxX4wPxodWDAo79De5nweu0FzGQZ+J7N11QqTyF+0xcUmaTyAfvq+RcJ5en9yc8TMb0PZE+qcNpaRsv3Fx6LlhFw9Ssxt4W0N6hPTjHDLlTjhlFqpr4oGIf3HjdJxMFZJK3MNNUdk+BpI9gOqP73EgAOTGXoDkI1c9+rF8xZlCleEsS1SHCA+HA+DUnCOHCnj8YC2GjqaWAg1E6TZ/s0DrppEBnK0fi/N44EY94mR9nGRlR82welbRZeEfwS+kMBsGXyiwVSNGgsXVKhmYVEB5mAgCIYJ9LhTd4Zp/Jx+v2yImx7QpyhfrsRiI4jtypQ+ZLhZ415v+6pG2gCCkZCqb92KsiQTpteFVwI/n9XJTkCKuCrfIu3wFNOC6V120opeSYB4K+R8nYABOLYB5JN9PmNhvwfBd+p1GmzAGLw+TlCT0Av25zv+BTcXLjyjxiXrw7gQTpu9k+Dfgho7nJg0TKxyNOxMQZYi0WduvURBJW/pnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(66946007)(66476007)(66556008)(66574015)(110136005)(8676002)(36756003)(6636002)(16526019)(186003)(2616005)(31686004)(8936002)(316002)(6486002)(2906002)(44832011)(52116002)(478600001)(45080400002)(31696002)(86362001)(966005)(921005)(6666004)(83380400001)(53546011)(5660300002)(38100700002)(60764002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emIvbmc5ajhmNkFMNkdhVzdXNUFnR3FoUElmNDdMcnpBWFRoaVovZDN4NS9n?=
 =?utf-8?B?ODZVY2l5MVFDZHQ3bFQrcW5kTlJoL0hkZG8ycjdUTUtaRXE4R1prT0lXTzNZ?=
 =?utf-8?B?Y3d1c2lZSmJJUDl5VWM1ZWJpcjA1RXBMQXhtNWV1RkszSm9JbEVRYTNNYXJt?=
 =?utf-8?B?RjNUNnByRVNUQzFMbDIrVmQzaTc5d1lJYjVOUnJJLytERmV0VnZzK2lOaWJP?=
 =?utf-8?B?UnhFMTZsYS9PRWtTVXFXNkYxanJybWVjV2ZBYkpEcjFEaVhHNE1pS0g5T2FV?=
 =?utf-8?B?N3k1U1hEYmxuazErZE9XamtNZ3F2VTJVY1pnS3BVNVVkTTkzL2hmMHllMlNC?=
 =?utf-8?B?TkJRUXFUMlY3Mmc0dm9ZbW80alUrWGR0U01UbTRZbzdaUXdEa1NYTmRtMzgr?=
 =?utf-8?B?NWNrcmpBYlZJT1Fwb0JhRStsWCtkc0Fib2JzOVN1WWlpMHFrRXExWXlNU0VR?=
 =?utf-8?B?L3Nxa0RkcUg0elJqd3RuS0phOHZpczlxTS9FcGJZTGZIOHRFcGs3OUo0QWZL?=
 =?utf-8?B?Vmp2YUVPRzhEZ3dhSWQrRHZ1SGc3TmZmMXNjdWRvd01GQkY5d2JCUzh6WWFi?=
 =?utf-8?B?MHZpMWtsekE1dVdXWmpnanVBWmE5S256RHg3OXUwR2ZMVnh2dWwzSEY5aWxK?=
 =?utf-8?B?bW9QcTZac1pDenhYSjVDTDZnUlkrRktQVTROakxKbEhqdlpCRjRMNVNYTlMx?=
 =?utf-8?B?K1lEWk9ocVN4MEZrQlF4emlqYXJiMjVLUDRIREVKcGM5S3ZBaVN6VXFnc3Fm?=
 =?utf-8?B?MW12Y0N5Nzc2ZmV1WGpodmlXaWR2cy80R1V6ZUFpVkE0R0g4UlVxQTFoaDNX?=
 =?utf-8?B?cUI3WUJHNmJJc0J1UUI1T0t1SVJJMUFLUlVKRzhncWFXWTlyYzFEZGFQK2JG?=
 =?utf-8?B?OVAxVzdoT3NLTFB1Tm5YTk9rOEFoSWZ2c3Nyc00vdHBJUVd4TzV0NFY4SEVa?=
 =?utf-8?B?VmpuQ1JkUU9LN2RhSGxlc3orcERuQ1ZiR05GNS93V2ZPN3FpMktaRWJFd0RM?=
 =?utf-8?B?OThpL0NXaXJEbFRBaEs1Y21QYUE1ZGNhbjZMRW1VSi80MUNmUU04L3V0aGdR?=
 =?utf-8?B?WHFIc0ZDMklRQzZxWWRVbjJNOEt3dW9taWxOdXhRMEZmU2tKWGUvRUZYd2NV?=
 =?utf-8?B?ZlJwZ0JVdG1BakhyVmZoODRwb3JnNmpVSXJOalpCWFBtU0FOckRJZVFLK0pm?=
 =?utf-8?B?eDdvNDVUOXVUcUR2YkNTcU1XWHdNZ3dUaHhFOGdFQWdKSkU0UEx4ZHY5enpx?=
 =?utf-8?B?c0loZHVMUkJpTzRRbFhNaytKcHJiQ0FPZzFzZG5rcUVYYkJYZWROWTRmeisz?=
 =?utf-8?B?Vlczbml2NjY1SGNsakp1RldmMDJzRHhkMnA3SDg0T1owbzBJMlZTZ0dycVlp?=
 =?utf-8?B?OVRJQ1hXS3BlTHQveGZ6bXkvUVdXdVpBc0FjYmt0dFhJVXNFRjVCenI2d3NC?=
 =?utf-8?B?eEZUK2VPNDhuajVEME8vN3JOaCtQRXBDc0xwOW50UGE2WnNzZG9ldG9TNHJ6?=
 =?utf-8?B?VE9yMUR2U2l1SEdJOE0rRzRKQThxUE1hZWFNdGtLeEs2czQ5Rm5nMktiT3dC?=
 =?utf-8?B?VlhGd0xnekR3Rk1uN3YxMkVteFBqSjR3UVh5K0dpaVRRdDBZOWplbUgrZGk5?=
 =?utf-8?B?MC8zREN3bkxINGpkbk1BMkpEOG85WWZSRXNpUmF1WlBLUllnVjAzQTZpbnNz?=
 =?utf-8?B?YkdxOGU5MXNwQ00rcUY3NktPTzdpbUw0R3RsTUcwSkhrTCtkYTF4WlBpQWJu?=
 =?utf-8?B?OTNoL0dBaGRKaE5hdGp2MjQ1Rng0b0dmYS90Qk5UZzdHT29kazhXSEU2RzRD?=
 =?utf-8?B?SzZaWHRvMXJmSXg1bzB4c2RYS1dPRGRmRjVzMTRTUmhINTRBUC9vQ1lUZVhH?=
 =?utf-8?Q?/5Uny3tGt1Zsn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b66f264-a456-473d-f204-08d8fdedb7d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 20:01:10.8082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgyqQurdoj7F1nJXpcKEutXcvDmHCBX+r6QKaQpgVsX9Pr7kz/m+fzRYn/WhxHU8fa30J0NHC+Zo0mXzsswn2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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

Ck9uIDIwMjEtMDQtMTIgMzoxOCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEy
LjA0LjIxIHVtIDIxOjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+IFtTTklQXQo+Pj4+
Cj4+Pj4gU28gd2hhdCdzIHRoZSByaWdodCBhcHByb2FjaCA/IEhvdyB3ZSBndWFyYW50ZWUgdGhh
dCB3aGVuIHJ1bm5pbmcgCj4+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9u
IHdlIHdpbGwgc2lnbmFsIGFsbCB0aGUgSFcgCj4+Pj4gZmVuY2VzIGFuZCBub3QgcmFjaW5nIGFn
YWluc3Qgc29tZSBtb3JlIGZlbmNlcyBpbnNlcnRpb24gaW50byB0aGF0IAo+Pj4+IGFycmF5ID8K
Pj4+Pgo+Pj4KPj4+IFdlbGwgSSB3b3VsZCBzdGlsbCBzYXkgdGhlIGJlc3QgYXBwcm9hY2ggd291
bGQgYmUgdG8gaW5zZXJ0IHRoaXMgCj4+PiBiZXR3ZWVuIHRoZSBmcm9udCBlbmQgYW5kIHRoZSBi
YWNrZW5kIGFuZCBub3QgcmVseSBvbiBzaWduYWxpbmcgCj4+PiBmZW5jZXMgd2hpbGUgaG9sZGlu
ZyB0aGUgZGV2aWNlIHNyY3UuCj4+Cj4+Cj4+IE15IHF1ZXN0aW9uIGlzLCBldmVuIG5vdywgd2hl
biB3ZSBydW4gCj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZmluaV9ody0+YW1kZ3B1X2ZlbmNlX3dh
aXRfZW1wdHkgb3IgCj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZmluaV9ody0+YW1kZ3B1X2ZlbmNl
X2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uLCAKPj4gd2hhdCB0aGVyZSBwcmV2ZW50cyBhIHJhY2Ug
d2l0aCBhbm90aGVyIGZlbmNlIGJlaW5nIGF0IHRoZSBzYW1lIHRpbWUgCj4+IGVtaXR0ZWQgYW5k
IGluc2VydGVkIGludG8gdGhlIGZlbmNlIGFycmF5ID8gTG9va3MgbGlrZSBub3RoaW5nLgo+Pgo+
Cj4gRWFjaCByaW5nIGNhbiBvbmx5IGJlIHVzZWQgYnkgb25lIHRocmVhZCBhdCB0aGUgc2FtZSB0
aW1lLCB0aGlzIAo+IGluY2x1ZGVzIGVtaXR0aW5nIGZlbmNlcyBhcyB3ZWxsIGFzIG90aGVyIHN0
dWZmLgo+Cj4gRHVyaW5nIEdQVSByZXNldCB3ZSBtYWtlIHN1cmUgbm9ib2R5IHdyaXRlcyB0byB0
aGUgcmluZ3MgYnkgc3RvcHBpbmcgCj4gdGhlIHNjaGVkdWxlciBhbmQgdGFraW5nIHRoZSBHUFUg
cmVzZXQgbG9jayAoc28gdGhhdCBub2JvZHkgZWxzZSBjYW4gCj4gc3RhcnQgdGhlIHNjaGVkdWxl
ciBhZ2FpbikuCgoKV2hhdCBhYm91dCBkaXJlY3Qgc3VibWlzc2lvbnMgbm90IHRocm91Z2ggc2No
ZWR1bGVyIC0gCmFtZGdwdV9qb2Jfc3VibWl0X2RpcmVjdCwgSSBkb24ndCBzZWUgaG93IHRoaXMg
aXMgcHJvdGVjdGVkLgoKCj4KPj4+Cj4+PiBCVFc6IENvdWxkIGl0IGJlIHRoYXQgdGhlIGRldmlj
ZSBTUkNVIHByb3RlY3RzIG1vcmUgdGhhbiBvbmUgZGV2aWNlIAo+Pj4gYW5kIHdlIGRlYWRsb2Nr
IGJlY2F1c2Ugb2YgdGhpcz8KPj4KPj4KPj4gSSBoYXZlbid0IGFjdHVhbGx5IGV4cGVyaWVuY2Vk
IGFueSBkZWFkbG9jayB1bnRpbCBub3cgYnV0LCB5ZXMsIAo+PiBkcm1fdW5wbHVnX3NyY3UgaXMg
ZGVmaW5lZCBhcyBzdGF0aWMgaW4gZHJtX2Rydi5jIGFuZCBzbyBpbiB0aGUgCj4+IHByZXNlbmNl
wqAgb2YgbXVsdGlwbGUgZGV2aWNlcyBmcm9tIHNhbWUgb3IgZGlmZmVyZW50IGRyaXZlcnMgd2Ug
aW4gCj4+IGZhY3QgYXJlIGRlcGVuZGVudCBvbiBhbGwgdGhlaXIgY3JpdGljYWwgc2VjdGlvbnMg
aSBndWVzcy4KPj4KPgo+IFNoaXQsIHllYWggdGhlIGRldmlsIGlzIGEgc3F1aXJyZWwuIFNvIGZv
ciBBK0kgbGFwdG9wcyB3ZSBhY3R1YWxseSAKPiBuZWVkIHRvIHN5bmMgdGhhdCB1cCB3aXRoIERh
bmllbCBhbmQgdGhlIHJlc3Qgb2YgdGhlIGk5MTUgZ3V5cy4KPgo+IElJUkMgd2UgY291bGQgYWN0
dWFsbHkgaGF2ZSBhbiBhbWRncHUgZGV2aWNlIGluIGEgZG9ja2luZyBzdGF0aW9uIAo+IHdoaWNo
IG5lZWRzIGhvdHBsdWcgYW5kIHRoZSBkcml2ZXIgbWlnaHQgZGVwZW5kIG9uIHdhaXRpbmcgZm9y
IHRoZSAKPiBpOTE1IGRyaXZlciBhcyB3ZWxsLgoKCkNhbid0IHdlIHByb3Bvc2UgYSBwYXRjaCB0
byBtYWtlIGRybV91bnBsdWdfc3JjdSBwZXIgZHJtX2RldmljZSA/IEkgCmRvbid0IHNlZSB3aHkg
aXQgaGFzIHRvIGJlIGdsb2JhbCBhbmQgbm90IHBlciBkZXZpY2UgdGhpbmcuCgpBbmRyZXkKCgo+
Cj4gQ2hyaXN0aWFuLgo+Cj4+IEFuZHJleQo+Pgo+Pgo+Pj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+
Pj4gQW5kcmV5Cj4+Pj4KPj4+Pgo+Pj4+Pgo+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pgo+Pj4+Pj4KPj4+
Pj4+Pgo+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pgo+Pj4+Pj4+PiDCoMKgwqAgLyogUGFzdCB0
aGlzIHBvaW50IG5vIG1vcmUgZmVuY2UgYXJlIHN1Ym1pdHRlZCB0byBIVyByaW5nIAo+Pj4+Pj4+
PiBhbmQgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZvcmNlIHNpZ25hbCBvbiBhbGwgdGhhdCBh
cmUgCj4+Pj4+Pj4+IGN1cnJlbnRseSB0aGVyZS4KPj4+Pj4+Pj4gwqDCoMKgwqAgKiBBbnkgc3Vi
c2VxdWVudGx5IGNyZWF0ZWTCoCBIVyBmZW5jZXMgd2lsbCBiZSByZXR1cm5lZCAKPj4+Pj4+Pj4g
c2lnbmFsZWQgd2l0aCBhbiBlcnJvciBjb2RlIHJpZ2h0IGF3YXkKPj4+Pj4+Pj4gwqDCoMKgwqAg
Ki8KPj4+Pj4+Pj4KPj4+Pj4+Pj4gwqDCoMKgIGZvcl9lYWNoX3JpbmcoYWRldikKPj4+Pj4+Pj4g
wqDCoMKgIMKgwqDCoCBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKQo+Pj4+Pj4+Pgo+Pj4+Pj4+
PiDCoMKgwqAgZHJtX2Rldl91bnBsdWcoZGV2KTsKPj4+Pj4+Pj4gwqDCoMKgIFN0b3Agc2NoZWR1
bGVycwo+Pj4+Pj4+PiDCoMKgwqAgY2FuY2VsX3N5bmMoYWxsIHRpbWVycyBhbmQgcXVldWVkIHdv
cmtzKTsKPj4+Pj4+Pj4gwqDCoMKgIGh3X2ZpbmkKPj4+Pj4+Pj4gwqDCoMKgIHVubWFwX21taW8K
Pj4+Pj4+Pj4KPj4+Pj4+Pj4gfQo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBBbmRyZXkKPj4+
Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+PiBBbHRlcm5hdGl2ZWx5IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBz
aWRlIGFuZCBzdG9wcGluZyAKPj4+Pj4+Pj4+Pj4+PiBhbmQgdGhlbiByZXN0YXJ0aW5nIHRoZSBz
Y2hlZHVsZXIgY291bGQgd29yayBhcyB3ZWxsLgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4g
Q2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBJIGRpZG4n
dCBnZXQgdGhlIGFib3ZlIGFuZCBJIGRvbid0IHNlZSB3aHkgSSBuZWVkIHRvIHJldXNlIAo+Pj4+
Pj4+Pj4+Pj4gdGhlIEdQVSByZXNldCByd19sb2NrLiBJIHJlbHkgb24gdGhlIFNSQ1UgdW5wbHVn
IGZsYWcgZm9yIAo+Pj4+Pj4+Pj4+Pj4gdW5wbHVnLiBBbHNvLCBub3QgY2xlYXIgdG8gbWUgd2h5
IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUgCj4+Pj4+Pj4+Pj4+PiBzY2hlZHVsZXIgdGhyZWFkcywg
YW55IGNvZGUgcGF0Y2ggdG8gZ2VuZXJhdGUgSFcgZmVuY2VzIAo+Pj4+Pj4+Pj4+Pj4gc2hvdWxk
IGJlIGNvdmVyZWQsIHNvIGFueSBjb2RlIGxlYWRpbmcgdG8gYW1kZ3B1X2ZlbmNlX2VtaXQgCj4+
Pj4+Pj4+Pj4+PiBuZWVkcyB0byBiZSB0YWtlbiBpbnRvIGFjY291bnQgc3VjaCBhcywgZGlyZWN0
IElCIAo+Pj4+Pj4+Pj4+Pj4gc3VibWlzc2lvbnMsIFZNIGZsdXNoZXMgZS50LmMKPj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4gWW91IG5lZWQgdG8gd29yayB0b2dldGhlciB3aXRoIHRoZSByZXNldCBs
b2NrIGFueXdheSwgY2F1c2UgCj4+Pj4+Pj4+Pj4+IGEgaG90cGx1ZyBjb3VsZCBydW4gYXQgdGhl
IHNhbWUgdGltZSBhcyBhIHJlc2V0Lgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBG
b3IgZ29pbmcgbXkgd2F5IGluZGVlZCBub3cgSSBzZWUgbm93IHRoYXQgSSBoYXZlIHRvIHRha2Ug
Cj4+Pj4+Pj4+Pj4gcmVzZXQgd3JpdGUgc2lkZSBsb2NrIGR1cmluZyBIVyBmZW5jZXMgc2lnbmFs
bGluZyBpbiBvcmRlciB0byAKPj4+Pj4+Pj4+PiBwcm90ZWN0IGFnYWluc3Qgc2NoZWR1bGVyL0hX
IGZlbmNlcyBkZXRhY2htZW50IGFuZCAKPj4+Pj4+Pj4+PiByZWF0dGFjaG1lbnQgZHVyaW5nIHNj
aGVkdWxlcnMgc3RvcC9yZXN0YXJ0LiBCdXQgaWYgd2UgZ28gCj4+Pj4+Pj4+Pj4gd2l0aCB5b3Vy
IGFwcHJvYWNowqAgdGhlbiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIGFuZCBzY29waW5nIAo+Pj4+
Pj4+Pj4+IGFtZGdwdV9qb2JfdGltZW91dCB3aXRoIGRybV9kZXZfZW50ZXIvZXhpdCBzaG91bGQg
YmUgZW5vdWdoIAo+Pj4+Pj4+Pj4+IHRvIHByZXZlbnQgYW55IGNvbmN1cnJlbnQgR1BVIHJlc2V0
cyBkdXJpbmcgdW5wbHVnLiBJbiBmYWN0IEkgCj4+Pj4+Pj4+Pj4gYWxyZWFkeSBkbyBpdCBhbnl3
YXkgLSAKPj4+Pj4+Pj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHM6JTJGJTJGY2dpdC5mcmVlZGVza3RvcC5vcmclMkZ+YWdyb2R6b3Yl
MkZsaW51eCUyRmNvbW1pdCUyRiUzRmglM0Rkcm0tbWlzYy1uZXh0JTI2aWQlM0RlZjBlYTRkZDI5
ZWY0NGQyNjQ5YzVlZGExNmM4ZjQ4NjlhY2MzNmIxJmFtcDtkYXRhPTA0JTdDMDElN0NhbmRyZXku
Z3JvZHpvdnNreSU0MGFtZC5jb20lN0NlZWZhOWM5MGVkOGM0MDVlYzNiNzA4ZDhmYzQ2ZGFhYSU3
QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1MzY3Mjg1NTA4
ODQ3NDAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpv
aVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9
VWlOYUpFJTJCSDQ1aVltYndTRG5NU0taUzV6MGlhazBmTmxiYmZZcUtTMkpvJTNEJmFtcDtyZXNl
cnZlZD0wCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gWWVzLCBnb29kIHBvaW50IGFzIHdlbGwuCj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
IEFuZHJleQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pgo+Pj4KPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
