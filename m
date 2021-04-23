Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75216C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 09:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFF0613C8
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 09:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFF0613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672936EB5F;
	Fri, 23 Apr 2021 09:32:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6CA6EB57
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 09:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Edj6heW2gdcLuaoHbYfVN7g0XCEeOxwOjlo472bouEg1IHKkmbsj2sOsnkQwxMvtDCM6QuUWDi8MB+I3FQpSVBAEQtzJHEl2hjOMi1mhHuzexjZ24W76EPmnHNDxBLzz3T6jiZGPJfui6gLC81cS8OHB6DC/NdGqEzT+lZ6T6VwkljGHrLrPftFYRkyrddAeBPjRl8cWO3sBzcNF3eQ+vQcPRsz98pImQePMVAbQ/uB0pgxf00NspESip/vPSrXGpkxbo0hpuML0Y+m3yJngUIWSKGEStIuNhBZClTL9ZyroMH8DoomvHaazzhScay/MQq082/roinRYhyxP5/XbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FKZg6SWNdFVCMnZWYHoCYNECnVv39keQSssIx/rbFY=;
 b=GH81TGZYr5qj2znNPU3dwYwuiG108ZDySnIG46dByTZUAZ14xKKg+pRjfAR/yazOQsvhpT6yGiptB0ollBdqp+oiAbhpex69Ysn9OuV7LY8VuvOUQFD7IQP8UOZhvmY93jOepiY/aNPJxrET9SITYatyHgnvdBn9NKDCbseTwSM8+tjg+TQon2kbmyxXzK3dXKiRJMLXyvudEdwPBm2ZJ5Vu7WNnrhUE29pGj4cieHm3oMYFkvAKb3rSC2e0YKIOWzHBLTdHeAFcggtu2XKkKYtBqcRkCZzqWJ2fEKCc9Fu5L5nMq0K+6MQE5pspyzOoanbPlIg8ZKHM/Z0Qtpor1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FKZg6SWNdFVCMnZWYHoCYNECnVv39keQSssIx/rbFY=;
 b=saa5LDvNfEqLJAKDYHqRLsdpiT5fsyPLiFA9nfurU10c5t7TcXjAzNsbcE3a8JGQ66PcKI+whrBbHKBQyP6qnFxf2djuFpSM+9GPtPVC3ZLcswrvEYn1Fp3k3LFtfbm2lQHdPs+cnnW1WPOLFToy+2vwswblj3Vls9zU4dqpH7Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0055.namprd12.prod.outlook.com (2603:10b6:910:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 09:32:37 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 09:32:37 +0000
Subject: Re: [PATCH 4/6] create shadow bo using amdgpu_bo_create_shadow()
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210422154003.4048-1-nirmoy.das@amd.com>
 <20210422154003.4048-4-nirmoy.das@amd.com>
 <2322c48f-2084-77e7-1f05-3387455421e2@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <3d3ad803-1672-d7f3-1448-a4f1af77cfa8@amd.com>
Date: Fri, 23 Apr 2021 11:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <2322c48f-2084-77e7-1f05-3387455421e2@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.39.182]
X-ClientProxiedBy: PR0P264CA0239.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::35) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.39.182) by
 PR0P264CA0239.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 09:32:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94e05a19-7d33-461d-281e-08d9063abb33
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00550DF4E450E83635E2DC398B459@CY4PR1201MB0055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5UKRyztOMUTqDvGmHPV+p7Kx31n6Cm2rYAnbPYWCjDwXOoOWNzAL5a5lkU+QeFLUZgVnDSV3O/ZK94OWIJb5oOOO7E/a+CsclK1YgtSBKEci/qu6gtLds6DTNRbSF4a7xJE/9nqtHkOqtxC8dCCkvYFM1qQhgy5m8iCDl06gc1g/QWrmuU3ikxlb8dBC0gFFZjJOrRwRV0Z3gQG+SIn3O3WAewbW0ra8y0KDl3QqHfTxQCLeaxoHgUvjIVS7jjTGeQ7weRza/s8kyhO0b8oV8oL7Nr+AnTDRC47dL7KkkC4kkhYsXD3zTEJp7Y1FPamf/x/vY/IW/JVlsEDZpoYmPG+wnmh4NWfwuevTFB9sJeehdSb0pXVCbEs1dFsOXzYh+/UqRK/sHKNfFOO/s+GmfEna/6v0I/2N5btTP8VhFFaqGAu9rLFYVYeqLnU7Iv/0nZNp38mVberpfxib6HyhKsMst4p6W0gjsuWew4Qu5glbICl5bLMlXM1QRVUBxd+bGiFUCyjm9S7IPUwK3/1No1pOqndWRg7G7ramANXp2jT/t2Ms1q65WGfs9ILYKWJeN6I+AfxKJZ8gRFH6q8d6YyyLxC3C2nVTHWbKiTS6KmSpVwJlj7WQabC/INXYv5riU3v7QNr8V1YUILp7mco3cSSXUSTO4uvxJDj3Nvh7Mi2a1Qwxpt5s9iFHZGHdWID1G1vgInMaa/K01blbKkIUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(16576012)(66946007)(38350700002)(6636002)(2906002)(52116002)(316002)(186003)(110136005)(956004)(38100700002)(478600001)(31696002)(83380400001)(66556008)(66476007)(6486002)(8676002)(16526019)(6666004)(5660300002)(4326008)(66574015)(2616005)(53546011)(8936002)(26005)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHoyOU42bDMxWTlVK0lQL2N2K3J4eUd5VU5lRWMvNnFzL2JrUHRrZmRuNjZK?=
 =?utf-8?B?QTdtUUh1ZStLS1hGdUF4RkxnU0ZjRTcvYTdxWGdWa3lBbVNJMHNEMU5WUUND?=
 =?utf-8?B?amRrTTVjOGZodGtyVjcveHk5NWg3L2FYbkt5MnFhUEZMSUgwN1lQUUpla3BK?=
 =?utf-8?B?ZFFWUnVVcE10UE54V0RERVo3WDQzZTFKblJEbCsyWEFGLy91R00xbWNlNkFH?=
 =?utf-8?B?MTQ5R1paQlE0UW94NU43bGY1TzI1UW1abWdpKzlYK3Q3aFVOdTRVcVc5M09N?=
 =?utf-8?B?SXNCNmdsS3dyQnZyUmlSL243a2UrY1RSUkJmU21ZbG1Wa3N5dUMyVUJSbFRV?=
 =?utf-8?B?cDJVUy8wc2JyTUpFME0wam9hN0NlcTFjMXU5bTEyZ1pBOXcxMWxjUG1lZ3VC?=
 =?utf-8?B?bkVEY3c1RjBIWCtVQmR0Q0ErWjZSbGNsTlJjZW9NR0g5aER4UXpMSE5wa09j?=
 =?utf-8?B?RkVnQkV0UERsSmsxQmpmWUk0eExVMmRvZXlhc25zN3ZPZFd0N2M3di82K1p3?=
 =?utf-8?B?M2c5ckVEVi9mSmwzc1E2RlFkTHlESWJXU0Z4aEpldFg0YlhJVENXdnlydVNu?=
 =?utf-8?B?WkVGNVFBSXZhNElJd00rRnFlait1clFZczFsQjBtNzQ0RUIyZmNZL1Q2cUIv?=
 =?utf-8?B?Q3ZrVkloKzVPZTZQTk1SOEV4bUE4Qmp6Z1haazV1TU1DWnJLSy9SakFiTkty?=
 =?utf-8?B?K2k2YVBnRWtHY1c3bE85R1diRWM1eEIyKzNHZUtIQUR6S0trK2tSWWF0d3h3?=
 =?utf-8?B?b0N3TXNzRFB4R0lkUCtaRTdSWFJxWHJETUNaNEd6Vk1raEtrOEp4NmFVaXdn?=
 =?utf-8?B?OWNrWHZCN1dkcmw1WFJBVzB2WUFVNlNGRFkvQldEWUltWlVDRUFDTlhPZDhx?=
 =?utf-8?B?eUxWVTNXR1V1TFJyRGNzeFVKa3g3WWlwVldLUzl1c3NsUXFSMnVlTTlpa1M2?=
 =?utf-8?B?d3d1WFdtemoxUE14R0VOcFdicEdZVGxnS0pqeWdqY05oREpoRE8zZktvd1lJ?=
 =?utf-8?B?Vys0dEZRTXVZVEJNZktCOTAvTjd4eDF6ZVdTd0MwUk5uUlBlWXU3Y1hKT0tE?=
 =?utf-8?B?M2lOUTlyZm1zeld3Wm44NTlUSFZiVVdIakdhbGxMUHBTRjAxSXZzVU0xejF6?=
 =?utf-8?B?V1NYbzdsRUVENUszS09HQ2tCZVlISmhGWjlMeDlWcUxXd1V4LzR6d3lodG9w?=
 =?utf-8?B?MWd4V0swUFd5T1lBRWNBSG43OHpJZk1JSllVTzlscFhQQlM1WXpTZWJiTCti?=
 =?utf-8?B?d2FtNjA5aDlsK3Jrai9BakVIT3hkNnB1QjJ4emc1bTRXUjBsRVZBK2U1cmZq?=
 =?utf-8?B?Rk1neXpTYVg1WmFRa3lUeXJhZWtiTU5VVVB0NTcvcXdwWFZJanE0dWdQR0ZY?=
 =?utf-8?B?M2pyWFFIeUJBMmJqMXNwbjE4eXRyeDc1czQra2VsRlRwS3I4OFdBQnYyVndr?=
 =?utf-8?B?WEl1MDYwQjJyVUM5WWtnWkpaK1g3TmNkbTNqUUtPOVd0ZEliV1BrMUxMT21G?=
 =?utf-8?B?MDZyTWtPdUNpMjB2b05QUEJrU1FFekdxbU9rZmI4dGlHRFUyalU0VUxHTEd2?=
 =?utf-8?B?MUwxR0dEbmxUMEZSYjZ2V3h6VWpvMmw2dXJKWDdiQXNaZWt0MGlxUFBScjhS?=
 =?utf-8?B?ZytqemtsSUtnKytrMVJDbFowWE4vSjhOK2pHWE9ENjBCUmR4dXVxTWJ5Vy8v?=
 =?utf-8?B?NUFUaFJ4cXVHUGxpRGlna3RkTy9PZllJaGsrOVVueUg3S2gvUUlpYlVxZERP?=
 =?utf-8?Q?9KXiyYAByY83MWoEOIZmKuN4V7OWO/IakfBFhwi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e05a19-7d33-461d-281e-08d9063abb33
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 09:32:36.9747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7o7NO0gtjZqkaByw7u8PQk5O74dRZb4Ovdr36TM6+aRcX0uItnoYhCEZm+DOH+lAGzg2ATkj96DxuMKR9F3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0055
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDQvMjMvMjEgOTo1NSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMi4wNC4y
MSB1bSAxNzo0MCBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IFNoYWRvdyBCT3MgYXJlIG9ubHkgbmVl
ZGVkIGZvciB2bSBjb2RlIHNvIGNhbGwgYW1kZ3B1X2JvX2NyZWF0ZV9zaGFkb3coKQo+PiBkaXJl
Y3RseSBpbnN0ZWFkIG9mIGRlcGVuZGluZyBvbiBhbWRncHVfYm9fY3JlYXRlKCkuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNzAgKysrKysrKysrKysr
KysrKystLS0tLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDIz
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPj4gaW5kZXggNTc3MTQ4YTRmZmFhLi5iYjU1MDZmZjgwZGQgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC04NTAsMzUgKzg1MCw2MyBAQCBzdGF0
aWMgaW50IGFtZGdwdV92bV9jbGVhcl9ibyhzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4+IMKgIH0KPj4gwqAgwqAgLyoqCj4+IC0gKiBhbWRncHVfdm1fYm9fcGFyYW0gLSBmaWxsIGlu
IHBhcmFtZXRlcnMgZm9yIFBEL1BUIGFsbG9jYXRpb24KPj4gKyAqIGFtZGdwdV92bV9wdF9jcmVh
dGUgLSBjcmVhdGUgYm8gZm9yIFBEL1BUCj4+IMKgwqAgKgo+PiDCoMKgICogQGFkZXY6IGFtZGdw
dV9kZXZpY2UgcG9pbnRlcgo+PiDCoMKgICogQHZtOiByZXF1ZXN0aW5nIHZtCj4+IMKgwqAgKiBA
bGV2ZWw6IHRoZSBwYWdlIHRhYmxlIGxldmVsCj4+IMKgwqAgKiBAaW1tZWRpYXRlOiB1c2UgYSBp
bW1lZGlhdGUgdXBkYXRlCj4+IC0gKiBAYnA6IHJlc3VsdGluZyBCTyBhbGxvY2F0aW9uIHBhcmFt
ZXRlcnMKPj4gKyAqIEBibzogcG9pbnRlciB0byB0aGUgYnVmZmVyIG9iamVjdCBwb2ludGVyCj4+
IMKgwqAgKi8KPj4gLXN0YXRpYyB2b2lkIGFtZGdwdV92bV9ib19wYXJhbShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwgc3RydWN0IAo+PiBhbWRncHVfdm0gKnZtLAo+PiArc3RhdGljIGludCBh
bWRncHVfdm1fcHRfY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBsZXZlbCwgYm9vbCBp
bW1lZGlhdGUsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IGFtZGdwdV9ib19wYXJhbSAqYnApCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqKmJvKQo+PiDCoCB7Cj4+IC3CoMKgwqAgbWVtc2V0KGJw
LCAwLCBzaXplb2YoKmJwKSk7Cj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSBicDsK
Pgo+PiArwqDCoMKgIGJvb2wgY3JlYXRlX3NoYWRvdyA9IGZhbHNlOwo+Cj4gQXMgZmFyIGFzIEkg
Y2FuIHNlZSB0aGlzIHZhcmlhYmxlIGlzIG9ubHkgc2V0IGFuZCBuZXZlciB1c2VkLgo+Cj4gUGxl
YXNlIGNsZWFuIHRoYXQgdXAsIGFwYXJ0IGZyb20gdGhhdCBsb29rcyBnb29kIHRvIG1lLgoKClNv
cnJ5IEkgbWlzc2VkIHRoYXQgOi8gLiBSZS1zZW5kaW5nIQoKCj4KPiBDaHJpc3RpYW4uCj4KPj4g
K8KgwqDCoCBpbnQgcjsKPj4gwqAgLcKgwqDCoCBicC0+c2l6ZSA9IGFtZGdwdV92bV9ib19zaXpl
KGFkZXYsIGxldmVsKTsKPj4gLcKgwqDCoCBicC0+Ynl0ZV9hbGlnbiA9IEFNREdQVV9HUFVfUEFH
RV9TSVpFOwo+PiAtwqDCoMKgIGJwLT5kb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9WUkFNOwo+
PiAtwqDCoMKgIGJwLT5kb21haW4gPSBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5fZG9tYWlu
KGFkZXYsIGJwLT5kb21haW4pOwo+PiAtwqDCoMKgIGJwLT5mbGFncyA9IEFNREdQVV9HRU1fQ1JF
QVRFX1ZSQU1fQ09OVElHVU9VUyB8Cj4+ICvCoMKgwqAgbWVtc2V0KCZicCwgMCwgc2l6ZW9mKGJw
KSk7Cj4+ICsKPj4gK8KgwqDCoCBicC5zaXplID0gYW1kZ3B1X3ZtX2JvX3NpemUoYWRldiwgbGV2
ZWwpOwo+PiArwqDCoMKgIGJwLmJ5dGVfYWxpZ24gPSBBTURHUFVfR1BVX1BBR0VfU0laRTsKPj4g
K8KgwqDCoCBicC5kb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9WUkFNOwo+PiArwqDCoMKgIGJw
LmRvbWFpbiA9IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX3Bpbl9kb21haW4oYWRldiwgYnAuZG9t
YWluKTsKPj4gK8KgwqDCoCBicC5mbGFncyA9IEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElH
VU9VUyB8Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VT
V0M7Cj4+IC3CoMKgwqAgYnAtPmJvX3B0cl9zaXplID0gc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm8p
Owo+PiArwqDCoMKgIGJwLmJvX3B0cl9zaXplID0gc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm8pOwo+
PiDCoMKgwqDCoMKgIGlmICh2bS0+dXNlX2NwdV9mb3JfdXBkYXRlKQo+PiAtwqDCoMKgwqDCoMKg
wqAgYnAtPmZsYWdzIHw9IEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7Cj4+
ICvCoMKgwqDCoMKgwqDCoCBicC5mbGFncyB8PSBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNT
X1JFUVVJUkVEOwo+PiDCoMKgwqDCoMKgIGVsc2UgaWYgKCF2bS0+cm9vdC5iYXNlLmJvIHx8IHZt
LT5yb290LmJhc2UuYm8tPnNoYWRvdykKPj4gLcKgwqDCoMKgwqDCoMKgIGJwLT5mbGFncyB8PSBB
TURHUFVfR0VNX0NSRUFURV9TSEFET1c7Cj4+IC3CoMKgwqAgYnAtPnR5cGUgPSB0dG1fYm9fdHlw
ZV9rZXJuZWw7Cj4+IC3CoMKgwqAgYnAtPm5vX3dhaXRfZ3B1ID0gaW1tZWRpYXRlOwo+PiArwqDC
oMKgwqDCoMKgwqAgY3JlYXRlX3NoYWRvdyA9IHRydWU7Cj4+ICsKPj4gK8KgwqDCoCBicC50eXBl
ID0gdHRtX2JvX3R5cGVfa2VybmVsOwo+PiArwqDCoMKgIGJwLm5vX3dhaXRfZ3B1ID0gaW1tZWRp
YXRlOwo+PiDCoMKgwqDCoMKgIGlmICh2bS0+cm9vdC5iYXNlLmJvKQo+PiAtwqDCoMKgwqDCoMKg
wqAgYnAtPnJlc3YgPSB2bS0+cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2Owo+PiArwqDCoMKg
wqDCoMKgwqAgYnAucmVzdiA9IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4+ICsK
Pj4gK8KgwqDCoCByID0gYW1kZ3B1X2JvX2NyZWF0ZShhZGV2LCAmYnAsIGJvKTsKPj4gK8KgwqDC
oCBpZiAocikKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+PiArCj4+ICvCoMKgwqAgaWYg
KHZtLT5pc19jb21wdXRlX2NvbnRleHQgJiYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkpCj4+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gKwo+PiArwqDCoMKgIGlmICghYnAucmVzdikK
Pj4gK8KgwqDCoMKgwqDCoMKgIFdBUk5fT04oZG1hX3Jlc3ZfbG9jaygoKmJvKS0+dGJvLmJhc2Uu
cmVzdiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxM
KSk7Cj4+ICvCoMKgwqAgciA9IGFtZGdwdV9ib19jcmVhdGVfc2hhZG93KGFkZXYsIGJwLnNpemUs
ICpibyk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoIWJwLnJlc3YpCj4+ICvCoMKgwqDCoMKgwqDCoCBk
bWFfcmVzdl91bmxvY2soKCpibyktPnRiby5iYXNlLnJlc3YpOwo+PiArCj4+ICvCoMKgwqAgaWYg
KHIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlZihibyk7Cj4+ICvCoMKgwqDC
oMKgwqDCoCByZXR1cm4gcjsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gMDsK
Pj4gwqAgfQo+PiDCoCDCoCAvKioKPj4gQEAgLTkwMSw3ICs5MjksNiBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgaW1tZWRpYXRlKQo+PiDC
oCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnkgPSBjdXJzb3ItPmVu
dHJ5Owo+PiAtwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fcGFyYW0gYnA7Cj4+IMKgwqDCoMKgwqAg
c3RydWN0IGFtZGdwdV9ibyAqcHQ7Cj4+IMKgwqDCoMKgwqAgaW50IHI7Cj4+IMKgIEBAIC05MTks
OSArOTQ2LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCAKPj4gYW1k
Z3B1X2RldmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoCBpZiAoZW50cnktPmJhc2UuYm8pCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgLcKgwqDCoCBhbWRncHVfdm1fYm9fcGFy
YW0oYWRldiwgdm0sIGN1cnNvci0+bGV2ZWwsIGltbWVkaWF0ZSwgJmJwKTsKPj4gLQo+PiAtwqDC
oMKgIHIgPSBhbWRncHVfYm9fY3JlYXRlKGFkZXYsICZicCwgJnB0KTsKPj4gK8KgwqDCoCByID0g
YW1kZ3B1X3ZtX3B0X2NyZWF0ZShhZGV2LCB2bSwgY3Vyc29yLT5sZXZlbCwgaW1tZWRpYXRlLCAm
cHQpOwo+PiDCoMKgwqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7
Cj4+IMKgIEBAIC0yNzg0LDcgKzI4MDksNiBAQCBsb25nIGFtZGdwdV92bV93YWl0X2lkbGUoc3Ry
dWN0IGFtZGdwdV92bSAKPj4gKnZtLCBsb25nIHRpbWVvdXQpCj4+IMKgwqAgKi8KPj4gwqAgaW50
IGFtZGdwdV92bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1
X3ZtIAo+PiAqdm0sIHUzMiBwYXNpZCkKPj4gwqAgewo+PiAtwqDCoMKgIHN0cnVjdCBhbWRncHVf
Ym9fcGFyYW0gYnA7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqcm9vdDsKPj4gwqDC
oMKgwqDCoCBpbnQgciwgaTsKPj4gwqAgQEAgLTI4MzUsOCArMjg1OSw4IEBAIGludCBhbWRncHVf
dm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0g
KnZtLCB1MzIgcGFzaWQpCj4+IMKgwqDCoMKgwqAgbXV0ZXhfaW5pdCgmdm0tPmV2aWN0aW9uX2xv
Y2spOwo+PiDCoMKgwqDCoMKgIHZtLT5ldmljdGluZyA9IGZhbHNlOwo+PiDCoCAtwqDCoMKgIGFt
ZGdwdV92bV9ib19wYXJhbShhZGV2LCB2bSwgYWRldi0+dm1fbWFuYWdlci5yb290X2xldmVsLCAK
Pj4gZmFsc2UsICZicCk7Cj4+IC3CoMKgwqAgciA9IGFtZGdwdV9ib19jcmVhdGUoYWRldiwgJmJw
LCAmcm9vdCk7Cj4+ICvCoMKgwqAgciA9IGFtZGdwdV92bV9wdF9jcmVhdGUoYWRldiwgdm0sIGFk
ZXYtPnZtX21hbmFnZXIucm9vdF9sZXZlbCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBmYWxzZSwgJnJvb3QpOwo+PiDCoMKgwqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBlcnJvcl9mcmVlX2RlbGF5ZWQ7Cj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
