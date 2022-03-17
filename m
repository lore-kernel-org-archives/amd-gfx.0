Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0BDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 01:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81CD10EAC8;
	Thu, 17 Mar 2022 01:01:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1CF10EAC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 01:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly6umvLbw42L9kdqupjnW2eljUAF6gc8pQTbhg60WIY20LxhRIRLNPDFQOuDDj7aPqSXMwQd25Jp5SnfPg85sz+r2FcG3qrUbN0yt7F/cr8QhgYu2G2S16XpPdP2TYkJCuf6FrK69lbVBqVC5W5o/eq3o73PZVFIr5CrzFW7sfRMZqU8gHrQZ+cGKp2OWZdYdlqoSAi5u6LbMon/7fntUjQ8yXGVvqCwLRjLleZBd8hxyquUkFBsItpx4jygBi9mmS4lm30/IiWWcjY8OwgyLW09rKL7aKPUNCYalmi83+TTdOAI+Q/A4iyq4AeLHV6IEDaHYMnQ+HwQhIqC4Sc+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd1icpe+/+lwnFhYhg8f1Ta3YKMsDYW0eAFIODcGnzs=;
 b=cR2f0VjRNfxiuaDn8w1rbGdQNuFG7SI94hUv9KQRR1i2keGkW0W4AO0tB2XUaVz+JezgMlvafDsSU8AOHFs7D2BV6RbSKERxiU+2jVrkinfm9Ma1rmbjTCfFHobDEKS+gYgGZi/yEKW+sGTIVFl6xyhQnMQrdK2W7IzTGHfLe+XIj3Iac5vwv4jFUZhJrEqfyX2skEEh6KNtfUlOEjx2VR4heAzwmVScTbNppV/mTUenpPQBm5zfo9hOqS/dhHGfs2HmwkwrK6hKOYc3j3VJ7oLGA2tF6W0daPuYBoKsd76/eyWu3m8YE0ywTl0CDX4i8GQoYCpqcr1zbgONT+awAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd1icpe+/+lwnFhYhg8f1Ta3YKMsDYW0eAFIODcGnzs=;
 b=QaoRFGShaUfopyA0nTGIvsf1YCZoi3F1pAgHkGjP1yyRBF2MlebpUyGE9Y7mwbQaA77apRH8lUVLdq+wwxS7tyqcJY7tx5GMX0j3nLiLQvp6N/kIM4ZkMnhdFV4JLrNqO4gSMq/C9ELErt8PmW9+L6MSDFb3yMDrG3rP8aWAWv0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2732.namprd12.prod.outlook.com (2603:10b6:5:4a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Thu, 17 Mar 2022 01:01:12 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4%7]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 01:01:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: set noretry=1 for GFX 10.3.4
Thread-Topic: [PATCH 1/1] drm/amdgpu: set noretry=1 for GFX 10.3.4
Thread-Index: AQHYLnL7dKou6/YpSkacE1FGbltumazCv08AgAAYdvA=
Date: Thu, 17 Mar 2022 01:01:12 +0000
Message-ID: <DM5PR12MB2469D2F198B4D1362768747DF1129@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220302202014.2439629-1-Felix.Kuehling@amd.com>
 <525659f9-bc04-de58-c416-ab000c1de9eb@amd.com>
