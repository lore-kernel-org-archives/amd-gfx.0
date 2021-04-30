Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E13C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 12:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F7B61477
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 12:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F7B61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495B56E07F;
	Fri, 30 Apr 2021 12:52:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB06A6E07F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 12:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAlDUdTAMyGp+HXd2QDCeXfebhuLY4v2pwQs4Mt/DbF14XRk8xzT33vsaS3YepbMKRx9ePNd3r+ax23QqGA+ybirFwm33hejR6yGgGm/w1sTXqXwalnF3zDTpKeYnXmEya7kYfxCbXUlgkszZYO11ulYqp6XaQ0+NO4BRqgPN3+SdPcSUC0tRiCI/LlGD7LZVQgmtLlzw/thTcvRUkNuUON33RnM05AUXzFBtK4YAoptUF0Bswk4YxKgtFBXg7rA6n+kzVfbdKhPBoRTdLBpwUCRBcFdV5VfU+IMcES/6aQjaEcJ6/GHhPr6Rr4puIRZ16/GBDsh0Mz+MNuCRpcLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyZA+MgvuHVuQ3BBW++0qYgN+YwUoxw1wC3wNLTJ/vU=;
 b=jxifDqYfl6P4d2T/JQ4JbG/GHdvAopxUBij3PWWVH2RcMi8enC1/4UHIKfucZ6UPE48xIQVRaJfjsZr+OfkE3Er3L89xaNE6D9BT74PxZvddf6leHc0KtaHRFgR5Ks/I1a+M5+Wz+T04jGFlsY07UePW7Jg8LHrLRgyrPiy3xE81xWAwPPEstE5aw4Z0eaMnh1yq27HLw2Abp0uYta+x403UIKtuK5OJYCILlW/KSQjib3W3DEvWlG3R+HkTKIut47zXuY7oGo8ar9qiDll8opypsZSRkmtqltR/xzvl2M9bbKg6ZB/zDPI+FkqUr0L4+lJUB560NMfMwof2YjROjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyZA+MgvuHVuQ3BBW++0qYgN+YwUoxw1wC3wNLTJ/vU=;
 b=gdJTpFGTEcyGssUTK2DrGFvs7zZVIy8zaLvM3XDueauv2B56JLzSEuvrKhrxVJebqD72plpSz7g0WTQJ8byXHDjVJ+vAqSIOJI76Ly1O+bplcmZTrGkRby5Lh8id5/DgEAFD4E+yIxscsYSrzGkZuw2cvnfia2VvprVW+qA8Mi4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Fri, 30 Apr 2021 12:52:24 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 12:52:24 +0000
