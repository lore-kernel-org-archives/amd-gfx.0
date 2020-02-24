Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89CC3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3BC20828
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PfYpIG95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3BC20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84ECF6E41F;
	Mon, 24 Feb 2020 10:24:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2756E41F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9bs6g3s9YubI6d0L61jyLEE1PzrkBQIG7ZN67X7v00B+x6P2akcY5PlewviUZ7kB4fwyA5412yhuMyk9OImvRlSNK4k3/S1PeXjqTg+imJmu2lFiUHNNYg/ophFLNHYxBP2AUesHP7J0T9x1Cet+uZje2xv9PshsRTtsfOLy7FxbzD3OkIDW2tIW+wFCpzbALDIz/UxpXAMczQJJvFoyBIOcqpZJaY0wJiQKzKGT3JBUza9WG5p3UU2JbYSVRR966Sc/kFC3eJqA3DrQyIHA0gbOs2loeTaGalhW0miTGfKYmQSwXzu+UwBNrvIzBJuRwRfCuCyKhW34JfdtHROkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s25h7QghuI+nRUSCiGl4dSmpEK6mpCm49rc3yMVabJk=;
 b=QK2eIiFv1pdQO4V0ODKSPTjaKeOOHqu/VnSYaGbASsQcHWizVKOqQwxQrNyRxuQYg1iJMoQQIIMWIeVxz4j8FCPuyb13gld2WeRK6ErL+oDKosN3dfIupI/jLVfjROcVzhyZoIEz5cGPg1KnbDQUcGoHsHzJmnrzpgLob8I5IpLkotqPuTHNt2inT8i+qdhFwodI+Lep4lqDghWOx1AeL+kFGjc4VKvsFWpPXP4wtz+CUhuUUjxer9zMO5t0TsV1rkjzcdgO/T7sTOIfUfmJB5fdBVlENhXxvwn1yvd7g7a0woY7XI9GvrbQdq6OPNE5uGgOqndsGUb0WiPnRpLY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s25h7QghuI+nRUSCiGl4dSmpEK6mpCm49rc3yMVabJk=;
 b=PfYpIG95mJ3B34pHrqeaHZYoegNCEmtHc1T4rvLj8ypasHXO2bdGszaHCsOe6g2pi0Sg8+648J6CKXEoItwRKDjHEBIfsqeJd5sJp/9ny+smsaaiqMh7rkWh962yY+riCBtbauidLhZP9TrR0pTBP4FvFT+VtWhisDi/5DWDlL0=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 10:23:56 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:23:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Topic: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Index: AQHV6vyEeNC0U/NB9EeRjT+W8BmqKA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 24 Feb 2020 10:23:55 +0000
Message-ID: <DM5PR12MB1418872DD15FF0F0278D4A83FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c4ad0a2-5bc3-4e4b-195e-08d7b913a76a
x-ms-traffictypediagnostic: DM5PR12MB1434:|DM5PR12MB1434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1434C867D3E019CBF97698C9FCEC0@DM5PR12MB1434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(478600001)(186003)(4326008)(26005)(33656002)(9686003)(55016002)(558084003)(6506007)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(81166006)(15650500001)(316002)(8936002)(5660300002)(71200400001)(81156014)(2906002)(7696005)(8676002)(110136005)(86362001)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1434;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dkz5UJ5hodj3YQNrlHDLafC8C+S8NxM5Rj2LjwgUepubLKc7IesrDp44P+JMmcF+GBugOdQJE5is7/MRsn5POjkRXuRqOYW6y1HRJ+ULeuTZNJG4LRUjjj9gEoPZ7gdMAWDNOYEAwo6DL82tV3UfPB6xw2ddUrDagMwlO/IiA1v7eQ0dccgISd+BpBV6StpKvftjt4S1+XQ6XUWrjLMFEcx9zznnNsrX4dZ3J03+BaBzQPewIfj9c51wS0qKEhR6J7zXtKddQLtg5mhnBjZyTdMOOsNOnLcLCLKe+c1QGOVjtl0yj7ZCC81x1QyZ04Xq7TMPFGiK8UvqFRn5Cki5rpbfOeQXRgvBtO5CBsCEtXjj6n+epGc9T/BL0PRsD/tlyx/DpY/THLUp5AAiffjUTPa6wMU+ezO1sG0CVeFMb4LytfeU353KsngBWxTnGUf1
x-ms-exchange-antispam-messagedata: qyurmDRdX93LmjsJVEOYHEQ28CI6mV8AdhWwbxfq0j/sJ7nR7i1ZDm5NC1KeZmduMKcu50hSBfbRZEMlB2ywTWs5zCJUwWPKdxiia+cmZAg67FnH6gUZVBDYahN2g57PC4zo7fnZMXdlbKSw+EEKvA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4ad0a2-5bc3-4e4b-195e-08d7b913a76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:23:55.8091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZABu9F2GQbT7wSfA1FB78+7r8YSPqVAr1SAMWYnTTeNl9k4vDqKTgKN3AXtRlmz/fKDHCSv+4zX8IP6pIFGeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Zhang, Hawking would like to recall the message, "[PATCH] drm/amdgpu: update psp firmwares loading sequence".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
