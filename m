Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F7DC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 20:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90CD2078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 20:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NgtwlX5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90CD2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590456EAD9;
	Wed, 26 Aug 2020 20:02:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5B36EAA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 20:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtYujhbqkugkB+o8XexvXist9elDGBZrBh6+vPgiBxRRN/oU360AVQZYW9dyuZkmH6rEPpTbIOaaY9ZBAd5nMemBFAuHdZhSncbHA/8gluGvCjEd8+b4Oeb02LpswtdkqAPFOA/0q4hxdxEZ6apj5aFSdJgwnUOPvM2KAQexEyLjcQMjIcHWKhrshQYfXuxY5KDDV2+W7+sdu4YVVyInk8TeVcsT5peg7Dl7YzAWzx8lWaBNkgdIWR6DtZ+ixH8LUPwV5lsDUZM1IDHkUIqxQGb0qxvlPA47FTTbiyOg14jf/WFhAWj6Oz4PL0pq+WGnZy5rrXe/afnYqXs/WKLgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVMt5h97JO+NNxy6TLVxg2teqssbq5FQwpdbuPFP7SA=;
 b=ZaG848LjYGyZAnvctS0VJuizm1mPhh3K83jVopb3heshoY9Nfcu/7kaJrguAYse4cr2n7XYdos1BZpp8fWJ1cUip6M/e/6AZpEUTZuPt+nzu4y7jykIYZg516nKjP7J1iI5eq+72VhRpvg6ypQgSKLLr4Dl99sygG1aFRaXmcbyVSxj6SNHLHka3nNqB0Uh1eNqJ7GlKiRX+x0+nJtrwR38pAtpDAGVcA72XAWbMh7uj4CEGKX8m0C+Wft8D6JVvThREyiIau56WyKl8WT9z0Li6v1CEddt0DcIPzDb8aThx2qiepBtestK4MNG2q9W+swMHIBuMJ7bO1u1Dy7Tn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVMt5h97JO+NNxy6TLVxg2teqssbq5FQwpdbuPFP7SA=;
 b=NgtwlX5Qi390ywuu+OggwSiLjs/7iXpvKMl7wUqsOgR08+FOzuadnPD/7avTAXbr+sn/bWdTJ8GP6ntR+1YmNoVoRyb7uGSM2VMyNTvq52bLeqsvf7cQDWtgh/lXg5okaIMCcqZj915GQVVpuxst4zcRMGSWNV/YtMJOEsFGL08=
