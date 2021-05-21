Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32680C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBFC613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBFC613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2146F87C;
	Fri, 21 May 2021 14:05:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B616F87C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QklvEXlYiUvgETAx4snjN1iEP/cLj7fy6kCOICvP2xUr+IOv+wUr8w5TDX3gznppx4fexk9UGyFwHExYi0wQ+3E25PedhL5iuW9xELCRHPJb6D0BnO5sJkm8Lu924HITm1/5lla2n8y8SEfNndu5T+pqo59NlNDJHtvL8o6UOGzbcOnLaON0rRwn9+osC4eHLbjDyYGHgsoBvmtMDPNF5Hdytagtl4Z4NFYPhhhGlQ2mWjIPBcTnO5GroK9rssiUotWqLd8v//xBt4Vcmbhxj44Ny39UCYZJOt3db1zC492/YIkqAuRXUDfrGb4EQZ8jsLpnP1gzzFv9kibWgnGwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3HCi1Uh+4dahlC392M9x+JffkZOZJKcpA6iEKhLJ8g=;
 b=b8rsigPVBtp7GagFe/GnRvdE7HWIJgwkIqBRj6dd3lYb1HQH0jZjWZE1aonXqlkT92eS2B7piN5C0QqYSRrW8FwLggJEfKfeTVBI+zP1q0XUiXGgV9WY34PTd57dCHXJtvQDDg24NM4FJZ91oT2fXq8Zi0bvUTBGF29vLgkhCBKVJfkCVvq4oTmJyeMfqgU9+DM9lkXiezRsZ4DcpUvw9sr56Iap+CTJLDiwfYXxONduWzwTrFlj1BUCqamLOZZ9+IpShX4bBNE/+MNErN73IcNpD/cTs1XfoZmH9Yi5IDphSEhPmQ2NcWzgg1XzMPJTJ4JgKEViFBUQ6V4qvwiWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3HCi1Uh+4dahlC392M9x+JffkZOZJKcpA6iEKhLJ8g=;
 b=TLE+3qbTYBG/zkSaw2v7VEpdN4dLnUfApp8ZvJWwvIwLlOzTbS5+LRUpbydya/8oqqjPuKyzgPpfMWZb5st3VeOeM7y1lLHHNMwoNhrEVbMT6mqXCfaZPgZ1KaptQlioWUcJkGUCwGQGAlfxRAZDqqlsgCVpXgp5bomKJ/nGHdY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 14:05:02 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 14:05:02 +0000
Subject: Re: [PATCH 7/7] drm/amdgpu: do not allocate entries separately
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521124533.4380-1-nirmoy.das@amd.com>
 <20210521124533.4380-7-nirmoy.das@amd.com>
 <04e2e462-1e00-e5da-bc1b-e0255f09ad45@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <51900764-17e0-46b1-03a2-0f514b89fa17@amd.com>
