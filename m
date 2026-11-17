Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24C606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYF4lRi1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C1710EBD8;
	Wed, 18 Nov 2026 08:25:51 +0000 (UTC)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5F410F889
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 18:36:04 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1ae58d17cd9so124312c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794940563; x=1795545363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rd0/jqMJRNHoYlSsIu6TbBr2fty8j4sVOq9BB4+EiWo=;
 b=GYF4lRi1VGHWiIOLfU/Q+fH4iAJsx343mtdH36T/a93eGYXNcnlViBfRVFRrzCGHi8
 fiMPQ8FzWybyriX7k5F6EFqJRyZzO40hJHTRARJ1BsX4OUiIOvOwJFL2aP03MV7DXsUz
 SN+PPanUpqN+Beij9E4DiVx5rEk/LH/9ysdzO1uOkS1jEMQGg0van7Deosvstpe1uFJd
 JjvxIPhjA0RJyhA4uSglZ8RiBfCLZGDQ8te/cOk0LLMln31gZ4TBKQWA9YcmJ/PB7N28
 pUD/uEG6P15uln24aqY2zaqVK2Pk0CE6/0dDrAx07QOB0YqiriMudZ6PJzCoNrMKvt46
 Obxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940563; x=1795545363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rd0/jqMJRNHoYlSsIu6TbBr2fty8j4sVOq9BB4+EiWo=;
 b=GF0rPUScr1ZJzUyDsJfnrWDRjKg2oMhPR7biiOV6l/YZLwLRI/IDkeuDCPzUdPlRkX
 W8I/sgYrAjfMX2m4yiQkRq2bwE13vqtCcCRzqC7+xXJL3TvUUtOlR9LBLVZ99g+YNkJB
 2lh7KDiZDeJJWmMH2j8/YRlGcvFvXmfRBXRpSapHJE+cIuxsd2igyTdpMnG+h0IO6qwp
 +DLjwT1oUD0HD3YzB7BtWUiDQgWMV7myXj7GVLK1KX9/fhYXk/QMBqSZOTwNvtxzcU6d
 W2QPXoWorZ249sxPaqnVmIJ+B6srumTxLig516VUXuXODCzPkoDh0Co5ORbKuoRwOCsi
 UtZQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEmS6c0pgv45iiAwEjqofshAlmjBV1R5tgcSmz6D8+Gkyjs+pmiiSrc+AnR7Q2VAMT0qCyYTLiH@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+B99OzlRwrBQROa9BExnpIbYeq8LxsrtSlV1ZhG6xg/m7LeHkU
 BMAi6u1Bb2qcAXmQLuzDSBVGx5V3esz6FAYYVfOikbJUIKxATulby5g=
X-Gm-Gg: AYBFou1aBZ+WdJXOh2uPulX5NVJcn+R/KA8gmDoLFE+1kKU9EXBv4eLl/2NgwPsdJxA
 1ia6JOIg+cw4/esHYZzU4Ot2rlTUbUmvXkuA6d35T0zXoBloKVwaQZb05qv0uQrQkbGak/4HouG
 uXb3WiEQWDqVAsI45e/yWFiEXgy6+Qt/lfmmjPRYs4kdsQ9Ys1GjGq3ZHGOy8njysFsfyWKwHf7
 Y33okQriJ2Ex8bh/FhmfhksJSutnMbq05+KTmgcQRvy4NqCjL1d3z8p0ZQTteyha+fR15l3o6Vb
 4T1PiYYwZjlIEGeGCTu4HZw9kkEA3neZs/DwsWwqt69f7BPq0v5y++owQpM4/uD9fAmUs5+fDmF
 WYzPtFqNgEkedExZ8KytWHllGg4NXM4PRUt/1fiwAmZhxIcmiYLrGy4hwVIeKvEcMd8vABkNhE9
 1MG9gcjxZKnrivzm6xXCYCoaoJgUA0rQNRQGm6ToyxkLKtF5w2z5Fdd9NhzUpFsl97muYXgByHK
 TY2iWXOglpdQTBk0y/wHXn0S3FysvyNgI2Ae93KWPMXR5rPvfiqzE3vvQY1Qfj29aC1vZSUfuWL
 qHWagivKWmYXbeH7tG2AqmbBFCKlfGK2bHg/jibh4N18k8kipyLqPjJu7DdM3yM=
X-Received: by 2002:a05:701b:2409:b0:1b3:b833:6565 with SMTP id
 a92af1059eb24-1b543cd7213mr469644c88.20.1794940563273; 
 Tue, 17 Nov 2026 10:36:03 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.59.94.173])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-380d5135221sm10562926eec.24.2026.11.17.10.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:36:02 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: helgaas@kernel.org
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 bhelgaas@google.com, bp@alien8.de, christian.koenig@amd.com,
 dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, szgit@icloud.com, tglx@kernel.org, x86@kernel.org,
 yossef.osman@proton.me
Subject: Re: [PATCH v2 02/12] PCI: Disable pcie port on specific amd devices
Date: Tue, 17 Nov 2026 13:35:46 -0500
Message-ID: <20261117183546.1214-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116202343.GA205416@bhelgaas>
References: <20261116202343.GA205416@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:25:50 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I don't know what's going on here, but it doesn't sound like typical
> PCIe behavior.  If a device is powered off, accesses to it end with
> some kind of PCIe error that is not normally fatal.
> 
> It's basically the same thing that happens when the OS enumerates
> devices by reading the Vendor and Device IDs.  This has to work even
> if there's no device present, which is essentially the same as a
> device being powered off.
> 
> So I'm not in favor of trying to avoid some accesses to devices based
> on DMI checks.  Even if that works, it doesn't cover other paths like
> sysfs.

I agree, this is not standard behaviour, this only happens when we use
GMUX to turn off the rails (which is the thing that causes power savings).

Accessing PCIe space after GMUX has cut power to the rails will cause a
CPU CATERR.

Also i dont really have ideas, im not really familiar with PCI core.
Can you give ideas, you have please?
