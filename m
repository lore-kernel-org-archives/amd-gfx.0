Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1875C10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F9A20675
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kfoRWuic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F9A20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D38089C5E;
	Mon,  9 Mar 2020 13:41:04 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690055.outbound.protection.outlook.com [40.107.69.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F15789C5E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 13:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHe5Os2fnyrww0x2VjL0V8NuN5Ic8WoXS8UzU8umXCCMpNSQeSgwkrP8fTpf51AQD4ejvWYdl0t89eQqsk/yrmgD85mWpZpOEu2f/N1zgiyJcuCbZaxfU2lyr653sfZdV3D3zPoBYZop+R7kg8FwhU2AtmXLdD3r1Qvi6ZD5QxRvLz1sbW3HVPWaL2AqFcPCXUyWs/7fQr2XtbpgRkQb4LwExTyubKLFkirBYMVN3gKCZlm+d4BZfu64/+sLCo1Xd9bdwvdiByXGBrh8XuAQt2RVU/xNsfUlBaTyWSghQSbtMP1/SlNPcCHrqlfcSq2+ef5JUDZDFgPHj+x6cdNCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS0oL5aPbn634eCIg3FrDMvtKtEMn/yigX66q3APJWI=;
 b=kO6VlVXVbsPQSz32/Sd2FMiluDbg++5qx5W4iu/8mNafhXrOQgUhulxRTOeqCypo3avJGDVxIxd3ZH9CxABNliBn4gJQJpFShpvyQKLj5fm5uhjhL12evuUpsmupKdw6XVXG80s6UaiBrg0fcdSo2vDkU0tw/vuxZZ2Ve2ALoi3log4rAXXiN6Bk2rQbqKI6hqmOJhwYiSJC7pdH3rVJvbu46CT+fcZGC/86ABWAEbHIul8ouJF4geQ7vqs0WaagWUwkYzbyaluMIzogKPe7O+JTHBS1mwf7UTA0uFbmX91IbUikmhhf1Zq/RjHZu8D4MlqSw8FcqD8nNkGPN/pgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS0oL5aPbn634eCIg3FrDMvtKtEMn/yigX66q3APJWI=;
 b=kfoRWuicrzPp65pZo5XP9I9BuFMZyZfFo+q1/d/iHx4gIvFckUj/hcVJ0g8LDrmD3XY49iIvU9QN4DCi982QTUZE45w41vLk1iwjNgRYfff8nBDFeVbf1bo0j1rtF5tVZ6aNAlxIU0X5F+YnSZd+16kaZMlsOfhfZEc+a3u4vxM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Mon, 9 Mar
 2020 13:41:01 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 13:41:01 +0000
Subject: Re: [PATCH v5 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200309133325.66024-1-nirmoy.das@amd.com>
 <20200309133325.66024-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <14eb16e3-7a82-30f1-d7f4-7338fa1f31c4@amd.com>
Date: Mon, 9 Mar 2020 14:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200309133325.66024-3-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Mon, 9 Mar 2020 13:40:56 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6bd198f-5a06-43b2-8008-08d7c42f8139
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:|DM5PR12MB1947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1947B8E82805BA27BEA7357183FE0@DM5PR12MB1947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(199004)(189003)(186003)(86362001)(4326008)(316002)(66556008)(8936002)(31686004)(52116002)(5660300002)(6666004)(8676002)(6486002)(2906002)(2616005)(66946007)(66476007)(81156014)(81166006)(16526019)(36756003)(31696002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1947;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqlG3ffWARwuBPUdQR8xJC19n+1W4Fl8bKqKLyhosVgFo7f5LaIYjkd8jkjtDva2BZGeaEIYfdTRT/GvFAnxJTD+xUt+e70pGlKynGl9+4ENng0GDZTstFuzhxAP0p7G/OdN3AlRHgWNeLLMIgkHblwYaUMKm1/SePtD6R3HCwNWq3hMHMr2+xgXMir0DH4L0iBsUAhzZTAT84E5W3MaSHz9+IfYTqpFEY6n+cy4j3LaYZG2966C5N4SWpciyqk9lCri7UR5zT4qdK70vJyo3wtvd21uiGwqz0vzUL29A5LPMXGgnXBeE4B2e4H0DxMCaOPqzv4v9HIM31ctk7Timd6rMKkQQ1EzbiFFo5TKimgkCUIq1ynro8B2+hWmLkN9YfLrO7beNitml0wjcjJbscVH/8T4cYz3DYm+uSOOL9WdewwdKEoHRJoSZhbQMQHn
X-MS-Exchange-AntiSpam-MessageData: MFrwdWvjferkadQSXlDVDVYHrgy0fMEGIazhRCrRxpzJnKb8YC5ZfzczllgmuWD3kDWLjRWCIui3LkdHiikBhD2TOAzC2/Wz5GppjygsVTZ7Bn0y9EN9mGImGR5sg2hk8cwYzJQlpabK6wPUy+FL8rqoeTgsY1wbrovQOlL5tr0ej41zSFiOuAk4+E0p/d0xVmva9W0RDqmLvyyP9jt2rQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bd198f-5a06-43b2-8008-08d7c42f8139
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 13:41:01.0668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKsMg5ZA8unsWZtniGT9hXXDCVKBiE0JVeRpDsr9s7qy/pDBjWnRhjqnOXioaZ58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDMuMjAgdW0gMTQ6MzMgc2NocmllYiBOaXJtb3kgRGFzOgo+IFN3aXRjaCB0byBhcHBy
b3ByaWF0ZSBzY2hlZCBsaXN0IGZvciBhbiBlbnRpdHkgb24gcHJpb3JpdHkgb3ZlcnJpZGUuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDI5ICsrKysrKysr
KysrKysrKysrKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+
IGluZGV4IDFkMDVlYjY0Yjg4NS4uM2IyMzcwYWQxZTQ3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+IEBAIC01MTUsNiArNTE1LDI5IEBAIHN0cnVjdCBkbWFf
ZmVuY2UgKmFtZGdwdV9jdHhfZ2V0X2ZlbmNlKHN0cnVjdCBhbWRncHVfY3R4ICpjdHgsCj4gICAJ
cmV0dXJuIGZlbmNlOwo+ICAgfQo+Cj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9jdHhfc2V0X2VudGl0
eV9wcmlvcml0eShzdHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4LAo+ICsJCQkJCSAgICBzdHJ1Y3QgYW1k
Z3B1X2N0eF9lbnRpdHkgKmFlbnRpdHksCj4gKwkJCQkJICAgIGludCBod19pcCwKPiArCQkJCQkg
ICAgZW51bSBkcm1fc2NoZWRfcHJpb3JpdHkgcHJpb3JpdHkpCj4gK3sKPiArCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gY3R4LT5hZGV2Owo+ICsJZW51bSBnZnhfcGlwZV9wcmlvcml0eSBo
d19wcmlvOwo+ICsJc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICoqc2NoZWRzID0gTlVMTDsKPiAr
CXVuc2lnbmVkIG51bV9zY2hlZHM7Cj4gKwo+ICsJLyogc2V0IHN3IHByaW9yaXR5ICovCj4gKwlk
cm1fc2NoZWRfZW50aXR5X3NldF9wcmlvcml0eSgmYWVudGl0eS0+ZW50aXR5LCBwcmlvcml0eSk7
Cj4gKwo+ICsJLyogc2V0IGh3IHByaW9yaXR5ICovCj4gKwlpZiAoaHdfaXAgPT0gQU1ER1BVX0hX
X0lQX0NPTVBVVEUpIHsKPiArCQlod19wcmlvID0gYW1kZ3B1X2N0eF9zY2hlZF9wcmlvX3RvX2Nv
bXB1dGVfcHJpbyhwcmlvcml0eSk7Cj4gKwkJc2NoZWRzID0gYWRldi0+Z2Z4LmNvbXB1dGVfcHJp
b19zY2hlZFtod19wcmlvXTsKPiArCQludW1fc2NoZWRzID0gYWRldi0+Z2Z4Lm51bV9jb21wdXRl
X3NjaGVkW2h3X3ByaW9dOwo+ICsJCWRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKCZhZW50
aXR5LT5lbnRpdHksIHNjaGVkcywKPiArCQkJCQkgICAgICBudW1fc2NoZWRzKTsKPiArCX0KPiAr
fQo+ICsKPiAgIHZvaWQgYW1kZ3B1X2N0eF9wcmlvcml0eV9vdmVycmlkZShzdHJ1Y3QgYW1kZ3B1
X2N0eCAqY3R4LAo+ICAgCQkJCSAgZW51bSBkcm1fc2NoZWRfcHJpb3JpdHkgcHJpb3JpdHkpCj4g
ICB7Cj4gQEAgLTUyNywxMyArNTUwLDExIEBAIHZvaWQgYW1kZ3B1X2N0eF9wcmlvcml0eV9vdmVy
cmlkZShzdHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4LAo+ICAgCQkJY3R4LT5pbml0X3ByaW9yaXR5IDog
Y3R4LT5vdmVycmlkZV9wcmlvcml0eTsKPiAgIAlmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX0hXX0lQ
X05VTTsgKytpKSB7Cj4gICAJCWZvciAoaiA9IDA7IGogPCBhbWRncHVfY3R4X251bV9lbnRpdGll
c1tpXTsgKytqKSB7Cj4gLQkJCXN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHk7Cj4gLQo+
ICAgCQkJaWYgKCFjdHgtPmVudGl0aWVzW2ldW2pdKQo+ICAgCQkJCWNvbnRpbnVlOwo+Cj4gLQkJ
CWVudGl0eSA9ICZjdHgtPmVudGl0aWVzW2ldW2pdLT5lbnRpdHk7Cj4gLQkJCWRybV9zY2hlZF9l
bnRpdHlfc2V0X3ByaW9yaXR5KGVudGl0eSwgY3R4X3ByaW8pOwo+ICsJCQlhbWRncHVfY3R4X3Nl
dF9lbnRpdHlfcHJpb3JpdHkoY3R4LCBjdHgtPmVudGl0aWVzW2ldW2pdLAo+ICsJCQkJCQkgICAg
ICAgaSwgY3R4X3ByaW8pOwo+ICAgCQl9Cj4gICAJfQo+ICAgfQo+IC0tCj4gMi4yNS4wCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