Date: Fri, 21 May 2021 16:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <04e2e462-1e00-e5da-bc1b-e0255f09ad45@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR2P264CA0048.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::36) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.105.51) by
 PR2P264CA0048.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 14:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0bef39b-1efa-44f3-c076-08d91c616d95
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5343E49D1E861A98583433578B299@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVwPSF66yInyjnAXUPDYH6n4LoBJA5L+4wT0pJI8TKpvwGhgSA5ey7mAgeYhuJdy4/vMOf/9UonkP9wRqM8WASpnBdGsgN8nmCWkEK1QMarsP+Fy4zwNJGQBQf94hHwwfVlA3r++4KEkq5xIf9PBFBQUfLNLIy6OuFXWJ/Ikl2L2+MjkuAm0GMG8mliHyFgdQOAe2xYU69dmvPeB6NBQl6OlXfv4Bhak4z/fU7tPaSL1xKJHPkg8kMqAIRtBAzSBfYnTZeoBVaoEGFaMZOsivFcPu6aFh9T8IUYQXxYP0SHQ77uPqa6F8UOMxwp7hYd61sy4kawZZdVUYVaQtogeWoC6A0/joBp6c+VYcVAiATFqGct4NoVPGfAB6NO/Aei2rDgHS3a8sXP2zTPc0WJP5O7fPv0M8MEMe3XeJxHhknqdLQPsHdyTp9rwLLOXuHZOb+0qFnAtoQws+3Rl1Xr0czLjUc4vTxBtPtdWJ8KfGUqQwPlENuJdnoVl37LBmasmOP4KtKnL76DiT99v45Z1lRsz9sdwY0utoK+9Q4U08lc+KwIquQKIhY7Gh/BF6qHE6ebzbh6pEIRNfE6GPgis7CRdvDD5quJj2QHAE+G8qaWf9YyCCuZsjdY0mSVEUuwssdC4lW+fO6moJ2ytsRsRf6qrz7yYuaGVcGjV2yk7cCmjPpf3JH+Jl0RVV38X6DjdpqHVQJVpdhraEYa9TSJaY0uTNHmAqna61jgIXG/p0Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(31686004)(31696002)(6486002)(53546011)(8936002)(4326008)(110136005)(498600001)(6666004)(66556008)(66476007)(66946007)(26005)(36756003)(38100700002)(2616005)(956004)(8676002)(186003)(16526019)(52116002)(83380400001)(2906002)(16576012)(38350700002)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TVhseWhtcEVsWlBWZ1IyRldFT2l1OFkvallSMzBFbHdMSXlDeWlwbVQydVVZ?=
 =?utf-8?B?eUErWmJDL016Rkw0bXZZOElZUGNzTWplU2FjS1dMKzZzeG03dkkwTFVUU2pq?=
 =?utf-8?B?bjFxTTQrSi9BOFd6OUloMVVSUmlibUtTczY1R2FuS3k5d1ZJbFVRK0tNMGhk?=
 =?utf-8?B?bWFXOHBiN0pWRE0vcEFKbWV2S3V0bzlsZHhXd1l6RTdFYkx5d1hxbGlZN2tZ?=
 =?utf-8?B?VU53YTlZMVJ1L0tUc1JMa3dDM3diY2xMc1h5aUwrSko4NXhuMU5mRk92L3c5?=
 =?utf-8?B?NVE3ZUhtWWllbmdvUnNhUnhRc2dKbDV4NW9hK1JmOVhJaUFjNDBENmFrcjhy?=
 =?utf-8?B?dzNFeStVME5Yc3J3ODlob2N3Q1BIQUhIdExlNndTeURsSWc4enZ6bkxsbzda?=
 =?utf-8?B?S1VGNHh4TmczdFAraG1ZaE40NWlrWU80TjZCWUgxWXdHM29CWkdUSGxqNEdR?=
 =?utf-8?B?UFZKOXYvMWZLUk9IRmlMaGhIQm1OckEyMzlMY0lMTGM5dTNXZmFZSTFqRExv?=
 =?utf-8?B?RzMxbHZsamZMUHkwcFZONDRJNWhXUUhNZlNtM0EySDQ3UUZBaWNmd3gvSnlj?=
 =?utf-8?B?K3BjWUd6WERqdVZmUHpKOXFnUjFadXdMM1hkY0FWZXA4Z1lEQjgyT0lIWWkv?=
 =?utf-8?B?cGg3dEJOSFBUTVNZeEdLV2lmOW5GNVJaRGVJOEVVbVlFTWVJbjc1T0ZGdUR0?=
 =?utf-8?B?TWF3eDJrTlg5blVDMTdIN21PdVg2TG1XL0oxYzlhcU5DMnNKenRodlNlS0pl?=
 =?utf-8?B?VGQySkh6Z1VNcjF3Tkl0MG1mRHEwRklDSW1GeGVPOExEc3hpRERtQU5McERG?=
 =?utf-8?B?V0VTb2pJY0dlbUNRSWN6djhRQWhtWityYTQwL0I1M3hpbkZBdnIxNGZseE5l?=
 =?utf-8?B?TEN3Kzc3aFR2cEdSTjlaQzZ6cWt6VDU3ODFsL0Nyd0JialB6RHptTXBVcTQ0?=
 =?utf-8?B?M3l6eU9nUDl4T0lPUVVEM09SanVUTEp1aHNLK2YxajFqaEJydlREMy9GbXRB?=
 =?utf-8?B?ZXlralJzcVplZXRSZXBxdlFaMUwxRzRBZGhCZ01GREJxVk8vVXcrWGY4ZUg1?=
 =?utf-8?B?OG02ZWR2bEZkbm9FRE8xWFZrNU5RTm83WUY1dXk3bTZhOXJxRy9yZU9PYmZH?=
 =?utf-8?B?bkdXTjlLWFVWQW1ST1VWaDRnRUV5bkZUNHJNbm1FOVZGbmk1T1dtUWFQVzgw?=
 =?utf-8?B?dm1rN2hKUm5vVzFHU2dDUW85WW5BNTQ0SzNUUVNTMzNMdlI2M3FhNVlLUWNa?=
 =?utf-8?B?LzRJTExBb3NISmxTZ2lRdDlHYkdPOGF3YXIzaFpmdGJsdTdjVnRVVzBxOVBC?=
 =?utf-8?B?Q0h2Uzg5MW1kVy9ucmtmdWwxRkM3Z0RaMktrRWRKdHpOTzVpY0pCcnp2cGt3?=
 =?utf-8?B?clR4RzdWK1VxeE1pbXQreHZibjJBK1RmYjNoOWZIcVhoODBISjFQKzcrbWdR?=
 =?utf-8?B?NjRBUk1JbUg3amFBSHVvbnZadFF0eXdzOHlzTEM5RGN6WGRSOEVBWERDc2dj?=
 =?utf-8?B?aGxWNHdpY0F1bkFqaUlsMFNLR0FTb3ZQN3RKaW5XUDBaY2VGM3k1dytKR0lQ?=
 =?utf-8?B?YkcxNi9oUkRoM211OXVrMTZwWUtvQlBHVkd0cnZDYk1PalE3SGZSR0lWbEpE?=
 =?utf-8?B?NkpXSkd4bkJmeW1RZ3dQK2xRWk5DUjVCc0MrQ09SVXVyOTJHVkZqQzNrNDdQ?=
 =?utf-8?B?cWtlRlowSEZTTzdnaVhhNGpFcnN3MkNDT0FkWkdkcjNZeUY3UkMxS3E1MGFH?=
 =?utf-8?Q?uLmIXgW1cnq+qmEpSp67P8NdxDp0x3FpYvV+w7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bef39b-1efa-44f3-c076-08d91c616d95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 14:05:02.7911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAxoFXetClQK+h0w9iPpYN2oSrQJYFHD52caj6QXC/M3fnT1fFWW6XKrQzJ4+hPyt18wym63DE55q5hBN16ZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDUvMjEvMjEgMzowMSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMS4wNS4y
