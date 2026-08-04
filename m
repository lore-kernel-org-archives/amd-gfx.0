Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F88C5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 17:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A7A10EB33;
	Tue,  4 Aug 2026 17:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pky1REXU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C7F10EB33
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 17:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mifb1o2qGtDmGPLcP0aTCpRXoA+lkHfVXD2bkUbRQPMF2qWabjkN7eNmPZf+6zWkMPVAdauHQBnKm65NZfGqYto6LC8PLgna2/aYiEvoBoRtSJ45J8pxOqbM/asIK7Ykbd8nC4xkGm5NLdvSm2Zm0zX0rRwvFt55Wh8kXUN5fIFAaQPXsOhq+58h+IXuKmpUzpAVF/2+HlMAVRJL3HANj3fL+MyH+XbCWCPtfdN6wfUhkn1joXBywyoqI0boEtA1z6yjxL7Shn+z6prfzPvuYWqhfNG61VRNMgP6QGZrvTHf1tSMp8l7CKpXWc590YjCVFRBBAnvP2kn8Qd/sIB/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vF3eh8QKo9L1QRH7yjTiNfoLnkzx4WonJcqhhZVktE=;
 b=weNDV33/kgYvExTi7c07jEhkcf0EJ4bCGvZOMN23mYsz68x7AnHjBTY1rTLl5f/9c9a3mx8oK3ZN0zurwoTCDsc5fVbl2Hc0+azQlzrBRjcF4duroffahKl+9eMVicIJxoflgyALN1ieCkhauTOP3Cq1YbQ5NgIjeUSIWNUTxdW+7WVMAt00mnlAz48/12aAoQWfUcIUvPXotYJR6VqiISBvU8wRO9uYJU0TQkMtMf4L0xCCQGtCQG7oHQzYY08+2jSdSS0PcISFUzK0if3buUpbtCKJGcWrPtkoxeRkMVH8ldsSBMEOBCrrQJiw6QQ4fIAPfBnUIvIFXdw0Ms8LQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vF3eh8QKo9L1QRH7yjTiNfoLnkzx4WonJcqhhZVktE=;
 b=Pky1REXUsG3XCYvwMzGV3nyUI0kTcCRhcikTi3X6zvZT6KDA0jh3y0FE95CziLKNbjN9dh+LsCS+6GFn3dZsLwONOhTaahytX3bIa0XisjXpvliiEzll83H+y7QdxhTQRZulwNwYM0vZINiyBjEQVXyWcMgk/+ilmUMt2PsiALU=
Received: from CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 17:11:02 +0000
Received: from CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd]) by CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 17:11:02 +0000
From: "Clement, Sunday" <Sunday.Clement@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Cui, Flora" <Flora.Cui@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>
Subject: RE: [PATCH] drm/amd/dkms: Fix TOCTOU symlink race in build directory
 creation
Thread-Topic: [PATCH] drm/amd/dkms: Fix TOCTOU symlink race in build directory
 creation