Date: Fri, 30 Apr 2021 08:52:21 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Nirmoy Das <nirmoy.das@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: remove excess function parameter
Message-ID: <20210430125221.3lo5lvioo7nbrlk4@outlook.office365.com>
References: <20210430114324.14959-1-nirmoy.das@amd.com>
In-Reply-To: <20210430114324.14959-1-nirmoy.das@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:af63:9755:c34f:ce56]
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:af63:9755:c34f:ce56)
 by YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend
 Transport; Fri, 30 Apr 2021 12:52:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb73d3d-2ae9-4d83-5582-08d90bd6ccef
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB49732E3C273BCF83F373A0E4985E9@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyloEt5E9V/VXEf6qQagfGNFLFyo03a49VJkudYsQRhDn7pgiDEuu079/drEsKrmFTkvhXO9LRr0Lwe8Nqim1ClnDwa1ooMdMJofPr8in/ufIYQ21Jycw8y/gio0cjrK+DzsiLXYUoSEb7ZYCMrD/kR+9wxjKzkQ4erMyB+MTidIL7tlIAOkMPxTySbeyiPkAhG8bGSV5XYqWd9UoyXTANyUAUX040KipBWMihim7DRUN0wu6ov7bXap203+AJpaDph/BpCFZ2FyuVnnDPci4nY34PmqrGVPYdTgE1RZ/AMPjop/x55eAvEk5xLv4ckj+IKWaGwM2cwGavndB013r8ROmYt/cMMnvsfDdw5/1AsjIeo894iVhHGQ8IpYgfDMfDiKDil47N6rMNqW1o6wJgHu9yulvSC24v9vCMJ+mY6tJN4hhRxHnya3Dilj2R8bLLSTJI59jWfriGWca32ApbW6f0WPDdsuYjBRUhH9pVVmcU4PoZdg+JYxHEVJ81/x6+XRcsUG28Y3dANRlQU/uRxNUcXfHZDviHXep3YKRjnDwXuhKtouP8xn1QLPDGVPdIIrOUCCZf0ylBarr5sfraEonbybAUlsCb6xsqdRCQdBoS6+RsFjPIK0eRqFcc3C1tbdDJySoNq4OFRBhRJVPIS+1czYjNLA5AazAxdNqQYp095A5qdLL29Y75/vf0FYyNMQuHPyXtbcW2yjxzMGnP0tiSoWYFc8zcnPQ5J5KVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(4326008)(66556008)(186003)(66476007)(16526019)(6862004)(7696005)(9686003)(55016002)(38100700002)(2906002)(5660300002)(66946007)(6636002)(478600001)(86362001)(21480400003)(6506007)(966005)(83380400001)(8676002)(1076003)(52116002)(316002)(44144004)(45080400002)(8936002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?npZy3noNVs+Mm+z7vemt6bZxXnG/F+Pn8bDawfwaDYLHZsD2357cbdgnivPr?=
 =?us-ascii?Q?kyEg6e8SbWTUj9cDt9fjJgupTFrXSV2g5K+3KbKA+wuWfpJu8u7/BpIPbvc8?=
 =?us-ascii?Q?BZwaE9gdJd6FW9LABlLMxV/Lrq1EemD16v9smcRUoa04ZyvRrYM2l+Gb5sVh?=
 =?us-ascii?Q?7MvBDlidYGsFeHCdrJN/GK09wqe9suHESIOkqdg1JvhFxbXmYE0UzcJNj7B7?=
 =?us-ascii?Q?mP+ag1HAVXG0hXj29rIcJfLe01AqVLny4ttQ0HRbDyz3UcTfDQrIXnMiYzhL?=
 =?us-ascii?Q?B44u5ukijhJWxHbcbzX+5anc7aW5QyUzeK0jkrPgQGugH4RT8O+guY7736kS?=
 =?us-ascii?Q?O0qbEdfQ8hNaYj8vxllojF3DVZkNrz9p/YsB7/qnP2etW9jrvwqD005gGaLi?=
 =?us-ascii?Q?fJfEeY85hjexdF3ejNOLgDVU+4orDV/r4zXqnHVlhEAlW4IhfVxKpCcCK9Xw?=
 =?us-ascii?Q?DYl2+W6v6qkVLgcZ5xmd7iupokTqClQhhyNcZM2DDm31oulIFL4mHdSYBh+M?=
 =?us-ascii?Q?HevedZa1ho6wTKdK4zyVzyS+OvTxnMWeEok+avoPGBYhWCFn5ZlXMxnLoW16?=
 =?us-ascii?Q?k1eae+dfr2n12Pc1MCZtTFgC/fgOlqnrvciFSC5GZ9Z8Q87bPLZpwnEI0kRa?=
 =?us-ascii?Q?stgeWwPXarsIu/9y47YCQ2y0t6X3DacpYIIPkSh9R9mh5LZgXWO/rP3Q5tA5?=
 =?us-ascii?Q?YdPMpym5vfTOI15gqcaEUOBLLq7zVbVAXMjLIY0TZMM+dgNskYxqcXsEAJVt?=
 =?us-ascii?Q?gEOr3fSpW6dpyx+mNR4/n774xQeyl2jRLwSlELMkF6w/l4B+8650oXyfg+Av?=
 =?us-ascii?Q?m3gnL0X6HIgMFbddXqTkJAHPhdEBRevFCUKn8OxpqBx/qfsvFJ4zQpo6DlKa?=
 =?us-ascii?Q?+AML4FFi3QFgDpAmQM08AqBn6zm/BQ+C7VhnHhNwPL/tMFP1uB9ttJ6ku1+t?=
 =?us-ascii?Q?rinwa8x9bAfaJHS7+j0ipsVuhBiXOT3ottMOGhq/BGj0yzMVAU5/KCS0Sbvu?=
 =?us-ascii?Q?nNpvvSe5A0uadGVL2vjsxhsln0C968R3ZhSbcsvnxrf0+DGv5pdhNpDOhpja?=
 =?us-ascii?Q?FFn0Clf+UOGB1g8zgflT6oxQNorSHxsxMHVHXcozpdaxka0pvL48XXo5FOOs?=
 =?us-ascii?Q?XBQO6T/ORDRBrZ5ejG5QC3EH/o5/McqNr09JKoJhAs604Y8HqaWNN1pKpO9r?=
 =?us-ascii?Q?zI9l2r0btmP75laqtd5bzwd87qDUkI4clEMxPX0qAgBEzO/Se2kSVmrSMUop?=
 =?us-ascii?Q?cyVwkMsXR+DPtW+5rX+Jnasg6wJtAtPVnkC4Wjlieu/zAsYc9nWeTMIApffY?=
 =?us-ascii?Q?xLNWk7oXRxpbeI2oehCLnP0yk92JS1GxCQieBD4TSzg/1Sz4at/AJCqAbWdN?=
 =?us-ascii?Q?79Q7GHW0uXCk/vilUCVEJ2bPkSFU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb73d3d-2ae9-4d83-5582-08d90bd6ccef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 12:52:23.9659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8rjE7+2kg2CoD+FWa3SDB/iUUuc8fjfy+HVHQolJL2RdEn+WT7vcekfoBm3s32zaONO0A2HVLoKI5ABlKMlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
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
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0408842298=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0408842298==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6s3phtzcctn2ouy"
Content-Disposition: inline

--c6s3phtzcctn2ouy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On 04/30, Nirmoy Das wrote:
> Fixes: 49020fc1f5("drm/amdgpu: cleanup amdgpu_vm_init()")

Just for curiosity, do we need the Fixes tag for this?

How about adding the warning/error message that this patch fixes? I
think this can be useful for other people searching for a similar fix in
the git log (I do it sometimes).

Thanks
Siqueira
=20
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index dae51992c607..f2513be72980 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2796,7 +2796,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long=
 timeout)