MSB1bSAxNDo0NSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEFsbG9jYXRlIFBEL1BUIGVudHJpZXMg
d2hpbGUgYWxsb2NhdGluZyBWTSBCT3MgYW5kIHVzZSB0aGF0Cj4+IGluc3RlYWQgb2YgYWxsb2Nh
dGluZyB0aG9zZSBlbnRyaWVzIHNlcGFyYXRlbHkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1v
eSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMzEgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggMTIwZTZi
N2EwMjg2Li40NzE3ZjA3NWEzOTEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4+IEBAIC04ODAsNyArODgwLDEyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3B0
X2NyZWF0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqAgYnAu
ZG9tYWluID0gYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfcGluX2RvbWFpbihhZGV2LCBicC5kb21h
aW4pOwo+PiDCoMKgwqDCoMKgIGJwLmZsYWdzID0gQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05U
SUdVT1VTIHwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRf
VVNXQzsKPj4gLcKgwqDCoCBicC5ib19wdHJfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2Jv
X3ZtKTsKPj4gK8KgwqDCoCBpZiAobGV2ZWwgPCBBTURHUFVfVk1fUFRCKQo+PiArwqDCoMKgwqDC
oMKgwqAgYnAuYm9fcHRyX3NpemUgPSBzdHJ1Y3Rfc2l6ZSgoKnZtYm8pLCBlbnRyaWVzLAo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV92
bV9udW1fZW50cmllcyhhZGV2LCBsZXZlbCkpOwo+PiArwqDCoMKgIGVsc2UKPj4gK8KgwqDCoMKg
wqDCoMKgIGJwLmJvX3B0cl9zaXplID0gc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm9fdm0pOwo+PiAr
Cj4KPiBSYXRoZXIgZG8gaXQgbGlrZSB0aGlzIGhlcmU6Cj4KPiBpZiAobGV2ZWwgPCBBTURHUFVf
Vk1fUFRCKQo+IMKgwqDCoCBudW1fZW50cmllcyA9IGFtZGdwdV92bV9udW1fZW50cmllcyguLi4p
Cj4gZWxzZQo+IMKgwqDCoCBudW1fZW50cmllcyA9IDA7Cj4KPiBicC5ib19wdHJfc2l6ZSA9IHN0
cnVjdF9zaXplKC4uLi4pCgoKU3VyZS4KCgo+Cj4gSWYgd2UgaGF2ZSB0aGF0IGNhbGN1bGF0aW9u
IG1vcmUgdGhhbiBvbmNlIHRoZW4gaXQgbWlnaHQgbWFrZSBzZW5zZSB0byAKPiB1bmlmeSBpdCBp
biBhIGZ1bmN0aW9uLCBidXQgSSBkb24ndCB0aGluayBzbyBvZiBoYW5kLgoKCkN1cnJlbnRseSwg
d2Ugb25seSBuZWVkIHRoaXMgY2FsY3VsYXRpb24gaW4gYW1kZ3B1X3ZtX3B0X2NyZWF0ZSgpLgoK
Ck5pcm1veQoKCj4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+IMKgwqDCoMKgwqAgaWYg
KHZtLT51c2VfY3B1X2Zvcl91cGRhdGUpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBicC5mbGFncyB8
PSBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEOwo+PiDCoCBAQCAtOTU0LDE5
ICs5NTksMTQgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCAKPj4gYW1k
Z3B1X2RldmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtICpwdDsK
Pj4gwqDCoMKgwqDCoCBpbnQgcjsKPj4gwqAgLcKgwqDCoCBpZiAoY3Vyc29yLT5sZXZlbCA8IEFN
REdQVV9WTV9QVEIgJiYgIWVudHJ5LT5lbnRyaWVzKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCB1bnNp
Z25lZCBudW1fZW50cmllczsKPj4gLQo+PiAtwqDCoMKgwqDCoMKgwqAgbnVtX2VudHJpZXMgPSBh
bWRncHVfdm1fbnVtX2VudHJpZXMoYWRldiwgY3Vyc29yLT5sZXZlbCk7Cj4+IC3CoMKgwqDCoMKg
wqDCoCBlbnRyeS0+ZW50cmllcyA9IGt2bWFsbG9jX2FycmF5KG51bV9lbnRyaWVzLAo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoKmVudHJ5
LT5lbnRyaWVzKSwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFl
bnRyeS0+ZW50cmllcykKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07
Cj4+IC3CoMKgwqAgfQo+PiAtCj4+IC3CoMKgwqAgaWYgKGVudHJ5LT5iYXNlLmJvKQo+PiArwqDC
oMKgIGlmIChlbnRyeS0+YmFzZS5ibykgewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGN1cnNvci0+
bGV2ZWwgPCBBTURHUFVfVk1fUFRCKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+
ZW50cmllcyA9Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG9fYW1kZ3B1X2Jv
X3ZtKGVudHJ5LT5iYXNlLmJvKS0+ZW50cmllczsKPj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPSBOVUxMOwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICvCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIHIgPSBh
bWRncHVfdm1fcHRfY3JlYXRlKGFkZXYsIHZtLCBjdXJzb3ItPmxldmVsLCBpbW1lZGlhdGUsIAo+
PiAmcHQpOwo+PiDCoMKgwqDCoMKgIGlmIChyKQo+PiBAQCAtOTc4LDYgKzk3OCwxMCBAQCBzdGF0
aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2
LAo+PiDCoMKgwqDCoMKgIHB0X2JvID0gJnB0LT5ibzsKPj4gwqDCoMKgwqDCoCBwdF9iby0+cGFy
ZW50ID0gYW1kZ3B1X2JvX3JlZihjdXJzb3ItPnBhcmVudC0+YmFzZS5ibyk7Cj4+IMKgwqDCoMKg
wqAgYW1kZ3B1X3ZtX2JvX2Jhc2VfaW5pdCgmZW50cnktPmJhc2UsIHZtLCBwdF9ibyk7Cj4+ICvC
oMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwgPCBBTURHUFVfVk1fUFRCKQo+PiArwqDCoMKgwqDCoMKg
wqAgZW50cnktPmVudHJpZXMgPSBwdC0+ZW50cmllczsKPj4gK8KgwqDCoCBlbHNlCj4+ICvCoMKg
wqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IE5VTEw7Cj4+IMKgIMKgwqDCoMKgwqAgciA9IGFt
ZGdwdV92bV9jbGVhcl9ibyhhZGV2LCB2bSwgcHRfYm8sIGltbWVkaWF0ZSk7Cj4+IMKgwqDCoMKg
wqAgaWYgKHIpCj4+IEBAIC0xMDA1LDcgKzEwMDksNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdm1f
ZnJlZV90YWJsZShzdHJ1Y3QgCj4+IGFtZGdwdV92bV9wdCAqZW50cnkpCj4+IGFtZGdwdV9ib191
bnJlZigmdG9fYW1kZ3B1X2JvX3ZtKGVudHJ5LT5iYXNlLmJvKS0+c2hhZG93KTsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8pOwo+PiDCoMKgwqDC
oMKgIH0KPj4gLcKgwqDCoCBrdmZyZWUoZW50cnktPmVudHJpZXMpOwo+PiDCoMKgwqDCoMKgIGVu
dHJ5LT5lbnRyaWVzID0gTlVMTDsKPj4gwqAgfQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
