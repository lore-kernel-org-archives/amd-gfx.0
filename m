Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F8C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86942368A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86942368A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0126E7DA;
	Fri,  8 Jan 2021 10:02:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFDA6E7DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 10:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSVQs4NoF8lVQnnJPOo6/GGJVSF2UGMroCeWib/l5GHLrPz2GnqOgFG4JjM6mP0x3t2Dovar9rvlM5bRPyjDZdpWBVKbBw3Q2XNhJX2CIDrIDdh+uEWeIMeNMZcpn6WPnO0Vf3pYz/sQVz06nkXgR/zOGUAJ2t/HP501tv+qmZlNHin83MsNNBmOni1pu/tywSZP36Y+vFsg+u1o2pm3qSphXYYXHb/k/E92cDl9yTxXnZOP8WAKpFJn1zLWH5LGsFdYXNT9raDDqxkBjFYZL+G02qkrUetHoXcFsdq6trBgH21usA/saK03VYGAXlhlGcU1JSyLAQaFfP1+jed/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nucjMuoA9SDpRqFElK4exK6Hy6XMGBRJE9Ng2clSN1w=;
 b=aU3czIVjN2a1M0Xh+soFzg4x6bjEndOfbnSIch6t1yBzWy6eJ1knMpKnjOqMcoheTV3j8kS3P78Tn0iyyf8TF5TlDaSyfpsdJuP9y/XZlu7jW1LUBIFT1nd6Ip0JgkQNr7zk2O1x8U8yqOKAO5s76I6rfW69jWhPZaP+DhTNkyY2ApNJNaIUKslXr2e9GLWaCvaghjIGMfd+inkmTkDv+3YycC5kSr7vcpDOlcwaTiVWnM2NPc+Lf6RUIDmCFSITr3nuQ167stWYf4T2kBgrrK0vFa123YY83WWlwgnPDasC53+kIZu5W/gFxCJ+xhSlMgbENwTpkSKZQCQeruzu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nucjMuoA9SDpRqFElK4exK6Hy6XMGBRJE9Ng2clSN1w=;
 b=vfolFhJwF+7hiQRR/vpxEMuU9uRYL2VLgwOdb9Zf8D6qBCKxcNYnADpG+MnchVAkvCx90iY0Tr77YEG+u0VEFMud9R7HFC+CUtTXyyJqH3KX7lQqOeXq4kMxsf4pPThFPsYEHqHdcsa4+H8qCdQB5teNdQV8sikEAbhUoydINGQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 8 Jan 2021 10:02:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 10:02:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amd/pm: enhance the real response for smu message
Thread-Topic: [PATCH 2/7] drm/amd/pm: enhance the real response for smu message
Thread-Index: AQHW5ZwT5jUFiL8nPUuOj4Vf/1UXIaodfzMg
Date: Fri, 8 Jan 2021 10:02:37 +0000
Message-ID: <DM6PR12MB261979F3B52209B043CA1396E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
 <20210108085507.1164588-3-ray.huang@amd.com>