Thread-Index: AQHdHtIR++Vb+ntOGUqKeFyE6WinebaOKpEg
Date: Tue, 4 Aug 2026 17:11:02 +0000
Message-ID: <CY8PR12MB7563A817D9504F464AA1B08A9FD42@CY8PR12MB7563.namprd12.prod.outlook.com>
References: <20260728204513.5589-1-Sunday.Clement@amd.com>
In-Reply-To: <20260728204513.5589-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-04T17:10:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7563:EE_|IA1PR12MB8221:EE_
x-ms-office365-filtering-correlation-id: 090fd77c-9c38-4e81-d6aa-08def24b5c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: ZB8f1IEpB5iI8AyBQR22VvfggrAWz+uvxVWDNAMlw1notJM/GutSVZa8JGY23L6+K9tKzruqb9r08q3R/44J4NRNO7Gw1S63BekEbtLAIEs8h4fSkQSjv+k2J/xaiL/YUQm+h1Mt6r9SQbl6Hvx++scPORSP1vYRMw5rd53ydeO6dEHUis0cU9ZYdLtHc/CXgixmAGkZIMbBxkr/sPdJXzLcsfeZQMl0QO9i1dfviajc/tFJQukXvcbPy2VjRxbybIJsE5pXQ/dMYfmfbHjmK/DbjA3+PdzoS1xor8k8whb62fLCBwDFytZchp6YgOoTRQsEYep6f2Z0Ycva5VkBsxLuhTgpcQ9hD1zB+q14VfU3Fzob0L48W8QL5gAAbFDGr//pC1my57ECqzUXCXTvXCwzDBnuStCR32oFqaRu1YgBwM6meVEBy8iVaNHEWDdsUTvXyljk4yABUV9aRT46esRD8PzVw1ET+kz2o9Igj+WSJVz25aY6G4gFdDxEssrSXgGX5tItepNgR51fypFkvehA7M0iuKFf2W2hLnIVz/iETlLiPcp/XwrBfYwIZbh1tBf8emWUhRdhDB7qcg0AvuFVhQhfYyqaMr6v0sqAnZZum/+lhBr7iPP58nHLjSq5Aci9IXKKllBJIvy+zkmCtGZ3UUxdDrvnOMf7opbGwTVQ8AWsUgWDat+h/iIVp1Lloh12Z49czSh8yLUelChEYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7563.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jq4vdl9CyHJG54KcbaMz37XzAu4u9TMNuKITbNW5iIP8Go8ZzOpXUYMKbjDU?=
 =?us-ascii?Q?EOmMRjoP4LQ7+nL4TwqV3BfM0XHcgqShxHECQfUFZhUEkTZ/3ru0IEtlEfmS?=
 =?us-ascii?Q?SllkU2vhrUJ8OnUE4B1l5AODrX1a3G57Lsi1PnzT815h0oTdBsBGszHdL+2R?=
 =?us-ascii?Q?z11AMPkltdGay62G3EPF0virpz1WcFtsDOvb8UmmAediDf16PGDHZU/XB6JN?=
 =?us-ascii?Q?kSH6brW0/rd2IbbnhlGR4cUzMVwq1tuoVBp10x1D9Hvxgj5Lr4OUcAAz77S7?=
 =?us-ascii?Q?cVBXA8VPy2FFs38fhY9xqD0+vtExWLYDpq46IvIo+S6WeGQ7A2htn22nPJyq?=
 =?us-ascii?Q?wu02x47gnI0Y9sfA2u24BI1bbxkU1tBm2FCQ0ZQ9OTAEYW0XyG2OxncjOkdV?=
 =?us-ascii?Q?P+q3t08YD6XRRXg1ZLhfkaR8tOpoqmLrRjgL14bkegVcV53MXQCeFWLXAaNi?=
 =?us-ascii?Q?1cfjiyF9Gs4WmXCjl/kBWC/yZoEMRfREhCgUer1gs8X3ZomWiuOtdyXcvpCO?=
 =?us-ascii?Q?bi2dcch+W1Jjr2rvhNkk/2A0V+j8CA6AQSizj9vsLLD3GGXT/ffn+kNHUggL?=
 =?us-ascii?Q?3eCQzhfCKzJNDWKsmUZcUnvHHCPj83IKeOECfsPirgZ3cl7C5Gj92rS0N9bn?=
 =?us-ascii?Q?bZqEF/rUvQsda09b+uqMEMJyz4/rIPa30enw47EcB/uf9itp13xAO7pOQSTI?=
 =?us-ascii?Q?MWpQFjl1ayAfeHY7LEsNAe6LaR9u721uLmCmztZKvL1VkwbqwjaMJS2vFGq/?=
 =?us-ascii?Q?YUDXttQ/zEbPnxE4LCm450j24zB2+ds+XQSRRDb8EBpuvg6RSZqeMle6MApc?=
 =?us-ascii?Q?QWmokZ8RnqWjMyhX3FA5nSxS8SnBWsNEcOEwN0E2tI44CVelw4wnfAK1tHdo?=
 =?us-ascii?Q?wAJG9fXkRB2UbIIoqza/eC5qYVEL2VI6avjNxKaNFSSV8VXyzBzOPxZPHW9Q?=
 =?us-ascii?Q?cjoZOnIgrLPr2OShfvEUGcWIffhQ6MADh1py851VDxPmFY0QXUL9CjrMmy9s?=
 =?us-ascii?Q?6D4Zuc7PkSIwYAiQSrrflPzh4rn0bnfA+y8YepIjSS2dxIGlz+qgtrEsSYkL?=
 =?us-ascii?Q?5u032nJtuxM7R/D8Phg/A0H+kUdPqeSYgBKkda6CfMe3t2McVukSM2ga+m96?=
 =?us-ascii?Q?QuGhGKbPaDmHX31i7rJiQzO5+Yy+czdIQFYDZa0QYrPdxqhhK1qWIcD07FvR?=
 =?us-ascii?Q?kseZxTg6FJG4ijMHYKIHwKHA3Fnyd+1a5syotau1/fhjs6hdS374Z3xP4sZL?=
 =?us-ascii?Q?iZWV8r2lAInLbpNMN5LFh70GzxYgPfa5JX4RkZLmd3vhJIQE43B6MyKtT5NN?=
 =?us-ascii?Q?DYQ0e1QzMa69iTJJcH27FFTFMFo1iK+IjuMis/khu+nsoKxo29lQM54EEoor?=
 =?us-ascii?Q?Q1RU1cNlURiQYzzwbd68drq2E8z6MSqTnPaWUlhxLbWYsBbXuapQuvcAQBGh?=
 =?us-ascii?Q?3ekPYwLM7q7L/6EkJrDdms3Rm5/7d0p6a71HfEbyMvFBpr/6HCQ/B6kI55gp?=
 =?us-ascii?Q?aJlJb1ywqhbtNJGvOsHOiQcnC3YBzMRUA+3/P2/cphGBQ6PQls1Ede0tmTvw?=
 =?us-ascii?Q?x/os5m4dqTT/lTyjFTl4ivn3z8mFTR86Gu3lBqEcTap0Wztf3nf1Jio3WROZ?=
 =?us-ascii?Q?DTGSbCSJvMETWXcZz9SeJbYEMNe8bi5lBXRFJmpmy0+WjXj+bAByTV8aRij2?=
 =?us-ascii?Q?dyE1sn1mXJ3pvf6CeDR53rD19txRGfIcGnPB/ZCVbndLIa0t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7563.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090fd77c-9c38-4e81-d6aa-08def24b5c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 17:11:02.1997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGh+rdpD+PgblxfDQwfpiEUZLZx+8O08IVqJrsXKhMf8n9pCJwEOUGcbYAE82UDyA6Z+lfZ3+1RgKMjGZviPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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