Received: from DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) by
 DM6PR12MB3436.namprd12.prod.outlook.com (2603:10b6:5:11b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Wed, 26 Aug 2020 20:02:09 +0000
Received: from DM6PR12MB2746.namprd12.prod.outlook.com
 ([fe80::c177:e166:96f:3d57]) by DM6PR12MB2746.namprd12.prod.outlook.com
 ([fe80::c177:e166:96f:3d57%3]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 20:02:09 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: =?iso-8859-1?Q?Nils_Wallm=E9nius?= <nils.wallmenius@gmail.com>
Subject: RE: [PATCH] drm/amdkfd: Add GPU reset SMI event
Thread-Topic: [PATCH] drm/amdkfd: Add GPU reset SMI event
Thread-Index: AQHWexOzAQjkYiLmwkCbGANM6iJg36lKD+MAgADBIUA=
Date: Wed, 26 Aug 2020 20:02:09 +0000
Message-ID: <DM6PR12MB27466F5282D851BBF95C1E84EE540@DM6PR12MB2746.namprd12.prod.outlook.com>
References: <20200825191223.7795-1-mukul.joshi@amd.com>
 <CA+nq7Ds2Xr63Bk_SGiaaFbeT+JzwTwyP=143s=_q4T+zTao2qA@mail.gmail.com>
In-Reply-To: <CA+nq7Ds2Xr63Bk_SGiaaFbeT+JzwTwyP=143s=_q4T+zTao2qA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-26T20:01:16Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7381ffdf-5028-4e39-8153-00001ffc5062;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-26T20:01:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d9f88ab1-ca83-41b6-aacd-0000ad4ba155
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: Responding to a review.
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.140.198.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e509e9df-ab94-419b-79af-08d849faea3f
x-ms-traffictypediagnostic: DM6PR12MB3436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34369FB086C0A3038A9E522AEE540@DM6PR12MB3436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5dkZLP/i+Y1DC+fPjvdyU4xW660MIfyHCTMWGsnjczEgjEC8J2mJzcxnWDJlpBvCCrX/joT6CwVJ8tVC9i2w9T1HhmexctJ1YPSNLZJ4QrSLsMgu8Qp66Myyw6n2hCqN3h7eI4amx574pIzKFuuceRl9aDy4pRoKgIbcfOY6ZPUPza3tKoBDBG7tDeurG8jHB4fvSQapaOdOCxpmBCD8QZSysTqbrDRyPweD6/w3iZmQgsUEjOlYgt8VzndkSCEO+Qo7fuWgOrBuiA4T5a5GsGvaxQJagtmEXLPz1arEh/FwP+k6++2h0EEzA3cLnDP9sskyQTvBwW70qiT4OiO3/0yXGmdWQreridVIgmXVk8k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2746.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(9686003)(478600001)(7696005)(2906002)(316002)(66574015)(66556008)(66476007)(966005)(66446008)(71200400001)(66946007)(8676002)(55016002)(54906003)(64756008)(8936002)(4326008)(76116006)(26005)(186003)(86362001)(83380400001)(166002)(6506007)(53546011)(33656002)(6916009)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5w8DhaL0gK5q1jtd3AX2ruBDhL+aVT5KHnw3iWJy4cIeQiqxpqzKM688YQZ1kieystcs9MMniLKOzemDfcjZXko+LOEKlyHEyIM7kTFECdLtND/pxlVNUZky1RPRkijnTqXfj+CZACm60RAl8TYV+eXCVWSdCK71Mb48nFEsGJyyMbXFNFCI2O2hJRooJCSXSP8DlghqCF0batuUFf105DmAby88NVzP5gm89H6WEnWNgbrqmT+cAYfHvSQ+ag0tpx/lhm1W1EzIk1RCeI2XbKpEkZSITwzt1mSitVPgG8U5UqMY2q8+wS4VNSzggfx3fgl2R9fEqLs936i736Gzl5zZkAWHEyCofVJsDbfcRDXBAmkq4dTFLvsZio7kSDQmSMRIGU4D4P9Psf/rq2sxj/fNNHfyYrZIDUKJDpKPiKAKtoWR4WFTzJSOcRVOGr1lPk+SZTIthMgEs6U79KbgAQTQG458SVuN/BuJCN6T2IZ3mUBP2PIBEkhu6q3r/PUKu2ATkQMDkeqM15Gw8QohzfkAp1dpr0LmPdKF4XNWP3hzNIPU5tvlGI98SJ1oluRCN0mGNUoP6cZYCPc+yhd6z9R3RJxOM4DIlKLs1THtokfkgAwnw9O03lB6ngEC/pm/Ae29DQQhHTQBtIf2+euvnQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2746.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e509e9df-ab94-419b-79af-08d849faea3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 20:02:09.2925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaG2AKmg1kNl8BvCda6UDSYcZHXeGOTvGFHfF7xjFSab6R+eD9lGMCPnoQn1eO3t4T1R8T+V0FJra0T9qRNM/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3436
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1388438914=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1388438914==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB27466F5282D851BBF95C1E84EE540DM6PR12MB2746namp_"

--_000_DM6PR12MB27466F5282D851BBF95C1E84EE540DM6PR12MB2746namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Sorry I missed that. Thanks for pointing it out.
I will send out an updated patch.

Thanks,
Mukul

From: Nils Wallm=E9nius <nils.wallmenius@gmail.com>
Sent: Wednesday, August 26, 2020 4:30 AM
To: Joshi, Mukul <Mukul.Joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Add GPU reset SMI event

[CAUTION: External Email]
Hi, see inline comment below.
Den tis 25 aug. 2020 21:12Mukul Joshi <mukul.joshi@amd.com<mailto:mukul.jos=
hi@amd.com>> skrev:
Add support for reporting GPU reset events through SMI. KFD
would report both pre and post GPU reset events.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com<mailto:mukul.joshi@amd.com>=
>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h       |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 30 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h              |  2 ++
 5 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index e1cd6599529f..aad1ecfa1239 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -812,6 +812,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
        if (!kfd->init_complete)
                return 0;

+       kfd_smi_event_update_gpu_reset(kfd, false);
+
        kfd->dqm->ops.pre_reset(kfd->dqm);

        kgd2kfd_suspend(kfd, false);
@@ -833,6 +835,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
        if (!kfd->init_complete)
                return 0;

+       kfd_smi_event_update_gpu_reset(kfd, true);
+
        ret =3D kfd_resume(kfd);
        if (ret)
                return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 18bc711f97ae..b1a2979e086f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -312,6 +312,8 @@ struct kfd_dev {
        /* Clients watching SMI events */
        struct list_head smi_clients;
        spinlock_t smi_lock;
+
+       uint64_t reset_seq_num;
 };

 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.c
index 4d4b6e3ab697..448abfdde230 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -174,6 +174,36 @@ static void add_event_to_kfifo(struct kfd_dev *dev, un=
signed int smi_event,
        rcu_read_unlock();
 }

+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
+{
+       /*
+        * GpuReset msg =3D Reset seq number (incremented for
+        * every reset message sent before GPU reset).
+        * 1 byte event + 1 byte space + 16 bytes seq num +
+        * 1 byte \n + 1 byte \0 =3D 20
+        */
+       char fifo_in[20];
+       int len;
+       unsigned int event;
+
+       if (list_empty(&dev->smi_clients)) {
+               return;
+       }
+
+       memset(fifo_in, 0x0, sizeof(fifo_in));
+
+       if (post_reset) {
+               event =3D KFD_SMI_EVENT_GPU_POST_RESET;
+       } else {
+               event =3D KFD_SMI_EVENT_GPU_PRE_RESET;
+               ++(dev->reset_seq_num);
+       }
+
+       len =3D snprintf(fifo_in, 4, "%x %llx\n", event, dev->reset_seq_num=
);

I think the 4 will cause truncation of the message here.

Regards
Nils

+
+       add_event_to_kfifo(dev, event, fifo_in, len);
+}
+
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
                                             uint32_t throttle_bitmask)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.h
index 15537b2cccb5..b9b0438202e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -27,5 +27,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)=
;
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
                                             uint32_t throttle_bitmask);
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);

 #endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index cb1f963a84e0..8b7368bfbd84 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -453,6 +453,8 @@ enum kfd_smi_event {
         KFD_SMI_EVENT_NONE =3D 0, /* not used */
         KFD_SMI_EVENT_VMFAULT =3D 1, /* event start counting at 1 */
         KFD_SMI_EVENT_THERMAL_THROTTLE =3D 2,
