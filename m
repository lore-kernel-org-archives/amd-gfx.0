Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B92C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 13:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5AE2078D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 13:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vS5nNTDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5AE2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C3746E1BA;
	Thu, 13 Aug 2020 13:38:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1733A6E1BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 13:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDWNF3zYgD/hmjO5div7FYy+NeP2kuglTJb+6uwMZeqkcblS3iq4i8qp6eli9sJVovtbbxsCq1N6UHUIsY7eh2baM0AuPgjDvbr/Dry9pKsnRXbFklzxA4lNLrwV+rZNS7+Q/DH4usTSqBxiLzp2hX/45V6Gl1ksBau+VRWORq1Rdy8OmgLKH9PRRJNtFXBegQGZh7FvMe0+k+xTG3OJ36TSXBcsjAsMNPVuS9IjyBONUOepcro9AU8ro9CCw9W4F7BRXUndiBLc8ulSGLTKg7Z2GYdeGAA40hLV0bZIsfLWd5tLxL1wM+9MDiszvh2lLwuJIahYx3n/9rX5q0G06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPtICYO69e4b5nEvBj3c3YxFUx0DRrlBczKE52T8FGk=;
 b=budIWMv5eAVjoIKghutQI+5CRyNzqeT4WgqXYeDfpSBWvDQ2HKTc87EPzEkxWq9bUvI5HePwMpRbJzv5yCvtmLBDtF0pFyoR2PLD8E+YMCl3d476jvDaZ3WoMB+KPZFl6crDNp6aM0/23pqs/i43HncmJ4ZlfFM00+aKjzlA10/PDH/Quf50rO9tqs43X4MszHPNBGUQovRFDUGEDeTVnpgGdYWk3oUJ7VsZ47yZyVoF0+o4RmeplnDP65tAVkdGRnvdYAv9reVvSayzH5p5A7iCHxZzz4w9shzkxdvLlearWZfqn+19xMAMseIS4zkKcomYDgwdhzsGuuG5urHJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPtICYO69e4b5nEvBj3c3YxFUx0DRrlBczKE52T8FGk=;
 b=vS5nNTDcZCSPHH7vrOIRHdS4ynXlIcbnLIZdv/2kMLgx47+Xn6oTeF+oV/R66En+afAgniRd7Gi3q+XSOImVtMzZMLbYkwYHec1I8KCG+eH+BDrkwKQ0Q9cRSvsvdy517su/jKiJ1D8dFPwcyNTRw0rjzxXCROITipXYqTHRgmw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.20; Thu, 13 Aug 2020 13:38:28 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%3]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 13:38:28 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200811133053.71123-1-nirmoy.das@amd.com>
 <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
 <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <b6e878c0-bade-77a5-fda7-6be234c2f6b7@amd.com>
