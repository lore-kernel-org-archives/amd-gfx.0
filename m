Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7734C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A46A20774
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dPR58BDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A46A20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2685B6E0FB;
	Tue, 11 Aug 2020 06:53:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749346E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4re4qhzV8/v22NrjRL8SSO2/Da3qubhbqYAWwVhx6ao2AMLXcQ41F7A1kFt3PlgHzBj3vqlrjg4oEAiRdZWUqL6e+BpitcO46G7b8EtTg8WsIJfMpY0uk65b0sY71I4khJerZGKJFw6AVMlb6XYStr7V6wnAbCe9YQi2zOsmcwklJUMZ2ZIg1I7he0jjEXu7lqxffC8aWerXIBfrYxhS4tc2/dpaMsTbcvc35MimeuDp4OTNvQoJCwHDTsmd4klENdfwPwisWKvpO4lHk95BCeH7aXptzfDvvur2oC7+dHOUUUI4iFgng/54agZDPVOxSWVDxjhtWnfXXjawn8jRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NEtF0n31FXk0YNROfHkhcutxpijJmVIZxtzlTSLfAI=;
 b=VDro4/Z4gyDbJQJeht3OFo4ESrt8yXbPshpOmoV8+fwfJ2mYyryh6V+EoA0uCDJEPrwUDcPdijNwqGw+RAixXc3OnS5d4oGrvN3Lm+VzBrd9YIId0RIY37i1uQLTkBpHIfc7b+Z8Oo3GRtw44VZWh0rW08Uo/4xtjX7+Luem5XzUUSEvVkJZ12AOOle+5BGej1t+dFUef8Daa5mtltSQVVExbJRTU2ufCgAyQTLZuHPb9ZGjCucXCmJJ6psiYrvOva38fwZZtl+GYP33Er/CUxON3GTcFkGlkQubi+cCplNGOSmty6yRsBETvf/yANxB0hfd04LMIavQZZCHPKT6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NEtF0n31FXk0YNROfHkhcutxpijJmVIZxtzlTSLfAI=;
 b=dPR58BDLUlpLtj4wUPytARVOm69ZBhJGtdrkOO2Pd3bngYP8nx8R4U53Mz+XBlCCJYltrs+jaPhveSH9bVHNAkPKNf26kahWquYHvOPXAjXCf5OB5KJC1f2x3b3fi0qx5tvuc67PqggpqTxodA7wU9uhGHBhbkov4fOak4iOFS4=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Tue, 11 Aug
 2020 06:53:08 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 06:53:08 +0000
Subject: Re: [PATCH v3] drm/amdgpu: annotate a false positive recursive locking
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com,
 daniel@ffwll.ch