In-Reply-To: <525659f9-bc04-de58-c416-ab000c1de9eb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3957837a-86d6-4859-46ed-08da07b1a177
x-ms-traffictypediagnostic: DM6PR12MB2732:EE_
x-microsoft-antispam-prvs: <DM6PR12MB27326501EDC4CA79C37F21ABF1129@DM6PR12MB2732.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPjNhGWqVRRrS5EBqzl7+GAeZv6B2Dni+rHPvVllBDFLbtUAgv0D6ND2+4+d+GjfqV1qIiuEoP5SY6QavdhPseM2ceerOmn8wyTbSUjqLB+yoENgRpjkgW/hHXsnCcxWlJaJkbBbaoXwI0gnlKpXMV+mMjbcI1XB7ahIJZTOklQ6Ihu2LlmqaKjzozNHjEYTq+4fQEVUQRnwzdGMs8BfdfXWVKLBcl6QOFZlxJWzIdjWUon5MU0Wcijjeuz6cRAoYF6oVD6KIWQamFswEtvmgGuua4bFU4swKXAxKpid4MOSbws7rs6oX49VNE8v2onEpXG8zbIVO1OF9NgefV5i7LYewf5QQbkEYcCZnPKLz4Y3MIl0IccWyd4folMZ+gbuuMkXjtdg8x53yB4f2k75PecRYK9dOc5fd7rc5cxztfdmzLBg4oLW6X40qM2Jkb9r2gWrynwWA4kUCoD8Mvj7jX6ETbYzHgAvuRcO/G1uX99TVZmWgGwdkknGm7tYjg22JHo3VXSA2yG2+t6ny8xLu8HyXElmLF4mXsm8HGs5Bw0XaU4tq1UqhEYBVBUniHdOgz4bAoRGOBPcbLjWJDcehNXAFLJRTJSNJlbNW5wNu3xuGhDIztRWkxAyfdgTL+TK+XLwGSZpC0Y7phbY8V4t8HEmtwB2cUH9RRJlhd8FvQnv8BfTmeL+ocMJfsuiQJ+UtZJVw0CfRFBzRGQZLh/fQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(38070700005)(66946007)(7696005)(6506007)(316002)(55016003)(2906002)(9686003)(110136005)(76116006)(8676002)(52536014)(66446008)(186003)(64756008)(71200400001)(66476007)(122000001)(66556008)(8936002)(5660300002)(508600001)(33656002)(86362001)(38100700002)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWU2U3k0TytubHRMM0RPVVliUU00dVM3djZYOHpBeFYvNzdIMnAzMWdnZElJ?=
 =?utf-8?B?Z3UyKzhVNHY2NW9DRFVkaS84bnZjdWVZUmdacDJXUk5YVklVVVJCNHV6K05l?=
 =?utf-8?B?eUthOVR1M1Z3MmF0TkY3cVo3eTZJbXdKN1V5cldsZitBcVZwczNic0dmWVRs?=
 =?utf-8?B?QWE1VEFWYXZqMlFidGtMVnRJdUZpRGRzV2tncVNkeEhRYktWbXZhc3NtZmxW?=
 =?utf-8?B?V1dwZmZ4ZjRKUlplZG4xTGx2dFY2Ui9hSWUvalV0M0VNZUowUUtzOVB5b1BL?=
 =?utf-8?B?K0FmNWVBVHFOTHZCcnV2YU9vQ2V4MndES2pIUzJGNXZTcUZEUmRnN1pid2Zk?=
 =?utf-8?B?RzVPVnAyTllWQXI0aDJEbVBiN25QTnJ5UnVMc2UwY2Y3V09tVWtlWW5uY0pj?=
 =?utf-8?B?aXFUQW9Rd2xocDV5QmkrS0pZckd4QjVFRWlFaDNQbXlqRUFaR04zbzdVWmlF?=
 =?utf-8?B?T3FWR3FwN1BNQVJjU1NOZ2ExbzdpTFp4V1NUWS9YbnMxUGpEcWhnbVhhRGlG?=
 =?utf-8?B?dDRHMkcySmxaaGlUQlo3Q3pMdFhNUS8ycnV6Ti9TT0ZjeTdWL3l6M0s5ZkNa?=
 =?utf-8?B?K2RpVUpFRGFUa09tcUdsNHRGS2VoeVVsejRuRnlzVXJNWlRnSUV2UmVVUzFu?=
 =?utf-8?B?aDRHZVhvRktKdEs1aGJ5Y3RPNksrd2pFQ04vTlltSThxSHNDVWg0LzN2dFgr?=
 =?utf-8?B?R1lpMDVUVzF0MUpWbW5TS1VuOTBLbFNkNmx1MUNBUGtNOUZJbXlHN3ZGVmlh?=
 =?utf-8?B?QUprdndCd1VMQU5lY291cUlaUStJU2ttOFRGbUw1VVJtZ2xKMWdCUzlEOUxR?=
 =?utf-8?B?YmExR2NwMWtmU0VrUjRhLzZqSlhSa09LaHNHemtoTXlZUHBUcXB3cm1QWGhn?=
 =?utf-8?B?bldqQm9WSjNkZXNNcVhUVVM3MmN2eS9sZk5rUDB5b3VmSXhMWHVKL0lFaHk0?=
 =?utf-8?B?T0h4Y0RIYlVmdE1TMkJyZ0N3K3B3WUpTSC9zMDB1M3d2d3V4Z0J2U0QyRzlP?=
 =?utf-8?B?YmcwZkt1WUZDNUx5YlhVbUJ3Z2xFaHlWYTVnMUswVllOcjJLT2hUS2Jxb2NW?=
 =?utf-8?B?MWtoLzN6Z0FXL1VCcnpGTVZVeG5XOXBER0lwUWpDaFNMK21WZUFKOWdxQXRo?=
 =?utf-8?B?WCtYNEtGNEFFUXlaTFVxOWJGOFd3TlJFUGt2VnZObUREbjY5dzl3bmNXN2tv?=
 =?utf-8?B?ejJ6T0d0WVBYeEl1VjBhb3ZWeEx4MTNyUlA1TUc0OTVFN0J3b3JjMUljb3E2?=
 =?utf-8?B?TVg3RFNGbk9UTkRmV3RVNzRNNlh1WnJyeUM5R2xTSnZqZUk3NzNzSW4wM2hV?=
 =?utf-8?B?Ty9BM1RSRENnTFFOUlQ2RXdPQ28yWnBpSFFHdUJDbEdLUDJCRVkySGRURmha?=
 =?utf-8?B?dWdWdnQ5NSs4aUQ1eklyZHY3dzNtamZsay9jdjFnempmMTlvWlVkVnRKVTVB?=
 =?utf-8?B?aVBCcnBkU3RLYndSeWltNERBdzJqZW8rdG4wZ3NqNnVMS3BYeFNYK2dlOGZV?=
 =?utf-8?B?RWMraDR0cmZ0NUZZdHR1T2FzWUp2OEJ1YytOZFJ2Vlp3N1RCYXdsa2FmOVYw?=
 =?utf-8?B?bXdqd0hSdCsrcDdhWVJrMXlWbUh1QVQ2MGZzKzJNdFpZS0grYTNOV1FlYURv?=
 =?utf-8?B?QXlCVm5EbktEUFFQWkdmc1RQYXFHSHMxZTBFdHFHbTd6T3YvbVVGZEx0eEMz?=
 =?utf-8?B?UWlQNXJocFhzUEMrMm91S0JrQXBJZ1ZINkgvcVBTeVRpd1k4clhYNENsWWlq?=
 =?utf-8?B?WkhweVlEWGhlRkhVTzVMOFhRVmJJMTZyOHlRdXpUV29qTVZXeDlLNzFTUU1Y?=
 =?utf-8?B?aG5TRGMzVk5CWk5RQm1ZSCt0Tk5wdjI0eVpVOFBRLzc4eHpUTXk0Zmw0Mi9Q?=
 =?utf-8?B?blR1Z0d4S1Z2aCtSMUFhdFhjNXAyWjl4TzdJcmhXc3ppeDlyZHE2bUpzbm9q?=
 =?utf-8?Q?htXFb44pHCOUM8SbU93FCMsTK68N6m2N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3957837a-86d6-4859-46ed-08da07b1a177
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 01:01:12.5119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZUVPe87ajoPBY88ccsGhoDCtJKXOTYFDmkNrXa3X+eBiHwDMawNwl4WTl+ycYYNQvBcV62++u5kYhdu/9iP4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2hhbGwgd2Ugc29ydCBpdD8gQW55d2F5LCB0aGUgcGF0Y2ggaXM6IFJldmlld2VkLWJ5OiBHdWNo
dW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEZlbGl4IEt1ZWhsaW5nDQpTZW50OiBU
aHVyc2RheSwgTWFyY2ggMTcsIDIwMjIgNzozMyBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gZHJtL2FtZGdwdTogc2V0IG5vcmV0
cnk9MSBmb3IgR0ZYIDEwLjMuNA0KDQpQaW5nPw0KDQoNCk9uIDIwMjItMDMtMDIgMTU6MjAsIEZl
bGl4IEt1ZWhsaW5nIHdyb3RlOg0KPiBSZXRyeSBmYXVsdHMgYXJlIG5vdCBzdXBwb3J0ZWQgb24g
R0ZYIDEwLjMuNC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuYyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+IGluZGV4IDdjMmE5NTU1
YjdjYy4uNjIyZWVkYTllYTQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5jDQo+IEBAIC01NjgsNiArNTY4LDcgQEAgdm9pZCBhbWRncHVfZ21jX25vcmV0cnlf
c2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAljYXNlIElQX1ZFUlNJT04oMTAs
IDMsIDMpOg0KPiAgIAljYXNlIElQX1ZFUlNJT04oOSwgMywgMCk6DQo+ICAgCWNhc2UgSVBfVkVS
U0lPTigxMCwgMywgNik6DQo+ICsJY2FzZSBJUF9WRVJTSU9OKDEwLCAzLCA0KToNCj4gICAJCS8q
DQo+ICAgCQkgKiBub3JldHJ5ID0gMCB3aWxsIGNhdXNlIGtmZCBwYWdlIGZhdWx0IHRlc3RzIGZh
aWwNCj4gICAJCSAqIGZvciBzb21lIEFTSUNzLCBzbyBzZXQgZGVmYXVsdCB0byAxIGZvciB0aGVz
ZSBBU0lDcy4NCg==