Date: Thu, 13 Aug 2020 09:38:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::13) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c172:76b1:4560:8a64]
 (2607:fea8:3edf:49b0:c172:76b1:4560:8a64) by
 YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 13:38:28 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:c172:76b1:4560:8a64]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4e324bf-9581-4e91-acba-08d83f8e2965
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203055E7D1E851258E76745EA430@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJKEJFyy6MDzwLdHKBLHv/t+nRrrvTIxT6wrmedXfqa5/mLZxY3fq2y79VjnRgIxAzpSyODGl+PvTP4bWKD5rZRPfiAjnFfPgfhe/ZVypbO2CCncV7BRgl+i3GelblQ1ANpH+/10jO1BzI29KrjLGpqyJK6HtD8j1SVdkau4hDBQZnxJvyIJwIyxstDImwZVBYZUQkKrud93ZkGLYRa59SNEofOAW0czpN/+n3twyLnrYhO4t9byomSt3msvGEpFMICn3kq5YDRdlpXp2En0keW0yWRel7jKses2g4B5r00WTBYBVxaDgLYJE+j6pww/z+tL9fqRelptZH3CDgDKP1JC5IkvRXjKvLyG2MKjMBYXj82NozQE1wuIG66jz0ecmzm3+j6RUGacwntPGIa+YxeSoL9ezuTSBj4IXEnkmPSeR1FJz7/053ualoi4bPzPBwwOJW6YA3rXBhFwlKH8nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(186003)(66556008)(52116002)(4326008)(8936002)(16526019)(53546011)(110136005)(478600001)(66476007)(8676002)(66946007)(86362001)(316002)(2906002)(36756003)(6486002)(5660300002)(31696002)(31686004)(2616005)(83380400001)(966005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RihPljhnJfBysPdvDSP0CfjPR486IzE+DB6s+Cj2NDCRaU/gZzCf8yCGkE07k4d/ywGiFZu8dcA/JjT6mbUey5SQScGp2sCH++H5k82bNvw8/TCqeCXxBldv/DEL3HHyPhBm1XXsmIzkJNEf3EOvpPAI0mwNjUoZeC2jk3ZcgPa0Uss2kSi/QxCb5Ruc+s028lNs/d+383gzwVGD5cwQPST4mn7Q9if3ouyFCAiDRWjxgKUO6ggwu/gGFWWmtzTGMp2fj9httJNqmN6nfKzZrOyYDmhd2CIpemq1uyySpc5TpK3VtSfUQmuPrj8dSFGHon/088aGSUtaEiXfUwMPgTNuHxvdhp9yU5WeQZwUAfCXi9ibqoYP976Pv4IghrfIiqq7Zvx5jjoL3C+KxlqQ9UFP7i3R3qWRKyeQgYK/i4PTg+FOwhWuR1Xrq+cbilwFAoR8hvzf7PJzmRBWAzt5+hFYaZ5b/4JG1I8sJ058tEK5HhkojO1yfQ0JCrHzVjqI0BROEUjKC+TRd4tLUmhmA1sCYNrsz6JABCEFtBPNEmrnuIBmOOupl834yLxLsqWNAICvATAclMIcq/UHBWsKmJ+JEKV5TjjWomAHySvsYbQWKkQbh5cQbh1/2IhB+jeXkx351BdF3mTzjtID6cZxuYI5XcOfLhkcM8WphdBRUc/uDXNsBu+Uc39AUfqAvJKCL3TqMlg8jPSJgeRLGf491g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e324bf-9581-4e91-acba-08d83f8e2965
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 13:38:28.7013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zq8a9WAbRXpxlM04T4m8wmuLGZJWpyifQjO03u/12k+TC9DDu0jRdj8ySGJtUNbIULksUkvzodIBccnVnMCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDgvMTMvMjAgNzowOSBBTSwgTmlybW95IHdyb3RlOgo+Cj4gT24gOC8xMi8yMCA0OjUyIFBN
LCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4KPj4gT24gOC8xMS8yMCA5OjMwIEFNLCBOaXJt
b3kgRGFzIHdyb3RlOgo+Pj4gVGhpcyBwYXRjaCB3aWxsIGlnbm9yZSBub24tZmF0YWwgZXJyb3Jz
IGFuZCB0cnkgdG8KPj4+IHN0b3AgYW1kZ3B1J3Mgc3cgc3RhY2sgb24gZmF0YWwgZXJyb3JzLgo+
Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4+
IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgNTYg
KysrKysrKysrKysrKysrKysrKysrKysrLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDU0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jCj4+PiBpbmRleCBjMTIxOWFmMmU3ZDYuLjJiOWVkZTMwMDBlZSAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+PiBAQCAt
MzUsNiArMzUsNyBAQAo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KPj4+IMKg
ICNpbmNsdWRlIDxsaW51eC92Z2Ffc3dpdGNoZXJvby5oPgo+Pj4gwqAgI2luY2x1ZGUgPGRybS9k
cm1fcHJvYmVfaGVscGVyLmg+Cj4+PiArI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5o
Pgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21tdV9ub3RpZmllci5oPgo+Pj4gwqAgwqAgI2luY2x1
ZGUgImFtZGdwdS5oIgo+Pj4gQEAgLTE1MTYsNiArMTUxNyw1OCBAQCBzdGF0aWMgc3RydWN0IGRy
bV9kcml2ZXIga21zX2RyaXZlciA9IHsKPj4+IMKgwqDCoMKgwqAgLnBhdGNobGV2ZWwgPSBLTVNf
RFJJVkVSX1BBVENITEVWRUwsCj4+PiDCoCB9Owo+Pj4gwqAgK3N0YXRpYyBwY2lfZXJzX3Jlc3Vs
dF90IGFtZGdwdV9wY2lfZXJyX2RldGVjdGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX2NoYW5uZWxf
c3RhdGVfdCBzdGF0ZSkKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBkcm1fZGV2aWNlICpkZXYg
PSBwY2lfZ2V0X2RydmRhdGEocGRldik7Cj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gZGV2LT5kZXZfcHJpdmF0ZTsKPj4+ICvCoMKgwqAgaW50IGk7Cj4+PiArwqDCoMKg
IGludCByZXQgPSBQQ0lfRVJTX1JFU1VMVF9ESVNDT05ORUNUOwo+Pj4gKwo+Pj4gK8KgwqDCoCBz
d2l0Y2ggKHN0YXRlKSB7Cj4+PiArwqDCoMKgIGNhc2UgcGNpX2NoYW5uZWxfaW9fbm9ybWFsOgo+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IFBDSV9FUlNfUkVTVUxUX0NBTl9SRUNPVkVSOwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gK8KgwqDCoCBkZWZhdWx0Ogo+Pj4gK8KgwqDCoMKg
wqDCoMKgIC8qIERpc2FibGUgcG93ZXIgbWFuYWdlbWVudCAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGFkZXYtPnJ1bnBtID0gMDsKPj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBTdXNwZW5kIGFsbCBJTyBv
cGVyYXRpb25zICovCj4+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2ZiZGV2X3NldF9zdXNwZW5k
KGFkZXYsIDEpOwo+Pj4gKyBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5ZWRf
aW5pdF93b3JrKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01B
WF9SSU5HUzsgKytpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmICghcmluZyB8fCAhcmluZy0+c2NoZWQudGhyZWFkKQo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+ICsKPj4+ICsgYW1kZ3B1X2pvYl9zdG9w
X2FsbF9qb2JzX29uX3NjaGVkKCZyaW5nLT5zY2hlZCk7Cj4+Cj4+Cj4+IFlvdSBuZWVkIHRvIGNh
bGwgZHJtX3NjaGVkX3N0b3AgZmlyc3QgYmVmb3JlIGNhbGxpbmcgdGhpcwo+Pgo+Pj4gK8KgwqDC
oMKgwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+bW9kZV9pbmZv
Lm1vZGVfY29uZmlnX2luaXRpYWxpemVkKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoIWFtZGdwdV9kZXZpY2VfaGFzX2RjX3N1cHBvcnQoYWRldikpCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRybV9oZWxwZXJfZm9yY2VfZGlzYWJsZV9hbGwoYWRldi0+ZGRl
dik7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRybV9hdG9taWNfaGVscGVyX3NodXRkb3duKGFkZXYtPmRkZXYpOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfZmVu
Y2VfZHJpdmVyX2ZpbmkoYWRldik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2ZiZGV2X2Zp
bmkoYWRldik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgLyogVHJ5IHRvIGNsb3NlIGRybSBkZXZpY2Ug
dG8gc3RvcCBhcHBsaWNhdGlvbnMKPj4+ICvCoMKgwqDCoMKgwqDCoMKgICogZnJvbSBvcGVuaW5n
IGRyaSBmaWxlcyBmb3IgZnVydGhlciBJTyBvcGVyYXRpb25zLgo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBUT0RPOiBUaGlzIHdpbGwgdGhyb3cgd2FybmluZyBhcyB0dG0gaXMgbm90Cj4+PiArwqDC
oMKgwqDCoMKgwqDCoCAqIGNsZWFuZWQgcGVycGVybHkgKi8KPj4+ICvCoMKgwqDCoMKgwqDCoCBk
cm1fZGV2X2ZpbmkoZGV2KTsKPj4KPj4KPj4gSSB0aGluayB1c2VyIG1vZGUgYXBwbGljYXRpb25z
IG1pZ2h0IHN0aWxsIGhvbGQgcmVmZXJlbmNlIHRvIHRoZSBkcm0gZGV2aWNlIAo+PiB0aHJvdWdo
IHRocm91Z2ggZHJtX2Rldl9nZXQgZWl0aGVyIGJ5IGRpcmVjdGx5IG9wZW5pbmcKPj4gdGhlIGRl
dmljZSBmaWxlIG9yIGluZGlyZWN0bHkgdGhyb3VnaCBpbXBvcnRpbmcgRE1BIGJ1ZmYsIGlmIHNv
IHdoZW4gdGhlIGxhc3QgCj4+IG9mIHRoZW0gdGVybWluYXRlIGRybV9kZXZfcHV0LT5kcm1fZGV2
X3JlbGVhc2UtPi4uLi0+ZHJtX2Rldl9maW5pCj4+IG1pZ2h0IGdldCBjYWxsZWQgYWdhaW4gY2F1
c2luZyB1c2UgYWZ0ZXIgZnJlZSBlLnQuYyBpc3N1ZXMuIE1heWJlIGJldHRlciB0byAKPj4gY2Fs
bCBoZXJlIGRybV9kZXZfcHV0IHRoZW4gYW5kIHNvIGRybV9kZXZfZmluaSB3aWxsIGdldCBjYWxs
ZWQgd2hlbiB0aGlzCj4+IGxhc3QgdXNlciBjbGllbnQgcmVsZWFzZXMgaGlzIHJlZmVyZW5jZS4K
Pgo+Cj4gZHJtX2Rldl9maW5pKCkgc2VlbXMgdG8gYmUgY2xlYW5lci4gUHJvYmxlbSBpc8KgIHdp
bmRvdyBtYW5hZ2VyKHN3YXkpIG5ldmVyIAo+IGdldHMgdGVybWluYXRlZCBhZnRlciB0aGUgQUVS
IGVycm9yIGFuZCBkcm0gZmlsZXMgcmVtYWlucyBhY3RpdmUuIFNpbXBsZSBjYXQgCj4gb24gZHJp
IGZpbGVzCj4KPiBnb2VzIHRob3VnaCBhbWRncHUgYW5kIHNwaXRzIG91dCBtb3JlIGVycm9ycy4K
CgpXaGF0IGhhcHBlbnMgaWYgeW91IGtpbGwgdGhlIHdpbmRvdyBtYW5hZ2VyIGFmdGVyIHlvdSBj
bG9zZWQgZHJtIGRldmljZSB3aXRoIAp5b3VyIG9yaWdpbmFsIGNvZGUgYXBwbGllZCA/IEkgd291
bGQgZXhwZWN0IGRybV9kZXZfZmluaSB0byBiZSBjYWxsZWQgYWdhaW4KZm9yIHRoZSByZWFzb24g
aSBleHBsYWluZWQgYWJvdmUgYW5kIHRoaXMgd291bGQgb2J2aW91c2x5IHdvdWxkIGJlIHdyb25n
IHRvIGhhcHBlbi4KCkFuZHJleQoKCj4KPgo+Pgo+PiBBbHNvIGEgZ2VuZXJhbCBxdWVzdGlvbiAt
IGluIG15IHdvcmsgb24gRFBDIHJlY292ZXJ5IGZlYXR1cmUgd2hpY2ggdHJpZXMgdG8gCj4+IHJl
Y292ZXIgYWZ0ZXIgUENJZSBlcnJvciAtIG9uY2UgdGhlIFBDSSBlcnJvciBoYXMgaGFwcGVuZWQg
TU1JTyByZWdpc3RlcnMgYmVjb21lCj4+IHVuYWNjZXNzaWJsZSBmb3Igci93IGFzIHRoZSBQQ0kg
bGluayBpcyBkZWFkIHVudGlsIGFmdGVyIHRoZSBQQ0kgbGluayBpcyAKPj4gcmVzZXQgYnkgdGhl
IERQQyBkcml2ZXIgKHNlZSAKPj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRl
c3QvUENJL3BjaS1lcnJvci1yZWNvdmVyeS5odG1sIHNlY3Rpb24gCj4+IDYuMS40KS4KPj4gWW91
ciBjYXNlIGlzIHRvIHRyeSBhbmQgZ3JhY2VmdWxseSB0byBjbG9zZSB0aGUgZHJtIGRldmljZSBv
bmNlIGZhdGFsIGVycm9yIAo+PiBoYXBwZW5lZCwgZGlkbid0IHlvdSBlbmNvdW50ZXIgZXJyb3Jz
IG9yIHdhcm5pbmdzIHdoZW4gYWNjZXNzaW5nIEhXIHJlZ2lzdGVycyAKPj4gZHVyaW5nIGFueSBv
ZiB0aGUgb3BlcmF0aW9ucwo+PiBhYm92ZSA/Cj4KPgo+IEFzIGRpc2N1c3NlZCBvdmVyIGNoYXQs
IGl0IHNlZW1zIGFlciBnZW5lcmF0ZWQgd2l0aCBhZXItaW5qZWN0IHRvb2wganVzdCAKPiB0cmln
Z2VycyBrZXJuZWwgUENJIGVycm9yIEFQSXMgYnV0IHRoZSBkZXZpY2UgaXMgc3RpbGwgYWN0aXZl
IHNvIEkgZGlkbid0IAo+IGVuY291bnRlciBhbnkgZXJyb3JzIHdoZW4gYWNjZXNzaW5nIEhXIHJl
Z2lzdGVycy4KPgo+Cj4gTmlybW95Cj4KPgo+Pgo+PiBBbmRyZXkKPj4KPj4KPj4+ICvCoMKgwqDC
oMKgwqDCoCBicmVhazsKPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoCByZXR1cm4gcmV0
Owo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9lcnJvcl9oYW5kbGVy
cyBhbWRncHVfZXJyX2hhbmRsZXIgPSB7Cj4+PiArwqDCoMKgwqDCoMKgIC5lcnJvcl9kZXRlY3Rl
ZCA9IGFtZGdwdV9wY2lfZXJyX2RldGVjdGVkLAo+Pj4gK307Cj4+PiArCj4+PiArCj4+PiDCoCBz
dGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgYW1kZ3B1X2ttc19wY2lfZHJpdmVyID0gewo+Pj4gwqDC
oMKgwqDCoCAubmFtZSA9IERSSVZFUl9OQU1FLAo+Pj4gwqDCoMKgwqDCoCAuaWRfdGFibGUgPSBw
Y2lpZGxpc3QsCj4+PiBAQCAtMTUyMywxMCArMTU3Niw5IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2Ry
aXZlciBhbWRncHVfa21zX3BjaV9kcml2ZXIgPSB7Cj4+PiDCoMKgwqDCoMKgIC5yZW1vdmUgPSBh
bWRncHVfcGNpX3JlbW92ZSwKPj4+IMKgwqDCoMKgwqAgLnNodXRkb3duID0gYW1kZ3B1X3BjaV9z
aHV0ZG93biwKPj4+IMKgwqDCoMKgwqAgLmRyaXZlci5wbSA9ICZhbWRncHVfcG1fb3BzLAo+Pj4g
K8KgwqDCoCAuZXJyX2hhbmRsZXIgPSAmYW1kZ3B1X2Vycl9oYW5kbGVyLAo+Pj4gwqAgfTsKPj4+
IMKgIC0KPj4+IC0KPj4+IMKgIHN0YXRpYyBpbnQgX19pbml0IGFtZGdwdV9pbml0KHZvaWQpCj4+
PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIGludCByOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
