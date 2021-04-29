Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC31C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236F56145E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236F56145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B651F6E1A5;
	Thu, 29 Apr 2021 07:51:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4778D6E1A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhqsX8aKPP3xIZZOO69YefzcFyiDMfNDiSxeJHyamNv6cMmBvL6DeizrjLdRfuCVOY47n+Mf/VyJALmdM0BmtYFZR5zopKA8sSjWdx8Ecc3uwD5z8ERs9KZ3uVTNl+g3wnV6Nx6H1gUx4mUFlRfo9cChW8w410/dzzwE2S3WkNjV+spC7KLr8MSNj3Ziky0zifbYiSWuLWgGreVwv2H92s3hdFwyvT6NShzK4s/CTUmH9w0I9HDX2ke0MT0KmSXZidPiWbRNO2AZ2nT8HcFQsS5hV8rzyU7aueCHRT/mbqjz6LgZyUL3EnoJuN+AiFwKX/+/ZLbrUYPHPu8D7eFmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB7G+JVej95o6wyWA8xcuBvoe0qGi4+XZTY3AUl8RhU=;
 b=DF63dVicPnZmubYfyhW8UiflHkZlp7sEaHIDG8kf3pli1tzIDpTILK3SQBaZqarI+gIeMlrZqijbAWZXJqcjygGKYz0Iz0+wUmA9Hm9eN53ePIiR2StMEAS6jYDhqCv+g5kxA0bx3X5OaRqMsv9bS0mRpZaD6euokKlzucYdMywU58GgRyrzHw3vDbEqimnn3jz6M/JnjZf5s10FDIMC6s73/V9eO+RpIIW5W9IrM08eKcwq+5ESN+evQ9PcZDf3E/Vl2ydGaDkOCXN365fd40fzJMML7yGvZctJWCQ09TdQOUhc1z/a3Eo1ASNIckxnFrdYghc1+zUh2lIoFLfxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB7G+JVej95o6wyWA8xcuBvoe0qGi4+XZTY3AUl8RhU=;
 b=CvIkGC+X21xf2yIR+1jfnf9jAI0AIHBI2M9WClJga5wj5bHQH9hBQZp36g7UtfDzX8tRN0XJXkud9JLbVtTqnRCb0KXpSzqMrU0/EsVUoTcBZg8DXcSpFE/M1ki/nYCj1DL/DSzzLKrSovAWQuyrWo/dcnzvBPxEUhNohaJLRgM=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR12MB1863.namprd12.prod.outlook.com
 (2603:10b6:903:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 07:50:57 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 07:50:57 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable gfx ras in aldebran by default
Thread-Topic: [PATCH] drm/amdgpu: enable gfx ras in aldebran by default
Thread-Index: AQHXPMEHY9VbG+1p0kyeb+5aAstVharLHzvA
Date: Thu, 29 Apr 2021 07:50:57 +0000
Message-ID: <CY4PR1201MB0072366809533BFF1E26A86DFB5F9@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <1619677772-2899-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677772-2899-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T07:50:52Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d6f9e9bf-7008-4ca1-b39a-4adb5d0f77b3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:38a:845b:7000:43a:f4aa:d777:f395]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3adf2c55-66b5-4bad-2a8f-08d90ae3861e
x-ms-traffictypediagnostic: CY4PR12MB1863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1863F028D713205F26D77E08FB5F9@CY4PR12MB1863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pus1IwjWeeAUKT4Qu3zUnQ73D6FP+4XDMUEdI5OA4Iaq+FQC0/qGNAeGzSaP29MZr0LhF5gWyxGHUWiysUpDn78q1HdDwDVBSXNb0JGOb1t0AbyBZ/ebVnKVzHyQmVAq8Ma+YrUe+zX1vnl7TesHks90OKDW61zUrYJNm8T80NY7ObwVDT6aR7XfvsMHWUPfKaDUcb9675+Ew/LPY0uvKdcfDM5aKoJN1p9wLHZgmFKt8KAC6WtEGYNFfcdFPamX5qBR2HFDTwl4RqchK1ILaJtf9bw8xSArFwpgEeA1/8uHncHuqpQobwPMTW4htl7LOcAwSxNFVOjKwgL1K5aqH+qBCXXOcNbp9a6myEzI9JjlQGZsgVarqLE7VgJIeUsnw+R6Ruio5h1CnUefG1VuTga6dBrvjiwOTOCqWhfm1LGdKEXUdOlW0aFy8+74kDy2LRCxIvBQ1nAkeA4iS0uViYibpsJji6mW2N0nZIbNUGNa37rBFbdozXIv4LObE2Q+2FZczEJe0vEs9tbQ9vQ1hzBTlhhGGnCALx/gVeOfCTKfP7xwDlctT2WN9iqM4Wc9gzgH/BTm6f1EvSCVdLnCQ3L9qLAjfY6SXQEr8FqQj/U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(4326008)(38100700002)(7696005)(83380400001)(316002)(186003)(122000001)(2906002)(52536014)(53546011)(66946007)(66556008)(478600001)(66446008)(66476007)(86362001)(64756008)(8936002)(76116006)(8676002)(9686003)(55016002)(33656002)(71200400001)(110136005)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TUMyreYSt/LSbjcldjcyYkGsyrVLWGKX/tA+rmxV0dkLtFcvu5eVTUGwFgt5?=
 =?us-ascii?Q?9MeEgb95Losd9q5BeJFn//d9kuMan6x/LLlKmtAJZGHwmQ77mEtrm3F76BuT?=
 =?us-ascii?Q?j4jEW0S2gFxgAHkt8bIx+Zm3cIkjnoTvxBObHeArgEgtfS1B5jCXDpkleYMZ?=
 =?us-ascii?Q?WjKuhdR03AKe+8TQNeORqT1oOGMeHsqf23YAwz/JwVLcaA/uPO+36egQ4C6U?=
 =?us-ascii?Q?DSuajIJq0A+a4aNJu9K6SMRLLmEK2w98DaFQr9Chtg4/uWmzENBScanOVlBB?=
 =?us-ascii?Q?bTZROtWsNXgMI/qAL+kQICNevB3KO4ut3DkzoinQuGuNE11oGCwSwF5Xir//?=
 =?us-ascii?Q?yfZM2REbPIPDB1yBhnup1KU7jdIU+qD7ScJvs3sIuDkqRyg+SNd5hE+wnFpO?=
 =?us-ascii?Q?xPCwT7EMfi4U179LrLHZdtXPFBzhxpg44ztLwfLo0gXcBeWxiNSGpEJRZu8c?=
 =?us-ascii?Q?MQNvktEAxAFpahqmQDe/SaqJo5FNrFC2VlAof/Jcf1lRFynOcvYwt5/O1ICO?=
 =?us-ascii?Q?30MRUvfWYH4FATpWsPDMingQZOY99Nza0xMJxARo4RIxn/RZvDwAJ2tOMuDb?=
 =?us-ascii?Q?i7mgk+xFFZKgFfsVKTzGbN4yCydlBKsgm64qNPpvxKoMwcEHbVT9YlFDobkN?=
 =?us-ascii?Q?3CmBqtXVpxZzNAeEzkkHE+q6UMl2UmhU6ozHXMYCTEZpPgGk4nH0Hi5Cl4AZ?=
 =?us-ascii?Q?iQW/Z+QxwZ+LDdS/idnf0jtynqzv1V8ZFumBCR16Cvoip/kFZAzEt6T6zFBN?=
 =?us-ascii?Q?dLuBT5BFsaaPQsILytTZji7EI0BlMmHpqOxmqKMRgvR/fy/bssBKHglnXF1+?=
 =?us-ascii?Q?BhkCpo/ibtTkSsEFil8bps5Dn1um25jBDnzRr53a9JxAjtzr3nG4JqYbCyXz?=
 =?us-ascii?Q?rlUMTx9qidCEReBWR7mTnm1S6bGU/OJutUq3SEDl7eqMMSfNFvjTNo+cWi2T?=
 =?us-ascii?Q?yY5lAt9jc+FEVd0R2qYnrPvA0Fr1XMXJ9akx6ozrtQBXbE1oa1g0nAgdonso?=
 =?us-ascii?Q?JkvqP+q+f5NdlonVpHPvzLfzO+NTdquUDh8e6eQTHtv0tfx5jCtlRZ3llazT?=
 =?us-ascii?Q?EJfoP6DIxvCHORBb1AEqWY8O3uUfjJkM2Y6S3cOGZgXY1hjNA95bysL/wTjl?=
 =?us-ascii?Q?Dh1CTqHUP54sSEEbI2sgowfxacglthtXGeYmlrKgvoKyqMbgM3/7VzbuRZJF?=
 =?us-ascii?Q?G4ZtdaJVFvVniGNNpWTWTDvE1BuINDBAuLOT8S/LvFEHV8utsYS4zsOF3WTh?=
 =?us-ascii?Q?qxgpYH6/yO/ISRBtRLKDXHBTnqB6ALPt5KebWHJAqq2hTN3UCGtw9XkZef1A?=
 =?us-ascii?Q?vLxWOUmaMWGJ9BrwWwzKijiAWnVNl9h4QtU6hDyCB8BkWinv3lwhqiAiGQGc?=
 =?us-ascii?Q?16XGVPHonwsTs2vRsIFz9r7AN1nC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adf2c55-66b5-4bad-2a8f-08d90ae3861e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 07:50:57.2074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3KQpEK+ba/t8OgzrlSxc4iHVMFuf7dwpM1/NWyrbg/747w86T01KIRJYkdCPUloRBo9Xal4aEEklCxvEycCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1863
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:30 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable gfx ras in aldebran by default

gfx ras now can be enabled by default in aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 984e827..9306e39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2101,7 +2101,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	} else {
 		/* driver only manages a few IP blocks RAS feature
 		 * when GPU is connected cpu through XGMI */
-		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__SDMA |
+		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
+				1 << AMDGPU_RAS_BLOCK__SDMA |
 				1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
-- 
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
