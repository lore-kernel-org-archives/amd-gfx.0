From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] drm/prime: forward begin_cpu_access callback to
 drivers
Date: Sat, 16 Dec 2017 14:29:04 +0800
Message-ID: <201712161301.Em3Ypszg%fengguang.wu@intel.com>
References: <1513355282-20248-1-git-send-email-Samuel.Li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1513355282-20248-1-git-send-email-Samuel.Li@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Samuel Li <Samuel.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kbuild-all@01.org, dri-devel@lists.freedesktop.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.15-rc3 next-20171215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Samuel-Li/drm-prime-forward-begin_cpu_access-callback-to-drivers/20171216-125056
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: i386-randconfig-a0-201750 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_drv.c:36:0:
>> include/drm/drm_drv.h:494:14: warning: 'enum dma_data_direction' declared inside parameter list
            enum dma_data_direction direction);
                 ^
>> include/drm/drm_drv.h:494:14: warning: its scope is only this definition or declaration, which is probably not what you want

vim +494 include/drm/drm_drv.h

    59	
    60	/**
    61	 * struct drm_driver - DRM driver structure
    62	 *
    63	 * This structure represent the common code for a family of cards. There will
    64	 * one drm_device for each card present in this family. It contains lots of
    65	 * vfunc entries, and a pile of those probably should be moved to more
    66	 * appropriate places like &drm_mode_config_funcs or into a new operations
    67	 * structure for GEM drivers.
    68	 */
    69	struct drm_driver {
    70		/**
    71		 * @load:
    72		 *
    73		 * Backward-compatible driver callback to complete
    74		 * initialization steps after the driver is registered.  For
    75		 * this reason, may suffer from race conditions and its use is
    76		 * deprecated for new drivers.  It is therefore only supported
    77		 * for existing drivers not yet converted to the new scheme.
    78		 * See drm_dev_init() and drm_dev_register() for proper and
    79		 * race-free way to set up a &struct drm_device.
    80		 *
    81		 * This is deprecated, do not use!
    82		 *
    83		 * Returns:
    84		 *
    85		 * Zero on success, non-zero value on failure.
    86		 */
    87		int (*load) (struct drm_device *, unsigned long flags);
    88	
    89		/**
    90		 * @open:
    91		 *
    92		 * Driver callback when a new &struct drm_file is opened. Useful for
    93		 * setting up driver-private data structures like buffer allocators,
    94		 * execution contexts or similar things. Such driver-private resources
    95		 * must be released again in @postclose.
    96		 *
    97		 * Since the display/modeset side of DRM can only be owned by exactly
    98		 * one &struct drm_file (see &drm_file.is_master and &drm_device.master)
    99		 * there should never be a need to set up any modeset related resources
   100		 * in this callback. Doing so would be a driver design bug.
   101		 *
   102		 * Returns:
   103		 *
   104		 * 0 on success, a negative error code on failure, which will be
   105		 * promoted to userspace as the result of the open() system call.
   106		 */
   107		int (*open) (struct drm_device *, struct drm_file *);
   108	
   109		/**
   110		 * @postclose:
   111		 *
   112		 * One of the driver callbacks when a new &struct drm_file is closed.
   113		 * Useful for tearing down driver-private data structures allocated in
   114		 * @open like buffer allocators, execution contexts or similar things.
   115		 *
   116		 * Since the display/modeset side of DRM can only be owned by exactly
   117		 * one &struct drm_file (see &drm_file.is_master and &drm_device.master)
   118		 * there should never be a need to tear down any modeset related
   119		 * resources in this callback. Doing so would be a driver design bug.
   120		 */
   121		void (*postclose) (struct drm_device *, struct drm_file *);
   122	
   123		/**
   124		 * @lastclose:
   125		 *
   126		 * Called when the last &struct drm_file has been closed and there's
   127		 * currently no userspace client for the &struct drm_device.
   128		 *
   129		 * Modern drivers should only use this to force-restore the fbdev
   130		 * framebuffer using drm_fb_helper_restore_fbdev_mode_unlocked().
   131		 * Anything else would indicate there's something seriously wrong.
   132		 * Modern drivers can also use this to execute delayed power switching
   133		 * state changes, e.g. in conjunction with the :ref:`vga_switcheroo`
   134		 * infrastructure.
   135		 *
   136		 * This is called after @postclose hook has been called.
   137		 *
   138		 * NOTE:
   139		 *
   140		 * All legacy drivers use this callback to de-initialize the hardware.
   141		 * This is purely because of the shadow-attach model, where the DRM
   142		 * kernel driver does not really own the hardware. Instead ownershipe is
   143		 * handled with the help of userspace through an inheritedly racy dance
   144		 * to set/unset the VT into raw mode.
   145		 *
   146		 * Legacy drivers initialize the hardware in the @firstopen callback,
   147		 * which isn't even called for modern drivers.
   148		 */
   149		void (*lastclose) (struct drm_device *);
   150	
   151		/**
   152		 * @unload:
   153		 *
   154		 * Reverse the effects of the driver load callback.  Ideally,
   155		 * the clean up performed by the driver should happen in the
   156		 * reverse order of the initialization.  Similarly to the load
   157		 * hook, this handler is deprecated and its usage should be
   158		 * dropped in favor of an open-coded teardown function at the
   159		 * driver layer.  See drm_dev_unregister() and drm_dev_put()
   160		 * for the proper way to remove a &struct drm_device.
   161		 *
   162		 * The unload() hook is called right after unregistering
   163		 * the device.
   164		 *
   165		 */
   166		void (*unload) (struct drm_device *);
   167	
   168		/**
   169		 * @release:
   170		 *
   171		 * Optional callback for destroying device data after the final
   172		 * reference is released, i.e. the device is being destroyed. Drivers
   173		 * using this callback are responsible for calling drm_dev_fini()
   174		 * to finalize the device and then freeing the struct themselves.
   175		 */
   176		void (*release) (struct drm_device *);
   177	
   178		/**
   179		 * @get_vblank_counter:
   180		 *
   181		 * Driver callback for fetching a raw hardware vblank counter for the
   182		 * CRTC specified with the pipe argument.  If a device doesn't have a
   183		 * hardware counter, the driver can simply leave the hook as NULL.
   184		 * The DRM core will account for missed vblank events while interrupts
   185		 * where disabled based on system timestamps.
   186		 *
   187		 * Wraparound handling and loss of events due to modesetting is dealt
   188		 * with in the DRM core code, as long as drivers call
   189		 * drm_crtc_vblank_off() and drm_crtc_vblank_on() when disabling or
   190		 * enabling a CRTC.
   191		 *
   192		 * This is deprecated and should not be used by new drivers.
   193		 * Use &drm_crtc_funcs.get_vblank_counter instead.
   194		 *
   195		 * Returns:
   196		 *
   197		 * Raw vblank counter value.
   198		 */
   199		u32 (*get_vblank_counter) (struct drm_device *dev, unsigned int pipe);
   200	
   201		/**
   202		 * @enable_vblank:
   203		 *
   204		 * Enable vblank interrupts for the CRTC specified with the pipe
   205		 * argument.
   206		 *
   207		 * This is deprecated and should not be used by new drivers.
   208		 * Use &drm_crtc_funcs.enable_vblank instead.
   209		 *
   210		 * Returns:
   211		 *
   212		 * Zero on success, appropriate errno if the given @crtc's vblank
   213		 * interrupt cannot be enabled.
   214		 */
   215		int (*enable_vblank) (struct drm_device *dev, unsigned int pipe);
   216	
   217		/**
   218		 * @disable_vblank:
   219		 *
   220		 * Disable vblank interrupts for the CRTC specified with the pipe
   221		 * argument.
   222		 *
   223		 * This is deprecated and should not be used by new drivers.
   224		 * Use &drm_crtc_funcs.disable_vblank instead.
   225		 */
   226		void (*disable_vblank) (struct drm_device *dev, unsigned int pipe);
   227	
   228		/**
   229		 * @get_scanout_position:
   230		 *
   231		 * Called by vblank timestamping code.
   232		 *
   233		 * Returns the current display scanout position from a crtc, and an
   234		 * optional accurate ktime_get() timestamp of when position was
   235		 * measured. Note that this is a helper callback which is only used if a
   236		 * driver uses drm_calc_vbltimestamp_from_scanoutpos() for the
   237		 * @get_vblank_timestamp callback.
   238		 *
   239		 * Parameters:
   240		 *
   241		 * dev:
   242		 *     DRM device.
   243		 * pipe:
   244		 *     Id of the crtc to query.
   245		 * in_vblank_irq:
   246		 *     True when called from drm_crtc_handle_vblank().  Some drivers
   247		 *     need to apply some workarounds for gpu-specific vblank irq quirks
   248		 *     if flag is set.
   249		 * vpos:
   250		 *     Target location for current vertical scanout position.
   251		 * hpos:
   252		 *     Target location for current horizontal scanout position.
   253		 * stime:
   254		 *     Target location for timestamp taken immediately before
   255		 *     scanout position query. Can be NULL to skip timestamp.
   256		 * etime:
   257		 *     Target location for timestamp taken immediately after
   258		 *     scanout position query. Can be NULL to skip timestamp.
   259		 * mode:
   260		 *     Current display timings.
   261		 *
   262		 * Returns vpos as a positive number while in active scanout area.
   263		 * Returns vpos as a negative number inside vblank, counting the number
   264		 * of scanlines to go until end of vblank, e.g., -1 means "one scanline
   265		 * until start of active scanout / end of vblank."
   266		 *
   267		 * Returns:
   268		 *
   269		 * True on success, false if a reliable scanout position counter could
   270		 * not be read out.
   271		 *
   272		 * FIXME:
   273		 *
   274		 * Since this is a helper to implement @get_vblank_timestamp, we should
   275		 * move it to &struct drm_crtc_helper_funcs, like all the other
   276		 * helper-internal hooks.
   277		 */
   278		bool (*get_scanout_position) (struct drm_device *dev, unsigned int pipe,
   279					      bool in_vblank_irq, int *vpos, int *hpos,
   280					      ktime_t *stime, ktime_t *etime,
   281					      const struct drm_display_mode *mode);
   282	
   283		/**
   284		 * @get_vblank_timestamp:
   285		 *
   286		 * Called by drm_get_last_vbltimestamp(). Should return a precise
   287		 * timestamp when the most recent VBLANK interval ended or will end.
   288		 *
   289		 * Specifically, the timestamp in @vblank_time should correspond as
   290		 * closely as possible to the time when the first video scanline of
   291		 * the video frame after the end of VBLANK will start scanning out,
   292		 * the time immediately after end of the VBLANK interval. If the
   293		 * @crtc is currently inside VBLANK, this will be a time in the future.
   294		 * If the @crtc is currently scanning out a frame, this will be the
   295		 * past start time of the current scanout. This is meant to adhere
   296		 * to the OpenML OML_sync_control extension specification.
   297		 *
   298		 * Paramters:
   299		 *
   300		 * dev:
   301		 *     dev DRM device handle.
   302		 * pipe:
   303		 *     crtc for which timestamp should be returned.
   304		 * max_error:
   305		 *     Maximum allowable timestamp error in nanoseconds.
   306		 *     Implementation should strive to provide timestamp
   307		 *     with an error of at most max_error nanoseconds.
   308		 *     Returns true upper bound on error for timestamp.
   309		 * vblank_time:
   310		 *     Target location for returned vblank timestamp.
   311		 * in_vblank_irq:
   312		 *     True when called from drm_crtc_handle_vblank().  Some drivers
   313		 *     need to apply some workarounds for gpu-specific vblank irq quirks
   314		 *     if flag is set.
   315		 *
   316		 * Returns:
   317		 *
   318		 * True on success, false on failure, which means the core should
   319		 * fallback to a simple timestamp taken in drm_crtc_handle_vblank().
   320		 *
   321		 * FIXME:
   322		 *
   323		 * We should move this hook to &struct drm_crtc_funcs like all the other
   324		 * vblank hooks.
   325		 */
   326		bool (*get_vblank_timestamp) (struct drm_device *dev, unsigned int pipe,
   327					     int *max_error,
   328					     ktime_t *vblank_time,
   329					     bool in_vblank_irq);
   330	
   331		/**
   332		 * @irq_handler:
   333		 *
   334		 * Interrupt handler called when using drm_irq_install(). Not used by
   335		 * drivers which implement their own interrupt handling.
   336		 */
   337		irqreturn_t(*irq_handler) (int irq, void *arg);
   338	
   339		/**
   340		 * @irq_preinstall:
   341		 *
   342		 * Optional callback used by drm_irq_install() which is called before
   343		 * the interrupt handler is registered. This should be used to clear out
   344		 * any pending interrupts (from e.g. firmware based drives) and reset
   345		 * the interrupt handling registers.
   346		 */
   347		void (*irq_preinstall) (struct drm_device *dev);
   348	
   349		/**
   350		 * @irq_postinstall:
   351		 *
   352		 * Optional callback used by drm_irq_install() which is called after
   353		 * the interrupt handler is registered. This should be used to enable
   354		 * interrupt generation in the hardware.
   355		 */
   356		int (*irq_postinstall) (struct drm_device *dev);
   357	
   358		/**
   359		 * @irq_uninstall:
   360		 *
   361		 * Optional callback used by drm_irq_uninstall() which is called before
   362		 * the interrupt handler is unregistered. This should be used to disable
   363		 * interrupt generation in the hardware.
   364		 */
   365		void (*irq_uninstall) (struct drm_device *dev);
   366	
   367		/**
   368		 * @master_create:
   369		 *
   370		 * Called whenever a new master is created. Only used by vmwgfx.
   371		 */
   372		int (*master_create)(struct drm_device *dev, struct drm_master *master);
   373	
   374		/**
   375		 * @master_destroy:
   376		 *
   377		 * Called whenever a master is destroyed. Only used by vmwgfx.
   378		 */
   379		void (*master_destroy)(struct drm_device *dev, struct drm_master *master);
   380	
   381		/**
   382		 * @master_set:
   383		 *
   384		 * Called whenever the minor master is set. Only used by vmwgfx.
   385		 */
   386		int (*master_set)(struct drm_device *dev, struct drm_file *file_priv,
   387				  bool from_open);
   388		/**
   389		 * @master_drop:
   390		 *
   391		 * Called whenever the minor master is dropped. Only used by vmwgfx.
   392		 */
   393		void (*master_drop)(struct drm_device *dev, struct drm_file *file_priv);
   394	
   395		/**
   396		 * @debugfs_init:
   397		 *
   398		 * Allows drivers to create driver-specific debugfs files.
   399		 */
   400		int (*debugfs_init)(struct drm_minor *minor);
   401	
   402		/**
   403		 * @gem_free_object: deconstructor for drm_gem_objects
   404		 *
   405		 * This is deprecated and should not be used by new drivers. Use
   406		 * @gem_free_object_unlocked instead.
   407		 */
   408		void (*gem_free_object) (struct drm_gem_object *obj);
   409	
   410		/**
   411		 * @gem_free_object_unlocked: deconstructor for drm_gem_objects
   412		 *
   413		 * This is for drivers which are not encumbered with &drm_device.struct_mutex
   414		 * legacy locking schemes. Use this hook instead of @gem_free_object.
   415		 */
   416		void (*gem_free_object_unlocked) (struct drm_gem_object *obj);
   417	
   418		/**
   419		 * @gem_open_object:
   420		 *
   421		 * Driver hook called upon gem handle creation
   422		 */
   423		int (*gem_open_object) (struct drm_gem_object *, struct drm_file *);
   424	
   425		/**
   426		 * @gem_close_object:
   427		 *
   428		 * Driver hook called upon gem handle release
   429		 */
   430		void (*gem_close_object) (struct drm_gem_object *, struct drm_file *);
   431	
   432		/**
   433		 * @gem_print_info:
   434		 *
   435		 * If driver subclasses struct &drm_gem_object, it can implement this
   436		 * optional hook for printing additional driver specific info.
   437		 *
   438		 * drm_printf_indent() should be used in the callback passing it the
   439		 * indent argument.
   440		 *
   441		 * This callback is called from drm_gem_print_info().
   442		 */
   443		void (*gem_print_info)(struct drm_printer *p, unsigned int indent,
   444				       const struct drm_gem_object *obj);
   445	
   446		/**
   447		 * @gem_create_object: constructor for gem objects
   448		 *
   449		 * Hook for allocating the GEM object struct, for use by core
   450		 * helpers.
   451		 */
   452		struct drm_gem_object *(*gem_create_object)(struct drm_device *dev,
   453							    size_t size);
   454	
   455		/* prime: */
   456		/**
   457		 * @prime_handle_to_fd:
   458		 *
   459		 * export handle -> fd (see drm_gem_prime_handle_to_fd() helper)
   460		 */
   461		int (*prime_handle_to_fd)(struct drm_device *dev, struct drm_file *file_priv,
   462					uint32_t handle, uint32_t flags, int *prime_fd);
   463		/**
   464		 * @prime_fd_to_handle:
   465		 *
   466		 * import fd -> handle (see drm_gem_prime_fd_to_handle() helper)
   467		 */
   468		int (*prime_fd_to_handle)(struct drm_device *dev, struct drm_file *file_priv,
   469					int prime_fd, uint32_t *handle);
   470		/**
   471		 * @gem_prime_export:
   472		 *
   473		 * export GEM -> dmabuf
   474		 */
   475		struct dma_buf * (*gem_prime_export)(struct drm_device *dev,
   476					struct drm_gem_object *obj, int flags);
   477		/**
   478		 * @gem_prime_import:
   479		 *
   480		 * import dmabuf -> GEM
   481		 */
   482		struct drm_gem_object * (*gem_prime_import)(struct drm_device *dev,
   483					struct dma_buf *dma_buf);
   484		int (*gem_prime_pin)(struct drm_gem_object *obj);
   485		void (*gem_prime_unpin)(struct drm_gem_object *obj);
   486		struct reservation_object * (*gem_prime_res_obj)(
   487					struct drm_gem_object *obj);
   488		struct sg_table *(*gem_prime_get_sg_table)(struct drm_gem_object *obj);
   489		struct drm_gem_object *(*gem_prime_import_sg_table)(
   490					struct drm_device *dev,
   491					struct dma_buf_attachment *attach,
   492					struct sg_table *sgt);
   493		int (*gem_prime_begin_cpu_access)(struct drm_gem_object *obj,
 > 494						   enum dma_data_direction direction);
   495		void *(*gem_prime_vmap)(struct drm_gem_object *obj);
   496		void (*gem_prime_vunmap)(struct drm_gem_object *obj, void *vaddr);
   497		int (*gem_prime_mmap)(struct drm_gem_object *obj,
   498					struct vm_area_struct *vma);
   499	
   500		/**
   501		 * @dumb_create:
   502		 *
   503		 * This creates a new dumb buffer in the driver's backing storage manager (GEM,
   504		 * TTM or something else entirely) and returns the resulting buffer handle. This
   505		 * handle can then be wrapped up into a framebuffer modeset object.
   506		 *
   507		 * Note that userspace is not allowed to use such objects for render
   508		 * acceleration - drivers must create their own private ioctls for such a use
   509		 * case.
   510		 *
   511		 * Width, height and depth are specified in the &drm_mode_create_dumb
   512		 * argument. The callback needs to fill the handle, pitch and size for
   513		 * the created buffer.
   514		 *
   515		 * Called by the user via ioctl.
   516		 *
   517		 * Returns:
   518		 *
   519		 * Zero on success, negative errno on failure.
   520		 */
   521		int (*dumb_create)(struct drm_file *file_priv,
   522				   struct drm_device *dev,
   523				   struct drm_mode_create_dumb *args);
   524		/**
   525		 * @dumb_map_offset:
   526		 *
   527		 * Allocate an offset in the drm device node's address space to be able to
   528		 * memory map a dumb buffer. GEM-based drivers must use
   529		 * drm_gem_create_mmap_offset() to implement this.
   530		 *
   531		 * Called by the user via ioctl.
   532		 *
   533		 * Returns:
   534		 *
   535		 * Zero on success, negative errno on failure.
   536		 */
   537		int (*dumb_map_offset)(struct drm_file *file_priv,
   538				       struct drm_device *dev, uint32_t handle,
   539				       uint64_t *offset);
   540		/**
   541		 * @dumb_destroy:
   542		 *
   543		 * This destroys the userspace handle for the given dumb backing storage buffer.
   544		 * Since buffer objects must be reference counted in the kernel a buffer object
   545		 * won't be immediately freed if a framebuffer modeset object still uses it.
   546		 *
   547		 * Called by the user via ioctl.
   548		 *
   549		 * Returns:
   550		 *
   551		 * Zero on success, negative errno on failure.
   552		 */
   553		int (*dumb_destroy)(struct drm_file *file_priv,
   554				    struct drm_device *dev,
   555				    uint32_t handle);
   556	
   557		/**
   558		 * @gem_vm_ops: Driver private ops for this object
   559		 */
   560		const struct vm_operations_struct *gem_vm_ops;
   561	
   562		/** @major: driver major number */
   563		int major;
   564		/** @minor: driver minor number */
   565		int minor;
   566		/** @patchlevel: driver patch level */
   567		int patchlevel;
   568		/** @name: driver name */
   569		char *name;
   570		/** @desc: driver description */
   571		char *desc;
   572		/** @date: driver date */
   573		char *date;
   574	
   575		/** @driver_features: driver features */
   576		u32 driver_features;
   577	
   578		/**
   579		 * @ioctls:
   580		 *
   581		 * Array of driver-private IOCTL description entries. See the chapter on
   582		 * :ref:`IOCTL support in the userland interfaces
   583		 * chapter<drm_driver_ioctl>` for the full details.
   584		 */
   585	
   586		const struct drm_ioctl_desc *ioctls;
   587		/** @num_ioctls: Number of entries in @ioctls. */
   588		int num_ioctls;
   589	
   590		/**
   591		 * @fops:
   592		 *
   593		 * File operations for the DRM device node. See the discussion in
   594		 * :ref:`file operations<drm_driver_fops>` for in-depth coverage and
   595		 * some examples.
   596		 */
   597		const struct file_operations *fops;
   598	
   599		/* Everything below here is for legacy driver, never use! */
   600		/* private: */
   601	
   602		/* List of devices hanging off this driver with stealth attach. */
   603		struct list_head legacy_dev_list;
   604		int (*firstopen) (struct drm_device *);
   605		void (*preclose) (struct drm_device *, struct drm_file *file_priv);
   606		int (*dma_ioctl) (struct drm_device *dev, void *data, struct drm_file *file_priv);
   607		int (*dma_quiescent) (struct drm_device *);
   608		int (*context_dtor) (struct drm_device *dev, int context);
   609		int dev_priv_size;
   610	};
   611	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Rdr/H9bAscbyyQEA

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--mYCpIKhGyMATD0i+--