>   *
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
> - * @vm_context: Indicates if it GFX or Compute context
>   * @pasid: Process address space identifier
>   *
>   * Init @vm fields.
> --=20
> 2.30.2
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7Ca88acdf110bc4994ff3c08d90bcd36f6%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637553798286590199%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DtS6NA4FPNYFPCbIdngKshN3I%2BwRwAumgC0vdA50h9l8%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--c6s3phtzcctn2ouy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmCL/YAACgkQWJzP/com
vP/Dtw//cNA16rjGwK+k3e6scK87aIvxL6f324kW4YazYaVwLe/kBkbiw/pCU8Jt
sPJk2KxzW2M74XSejGE9QiRFGXwEotGwJbIjkMM5w+O3FsnRN8GZcJ1H1jBzwnlC
tWZBoqOw2cg+JquhZPZoBXbziGew4yqVdssqlg7dn3LD2+xrOxs7VYr0GRqFCjEM
Q12BagbxHnQsdM1QgMT5uXYqqLjpf32U7QBev2u4oi2IsI45ZhIvTNhDVTceUSCC
B+UYe5PfP/pYWXi67eEfdszKwZdPA5WZ/xOULuYRA/VxY8Pv+1jIEuFpx2g4souz
eiGH9+z/UL//4RXdLMCcOE9kr7WKAFOgeMP5xqOfuRB6MCNNiBkrHntWbm9EmvdX
ADjVoiLX/tCZHYCiLKIuV2EMRjPU3gJEl7+wcTWuZ2QmV4hHZf1GJzfjj0I2bn2K
UhAiU03NkSyS2Ckd6hO/zAcUAnPrmls7ZenhcsE0bGy7liS8UBbzV1weqyxXqo6k
+tXnRGwq/3vemcAA8IgHAPEFAtxDFNXKmoItaIZtOaH7t6rcYb+3MBSKokmmRYtX
h/ysR5QaFoTFcHQiFozYsCVc6QEPsxyQ2i6QDXAL0f98Qu27+m3UbzAQ2t5JZsns
mrLBIAUwY227W1j1CV1A2+m3Vya3mFU/h8hkGAIDPLk4umacNgc=
=/UCV
-----END PGP SIGNATURE-----

--c6s3phtzcctn2ouy--

--===============0408842298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0408842298==--