In-Reply-To: <20210108085507.1164588-3-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=918fdcfb-7b6f-492b-aeff-2592a79648c4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-08T10:01:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 945b6c47-71c2-4c46-274c-08d8b3bc8706
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4957A6A81A49E56330D773E9E4AE0@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRQu3ONomP1S/atuVc685unOFVRHvgpzw/3ZIs9HPe4OxABRZG2VgckC/DzYJqVcXyKmmQX87DrjsTwqzshqTf+Gr3wW+JsVKQgH3l/daW/DGtBlc3sk4SlfG0T/REXSlnXDFhC88VlixCITHJXjo2uTE3dJlcNFXJJYmWIBKrzxtoZoPlI5alvvYF9czOXpeiaLZMCGBEX13gCT7cENfMpxT3yfmdbDfGqlFu0l0rYKQ4P2I0LrWiKbjisuXfJHZCa2+/gdqvWuZEOSxtQ4efyqhEUOqYAxrd+w6r1ZZfjyCCuimYIY1h3IquuzMoisaytYkEvMm/r3pZq+DBsuRSoYvC2adtUF7a0ZCajSyHoxJCkCzPOheqDuRabVRnGct4UuTfT2tW8QaweMI8SC0PWlCGfGIJAGa6oQBK1yT5o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(66446008)(64756008)(66556008)(86362001)(66476007)(5660300002)(966005)(66946007)(45080400002)(110136005)(26005)(6506007)(186003)(53546011)(33656002)(54906003)(52536014)(316002)(2906002)(4326008)(76116006)(9686003)(83380400001)(15650500001)(7696005)(71200400001)(8676002)(55016002)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q10/TFsk0Gy2Mt7PK9fo2z8ieq8a0IAOWEXSgoKIjmDesFRyONh74AV/PhKJ?=
 =?us-ascii?Q?Qaucwvqv598XSwVeezZEwWTRTzW8iArFfOmeZ0U+QzCtmVCpiJrvvmJFZ95x?=
 =?us-ascii?Q?SRGkbH5sqJzCaOWbQlXhkJVVeIzC7BPkCtiqMUt/zzJW2zgJgcbF13G5GkY9?=
 =?us-ascii?Q?KT+cZMI7aEK+qAj5a9StSulnsISoGcuClFV9ftJToX75yzr2R+S44sKlWp7j?=
 =?us-ascii?Q?+gXKKgKZWqAR139dNezltJ7QIEXevR/X6zKOoA0NrxWqkN/lke4fonq9ELLC?=
 =?us-ascii?Q?lpfCI5dxzmVYtNjMx7Dy6fKFiBkXUav3lXJRyHYekselY7+ZPjH0pdGbAEAj?=
 =?us-ascii?Q?2U7AfQheJsUSKSNveyb2Az+bJqulAjixcf8YI9YQqFtOyxKvQjj44XzBajue?=
 =?us-ascii?Q?ff628WD0+zw7C7R9SZbJtJsvL/RWyHJUY7C+SRYS7UWsavY8RqQq7hGmeQOp?=
 =?us-ascii?Q?SxF5ino6V6Be2pwxVy8uikosF3OZ5omoeUaymtnN5IjXPT6k7VARlO32JMJL?=
 =?us-ascii?Q?/zH9QnBrT9krhOyG3jESZwMocZHmxNd2wpF+D1fHFpu8vuKsPEsE1HRtMZrY?=
 =?us-ascii?Q?+0u1GqmgeKFnr25pAhQREG9a06ajzyFXiOSIHMQBuXxkoUbRrWyGx+h59zfD?=
 =?us-ascii?Q?vdoeyEwMr17I84J4Z6QNQIfc/m0D8vHCaaIVeg8fWmn6HEOGuAs9PwaMukgU?=
 =?us-ascii?Q?PLzbhsc0VtJZdV/3yAI38r48EckDToQkSgh7hMtXurp2WZqFk/EFoTumdAp7?=
 =?us-ascii?Q?k2w7ln10JQPC48uw9O5/4WCljkNVc096p+D7XC93qXkRmGDmUI+XE5eDks9z?=
 =?us-ascii?Q?LqXa5ZZ1B9/BCKoCTQsWXju1pEUTX+RsY4c9ZD3J1R7ApixRmEPuncpc3ibT?=
 =?us-ascii?Q?4RcEU4UwnjqktiUFRALoMEyTtC3hXzJRvqhcNbb7nBhLRs9wAUq0P7WpDDYu?=
 =?us-ascii?Q?KkKnEa7e5yYCr0cEONA/WgLDaywQUDfLkdRPatR8wiE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945b6c47-71c2-4c46-274c-08d8b3bc8706
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 10:02:37.2296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3k5XWCvJi7vGH+J5A/Pw328SETGK8quTHyb6OW0tzWtfUbmAkG22jtm1YMVs7xJB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hou, Xiaomeng
 \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Better to make this modification in smu_cmn_wait_for_response.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Friday, January 8, 2021 4:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH 2/7] drm/amd/pm: enhance the real response for smu message

The user prefers to know the real response value from C2PMSG 90 register which is written by firmware not -EIO.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f8260769061c..42b125701436 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -111,6 +111,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,  {
 struct amdgpu_device *adev = smu->adev;
 int ret = 0, index = 0;
+int response;

 if (smu->adev->in_pci_err_recovery)
 return 0;
@@ -137,8 +138,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,

 ret = smu_cmn_wait_for_response(smu);
 if (ret) {
+response = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
-       smu_get_message_name(smu, msg), index, param, ret);
+       smu_get_message_name(smu, msg), index, param, response);
 goto out;
 }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C718dcaae805d4ff6474b08d8b3b33521%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637456929563780241%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Ja6ng8bQk7EFStqmiTizGOC202Aw78HLlL5XvXNKZzo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