References: <20200811021224.3688-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fbb65b04-ff33-53dc-89ce-ddaed51185af@amd.com>
Date: Tue, 11 Aug 2020 08:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200811021224.3688-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0145.eurprd04.prod.outlook.com (2603:10a6:207::29)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR04CA0145.eurprd04.prod.outlook.com (2603:10a6:207::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Tue, 11 Aug 2020 06:53:07 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a88e32ed-09d1-4c3a-fc22-08d83dc33474
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3997CB173DF690FA3A3C4D2D83450@MN2PR12MB3997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXtH2xOtrBnabXpxwT2VDQqJFuineRC6zYUqlcKhM7JVX9jh2UlYntcBevYwIHKW5Ge+e2j+SiCFsN4zv8kpa52YeRB7irETc83ZhhzSOyxda/6IGpJhFzX+pFi9u76C48XWEuql1qkaPIR73+bp1Hb2YBviZSNkvHvBuLG6dVsGqzCEMrjn3IU7MsFk5d4P/u6xGg1OaX5h+WH1MZykiOuCiLtSK6zgwQE1hCHkiSr5DYlmQTzgank3eq0Tki0ex/yjIXXm8KiF2Xx5r8biYKUUKEsB/mtosgCUBhvWVC+eVW2XZ6INY18JEej5T9TyvstlaFVmnu4CYBlTj+UTsPiXpfHALu5Tp6u73nhSq1q95YwMOpl0HC7EDOotqH2a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(16526019)(186003)(2616005)(6486002)(478600001)(316002)(52116002)(36756003)(66946007)(66556008)(66476007)(8676002)(66574015)(5660300002)(83380400001)(8936002)(6666004)(86362001)(2906002)(31686004)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: puA+pNIm7YjqbjA0wc3+XVqR199jqzuXBR/XAbwrLeR3lCmKtJnv3+zOWTt7C+4iM0JqAP18N1/J1BBF/oQ7MGc5ldXd8yBZIborBcnuJiw6FrXbppyju4mpG1w+xWxwDTgEBV8xzOytzMq52YY7ZYuRxWaRfRPoZK+5xcUy4pttQs2N67HWKQtxVsLd6UDuVk1edi5kebYYu1SUtJsYGhQ6iQt+6v4FFFXbaZ/IEEGIxCvTYBZsR9FRfW6IpsHABuXRZeaUKETRitp2dXbP9rbsPpicpeiHkW8EtT6daP3WuhEMkVPpRaW2HePAfDi5PdBksv6CQirz3W7rdhLGoy5UQAw35hKxi5yTIektW41gEZzmM+sDPIYlERoazIfqnCcPFNpdhjszZ7zFWav2oPwvp6G6Bvh2IxHBHx9I+2fcDZyQ6VSpjn6AmKI4cXsbbnqTzYJQBqMY/aAqqu+Xy+9sbagiNRaEzDxQ5h8z+uyFKaOK+JI59gCROMqEleA6My1h7bMdjOXzdFkM1EHoAZ+iFycZbzqZOOwceCHTrF5eilKK6hklxt1dzHPsWjPBW7b1T2xuBiIwP/9AUCLF/PFs8ifHF5W5IfTS0knTD0Scv2FHpE271PXhc46tJBt5BzYrygzt7o4tkADyHy/c0oRTzoDqm5nt15vsY0G1+v9sxNw089qD1bvReCKMJyqSAirS/8JNplDqoJTmo8g6VQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88e32ed-09d1-4c3a-fc22-08d83dc33474
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 06:53:08.3012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfbETpGatQhdhw42TAY4odKGuwCJzIICJYAcD1cVa5O6o1GTvwIsMuSL9XD9GTSg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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

QW0gMTEuMDguMjAgdW0gMDQ6MTIgc2NocmllYiBEZW5uaXMgTGk6Cj4gWyAgNTg0LjExMDMwNF0g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBbICA1ODQuMTEw
NTkwXSBXQVJOSU5HOiBwb3NzaWJsZSByZWN1cnNpdmUgbG9ja2luZyBkZXRlY3RlZAo+IFsgIDU4
NC4xMTA4NzZdIDUuNi4wLWRlbGktdjUuNi0yODQ4LWczZjMxMDliMGU3NWYgIzEgVGFpbnRlZDog
RyAgICAgICAgICAgT0UKPiBbICA1ODQuMTExMTY0XSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+IFsgIDU4NC4xMTE0NTZdIGt3b3JrZXIvMzg6MS81NTMgaXMg
dHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoKPiBbICA1ODQuMTExNzIxXSBmZmZmOWIxNWZmMGE0N2Ew
ICgmYWRldi0+cmVzZXRfc2VtKXsrKysrfSwgYXQ6IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIr
MHgyNjIvMHgxMDMwIFthbWRncHVdCj4gWyAgNTg0LjExMjExMl0KPiAgICAgICAgICAgICAgICAg
YnV0IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxvY2s6Cj4gWyAgNTg0LjExMjY3M10gZmZmZjli
MTYwM2QyNDdhMCAoJmFkZXYtPnJlc2V0X3NlbSl7KysrK30sIGF0OiBhbWRncHVfZGV2aWNlX2dw
dV9yZWNvdmVyKzB4MjYyLzB4MTAzMCBbYW1kZ3B1XQo+IFsgIDU4NC4xMTMwNjhdCj4gICAgICAg
ICAgICAgICAgIG90aGVyIGluZm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6Cj4gWyAg
NTg0LjExMzY4OV0gIFBvc3NpYmxlIHVuc2FmZSBsb2NraW5nIHNjZW5hcmlvOgo+Cj4gWyAgNTg0
LjExNDM1MF0gICAgICAgIENQVTAKPiBbICA1ODQuMTE0Njg1XSAgICAgICAgLS0tLQo+IFsgIDU4
NC4xMTUwMTRdICAgbG9jaygmYWRldi0+cmVzZXRfc2VtKTsKPiBbICA1ODQuMTE1MzQ5XSAgIGxv
Y2soJmFkZXYtPnJlc2V0X3NlbSk7Cj4gWyAgNTg0LjExNTY3OF0KPiAgICAgICAgICAgICAgICAg
ICoqKiBERUFETE9DSyAqKioKPgo+IFsgIDU4NC4xMTY2MjRdICBNYXkgYmUgZHVlIHRvIG1pc3Np
bmcgbG9jayBuZXN0aW5nIG5vdGF0aW9uCj4KPiBbICA1ODQuMTE3Mjg0XSA0IGxvY2tzIGhlbGQg
Ynkga3dvcmtlci8zODoxLzU1MzoKPiBbICA1ODQuMTE3NjE2XSAgIzA6IGZmZmY5YWQ2MzVjMWQz
NDggKCh3cV9jb21wbGV0aW9uKWV2ZW50cyl7Ky4rLn0sIGF0OiBwcm9jZXNzX29uZV93b3JrKzB4
MjFmLzB4NjMwCj4gWyAgNTg0LjExNzk2N10gICMxOiBmZmZmYWM3MDhlMWMzZTU4ICgod29ya19j
b21wbGV0aW9uKSgmY29uLT5yZWNvdmVyeV93b3JrKSl7Ky4rLn0sIGF0OiBwcm9jZXNzX29uZV93
b3JrKzB4MjFmLzB4NjMwCj4gWyAgNTg0LjExODM1OF0gICMyOiBmZmZmZmZmZmMxYzJhNWQwICgm
dG1wLT5oaXZlX2xvY2speysuKy59LCBhdDogYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcisweGFl
LzB4MTAzMCBbYW1kZ3B1XQo+IFsgIDU4NC4xMTg3ODZdICAjMzogZmZmZjliMTYwM2QyNDdhMCAo
JmFkZXYtPnJlc2V0X3NlbSl7KysrK30sIGF0OiBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKzB4
MjYyLzB4MTAzMCBbYW1kZ3B1XQo+IFsgIDU4NC4xMTkyMjJdCj4gICAgICAgICAgICAgICAgIHN0
YWNrIGJhY2t0cmFjZToKPiBbICA1ODQuMTE5OTkwXSBDUFU6IDM4IFBJRDogNTUzIENvbW06IGt3
b3JrZXIvMzg6MSBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgICA1LjYu
MC1kZWxpLXY1LjYtMjg0OC1nM2YzMTA5YjBlNzVmICMxCj4gWyAgNTg0LjEyMDc4Ml0gSGFyZHdh
cmUgbmFtZTogU3VwZXJtaWNybyBTWVMtNzA0OUdQLVRSVC9YMTFEUEctUVQsIEJJT1MgMy4xIDA1
LzIzLzIwMTkKPiBbICA1ODQuMTIxMjIzXSBXb3JrcXVldWU6IGV2ZW50cyBhbWRncHVfcmFzX2Rv
X3JlY292ZXJ5IFthbWRncHVdCj4gWyAgNTg0LjEyMTYzOF0gQ2FsbCBUcmFjZToKPiBbICA1ODQu
MTIyMDUwXSAgZHVtcF9zdGFjaysweDk4LzB4ZDUKPiBbICA1ODQuMTIyNDk5XSAgX19sb2NrX2Fj
cXVpcmUrMHgxMTM5LzB4MTZlMAo+IFsgIDU4NC4xMjI5MzFdICA/IHRyYWNlX2hhcmRpcnFzX29u
KzB4M2IvMHhmMAo+IFsgIDU4NC4xMjMzNThdICA/IGNhbmNlbF9kZWxheWVkX3dvcmsrMHhhNi8w
eGMwCj4gWyAgNTg0LjEyMzc3MV0gIGxvY2tfYWNxdWlyZSsweGI4LzB4MWMwCj4gWyAgNTg0LjEy
NDE5N10gID8gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcisweDI2Mi8weDEwMzAgW2FtZGdwdV0K
PiBbICA1ODQuMTI0NTk5XSAgZG93bl93cml0ZSsweDQ5LzB4MTIwCj4gWyAgNTg0LjEyNTAzMl0g
ID8gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcisweDI2Mi8weDEwMzAgW2FtZGdwdV0KPiBbICA1
ODQuMTI1NDcyXSAgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcisweDI2Mi8weDEwMzAgW2FtZGdw
dV0KPiBbICA1ODQuMTI1OTEwXSAgPyBhbWRncHVfcmFzX2Vycm9yX3F1ZXJ5KzB4MWI4LzB4MmEw
IFthbWRncHVdCj4gWyAgNTg0LjEyNjM2N10gIGFtZGdwdV9yYXNfZG9fcmVjb3ZlcnkrMHgxNTkv
MHgxOTAgW2FtZGdwdV0KPiBbICA1ODQuMTI2Nzg5XSAgcHJvY2Vzc19vbmVfd29yaysweDI5ZS8w
eDYzMAo+IFsgIDU4NC4xMjcyMDhdICB3b3JrZXJfdGhyZWFkKzB4M2MvMHgzZjAKPiBbICA1ODQu
MTI3NjIxXSAgPyBfX2t0aHJlYWRfcGFya21lKzB4NjEvMHg5MAo+IFsgIDU4NC4xMjgwMTRdICBr
dGhyZWFkKzB4MTJmLzB4MTUwCj4gWyAgNTg0LjEyODQwMl0gID8gcHJvY2Vzc19vbmVfd29yaysw
eDYzMC8weDYzMAo+IFsgIDU4NC4xMjg3OTBdICA/IGt0aHJlYWRfcGFyaysweDkwLzB4OTAKPiBb
ICA1ODQuMTI5MTc0XSAgcmV0X2Zyb21fZm9yaysweDNhLzB4NTAKPgo+IEVhY2ggYWRldiBoYXMg
b3duZWQgbG9ja19jbGFzc19rZXkgdG8gYXZvaWQgZmFsc2UgcG9zaXRpdmUKPiByZWN1cnNpdmUg
bG9ja2luZy4KPgo+IHYyOgo+IDEuIHJlZ2lzdGVyIGFkZXYtPmxvY2tfa2V5IGludG8gbG9ja2Rl
cCwgb3RoZXJ3aXNlIGxvY2tkZXAgd2lsbAo+IHJlcG9ydCB0aGUgYmVsb3cgd2FybmluZwo+Cj4g
WyAxMjE2LjcwNTgyMF0gQlVHOiBrZXkgZmZmZjg5MDE4M2I2NDdkMCBoYXMgbm90IGJlZW4gcmVn
aXN0ZXJlZCEKPiBbIDEyMTYuNzA1OTI0XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0t
LS0tLS0KPiBbIDEyMTYuNzA1OTcyXSBERUJVR19MT0NLU19XQVJOX09OKDEpCj4gWyAxMjE2Ljcw
NTk5N10gV0FSTklORzogQ1BVOiAyMCBQSUQ6IDU0MSBhdCBrZXJuZWwvbG9ja2luZy9sb2NrZGVw
LmM6Mzc0MyBsb2NrZGVwX2luaXRfbWFwKzB4MTUwLzB4MjEwCj4KPiB2MzoKPiBjaGFuZ2UgdG8g
dXNlIGRvd25fd3JpdGVfbmVzdF9sb2NrIHRvIGFubm90YXRlIHRoZSBmYWxzZSBkZWFkLWxvY2sK
PiB3YXJuaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNv
bT4KPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRl
eCA2MmVjYWM5N2ZiZDIuLjhhNTViMGJjMDQ0YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtNDE0NSwxMiArNDE0NSwxNSBAQCBzdGF0aWMg
aW50IGFtZGdwdV9kb19hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlLAo+
ICAgCXJldHVybiByOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBib29sIGFtZGdwdV9kZXZpY2VfbG9j
a19hZGV2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICtzdGF0aWMgYm9vbCBhbWRncHVf
ZGV2aWNlX2xvY2tfYWRldihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdw
dV9oaXZlX2luZm8gKmhpdmUpCj4gICB7Cj4gICAJaWYgKGF0b21pY19jbXB4Y2hnKCZhZGV2LT5p
bl9ncHVfcmVzZXQsIDAsIDEpICE9IDApCj4gICAJCXJldHVybiBmYWxzZTsKPiAgIAo+IC0JZG93
bl93cml0ZSgmYWRldi0+cmVzZXRfc2VtKTsKPiArCWlmIChoaXZlKSB7Cj4gKwkJZG93bl93cml0
ZV9uZXN0X2xvY2soJmFkZXYtPnJlc2V0X3NlbSwgJmhpdmUtPmhpdmVfbG9jayk7Cj4gKwl9IGVs
c2UKPiArCQlkb3duX3dyaXRlKCZhZGV2LT5yZXNldF9zZW0pOwoKQ29kaW5nIHN0eWxlIG5pdCBw
aWNrOiBZb3Ugc2hvdWxkIGRyb3AgdGhlIHt9IGhlcmUuCgpBcGFydCBmcm9tIHRoYXQgdGhlIHBh
dGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgoKPiAgIAo+ICAgCWF0b21pY19pbmMoJmFkZXYtPmdwdV9yZXNldF9jb3VudGVyKTsK
PiAgIAlzd2l0Y2ggKGFtZGdwdV9hc2ljX3Jlc2V0X21ldGhvZChhZGV2KSkgewo+IEBAIC00MzEy
LDcgKzQzMTUsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPiAgIAo+ICAgCS8qIGJsb2NrIGFsbCBzY2hlZHVsZXJzIGFuZCByZXNl
dCBnaXZlbiBqb2IncyByaW5nICovCj4gICAJbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwg
ZGV2aWNlX2xpc3RfaGFuZGxlLCBnbWMueGdtaS5oZWFkKSB7Cj4gLQkJaWYgKCFhbWRncHVfZGV2
aWNlX2xvY2tfYWRldih0bXBfYWRldikpIHsKPiArCQlpZiAoIWFtZGdwdV9kZXZpY2VfbG9ja19h
ZGV2KHRtcF9hZGV2LCBoaXZlKSkgewo+ICAgCQkJRFJNX0lORk8oIkJhaWxpbmcgb24gVERSIGZv
ciBzX2pvYjolbGx4LCBhcyBhbm90aGVyIGFscmVhZHkgaW4gcHJvZ3Jlc3MiLAo+ICAgCQkJCSAg
am9iID8gam9iLT5iYXNlLmlkIDogLTEpOwo+ICAgCQkJciA9IDA7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