+       KFD_SMI_EVENT_GPU_PRE_RESET =3D 3,
+       KFD_SMI_EVENT_GPU_POST_RESET =3D 4,
 };

 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7Cmukul.joshi%40amd.com%7Cf1f1b5a5=
22714387b43808d8499a2fd6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63734=
0273862855741&sdata=3DS9Ch%2BXajhfEnZ7pn2DV%2F1Pb9%2FCSZfujBkxIw9INjvEg%3D&=
reserved=3D0>

--_000_DM6PR12MB27466F5282D851BBF95C1E84EE540DM6PR12MB2746namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Offi=
cial Use Only - Internal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry I missed that. Thanks for pointing it out.<o:p=
></o:p></p>
<p class=3D"MsoNormal">I will send out an updated patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Mukul<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Nils Wallm=E9nius &lt;nils.wallmenius@g=
mail.com&gt; <br>
<b>Sent:</b> Wednesday, August 26, 2020 4:30 AM<br>
<b>To:</b> Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org; Kuehling, Felix &lt;Felix.Kuehlin=
g@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Add GPU reset SMI event<o:p></o:p><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[CAUTION: External Email] <o:p></o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hi, see inline commen=
t below.<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Den tis 25 aug. 2020 21:12Mukul Joshi &lt;<a href=3D=
"mailto:mukul.joshi@amd.com">mukul.joshi@amd.com</a>&gt; skrev:<o:p></o:p><=
/p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal">Add support for reporting GPU reset events through S=
MI. KFD<br>
would report both pre and post GPU reset events.<br>
<br>
Signed-off-by: Mukul Joshi &lt;<a href=3D"mailto:mukul.joshi@amd.com" targe=
t=3D"_blank">mukul.joshi@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp; &nbsp; &nbsp;|&nbsp; 4 =
+++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp; &nbsp; &nbsp; &nbsp;|&nbs=
p; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 30 ++++++++++++++++++++=
+<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |&nbsp; 1 +<br>
&nbsp;include/uapi/linux/kfd_ioctl.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; |&nbsp; 2 ++<br>
&nbsp;5 files changed, 39 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index e1cd6599529f..aad1ecfa1239 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -812,6 +812,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (!kfd-&gt;init_complete)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
<br>
+&nbsp; &nbsp; &nbsp; &nbsp;kfd_smi_event_update_gpu_reset(kfd, false);<br>
+<br>
&nbsp; &nbsp; &nbsp; &nbsp; kfd-&gt;dqm-&gt;ops.pre_reset(kfd-&gt;dqm);<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; kgd2kfd_suspend(kfd, false);<br>
@@ -833,6 +835,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (!kfd-&gt;init_complete)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
<br>
+&nbsp; &nbsp; &nbsp; &nbsp;kfd_smi_event_update_gpu_reset(kfd, true);<br>
+<br>
&nbsp; &nbsp; &nbsp; &nbsp; ret =3D kfd_resume(kfd);<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (ret)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 18bc711f97ae..b1a2979e086f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -312,6 +312,8 @@ struct kfd_dev {<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* Clients watching SMI events */<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct list_head smi_clients;<br>
&nbsp; &nbsp; &nbsp; &nbsp; spinlock_t smi_lock;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint64_t reset_seq_num;<br>
&nbsp;};<br>
<br>
&nbsp;enum kfd_mempool {<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.c<br>
index 4d4b6e3ab697..448abfdde230 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<br>
@@ -174,6 +174,36 @@ static void add_event_to_kfifo(struct kfd_dev *dev, un=
signed int smi_event,<br>
&nbsp; &nbsp; &nbsp; &nbsp; rcu_read_unlock();<br>
&nbsp;}<br>
<br>
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)<=
br>
+{<br>
+&nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+&nbsp; &nbsp; &nbsp; &nbsp; * GpuReset msg =3D Reset seq number (increment=
ed for<br>
+&nbsp; &nbsp; &nbsp; &nbsp; * every reset message sent before GPU reset).<=
br>
+&nbsp; &nbsp; &nbsp; &nbsp; * 1 byte event + 1 byte space + 16 bytes seq n=
um +<br>
+&nbsp; &nbsp; &nbsp; &nbsp; * 1 byte \n + 1 byte \0 =3D 20<br>
+&nbsp; &nbsp; &nbsp; &nbsp; */<br>
+&nbsp; &nbsp; &nbsp; &nbsp;char fifo_in[20];<br>
+&nbsp; &nbsp; &nbsp; &nbsp;int len;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;unsigned int event;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (list_empty(&amp;dev-&gt;smi_clients)) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;memset(fifo_in, 0x0, sizeof(fifo_in));<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (post_reset) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;event =3D KFD_SMI_E=
VENT_GPU_POST_RESET;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;event =3D KFD_SMI_E=
VENT_GPU_PRE_RESET;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;++(dev-&gt;reset_se=
q_num);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;len =3D snprintf(fifo_in, 4, &quot;%x %llx\n&qu=
ot;, event, dev-&gt;reset_seq_num);<o:p></o:p></p>
</blockquote>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I think the 4 will cause truncation of the message h=
ere.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Nils<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal">+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;add_event_to_kfifo(dev, event, fifo_in, len);<b=
r>
+}<br>
+<br>
&nbsp;void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;uint32_t throttle_bitmask)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.h<br>
index 15537b2cccb5..b9b0438202e2 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<br>
@@ -27,5 +27,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)=
;<br>
&nbsp;void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid=
);<br>
&nbsp;void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;uint32_t throttle_bitmask);<br>
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);=
<br>
<br>
&nbsp;#endif<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index cb1f963a84e0..8b7368bfbd84 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
+++ b/include/uapi/linux/kfd_ioctl.h<br>
@@ -453,6 +453,8 @@ enum kfd_smi_event {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;KFD_SMI_EVENT_NONE =3D 0, /* not used */<=
br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;KFD_SMI_EVENT_VMFAULT =3D 1, /* event sta=
rt counting at 1 */<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;KFD_SMI_EVENT_THERMAL_THROTTLE =3D 2,<br>
+&nbsp; &nbsp; &nbsp; &nbsp;KFD_SMI_EVENT_GPU_PRE_RESET =3D 3,<br>
+&nbsp; &nbsp; &nbsp; &nbsp;KFD_SMI_EVENT_GPU_POST_RESET =3D 4,<br>
&nbsp;};<br>
<br>
&nbsp;#define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL &lt;&lt; ((i) - 1))<br=
>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cmukul.joshi%40amd.com%7Cf1f1b5a522714387b43808d8499a2fd6%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637340273862855741&amp;sdata=3DS9Ch%2BXajhfEn=
Z7pn2DV%2F1Pb9%2FCSZfujBkxIw9INjvEg%3D&amp;reserved=3D0" target=3D"_blank">=
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB27466F5282D851BBF95C1E84EE540DM6PR12MB2746namp_--

--===============1388438914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1388438914==--