AMD General

ping

> -----Original Message-----
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Tuesday, July 28, 2026 4:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Clement, Sunday <Sunday.Clement@amd.com>; Cui, Flora
> <Flora.Cui@amd.com>; Russell.Kent@amd.com; Clement, Sunday
> <Sunday.Clement@amd.com>
> Subject: [PATCH] drm/amd/dkms: Fix TOCTOU symlink race in build directory
> creation
>
> The DKMS Makefile used mktemp -u to generate a temporary directory name
> without atomically creating it, then root-privileged pre-build.sh later c=
reated a
> symlink at that path. A local unprivileged attacker could race to create =
a malicious
> symlink at the predicted path between name generation and actual use,
> redirecting root file writes or rm -rf cleanup to arbitrary paths. This a=
ttack recurs
> on every DKMS rebuild during kernel updates.
>
> Fix by replacing mktemp -ut with mktemp -dt to atomically create the dire=
ctory
> with mode 0700. Update pre-build.sh to remove the directory and recreate =
as
> symlink.
>
> Signed-off-by: Sunday Clement <sunday.clement@amd.com>
> ---
>  drivers/gpu/drm/amd/dkms/Makefile     | 2 +-
>  drivers/gpu/drm/amd/dkms/pre-build.sh | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/dkms/Makefile
> b/drivers/gpu/drm/amd/dkms/Makefile
> index 8112b9746c8f..02eea52ae0e7 100644
> --- a/drivers/gpu/drm/amd/dkms/Makefile
> +++ b/drivers/gpu/drm/amd/dkms/Makefile
> @@ -4,7 +4,7 @@ else
>  KERNELVER ?=3D $(shell uname -r)
>  kernel_build_dir :=3D /lib/modules/$(KERNELVER)/build  module_src_dir :=
=3D
> $(CURDIR) -module_build_dir :=3D $(shell mktemp -ut amd.XXXXXXXX)
> +module_build_dir :=3D $(shell mktemp -dt amd.XXXXXXXX)
>  module_build_flags :=3D
>  num_cpu_cores :=3D $(shell which nproc > /dev/null && nproc || echo "1")=
  CC :=3D
> gcc diff --git a/drivers/gpu/drm/amd/dkms/pre-build.sh
> b/drivers/gpu/drm/amd/dkms/pre-build.sh
> index 66f7177b6cf9..24f5a13ad854 100755
> --- a/drivers/gpu/drm/amd/dkms/pre-build.sh
> +++ b/drivers/gpu/drm/amd/dkms/pre-build.sh
> @@ -100,6 +100,10 @@ if version_lt 6.0; then  fi
>
>  export KERNELVER
> +# Security: MODULE_BUILD_DIR is now atomically created by mktemp -d
> +(mode 0700) # to eliminate TOCTOU symlink race. We need
> +MODULE_BUILD_DIR to be # a symlink to DKMS_TREE, so remove the directory
> and recreate as symlink.
> +rmdir $MODULE_BUILD_DIR
>  ln -s $DKMS_TREE $MODULE_BUILD_DIR
>  echo "PATH=3D$PATH" >$MODULE_BUILD_DIR/.env
>
> --
> 2.43.0

